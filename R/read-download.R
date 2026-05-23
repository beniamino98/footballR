#' Build a football-data.co.uk CSV URL
#'
#' @param country Character scalar. A supported country.
#' @param division Character scalar. A division supported for `country`.
#' @param year Numeric scalar. The season-ending year. For example,
#'   `year = 2024` means season 2023-2024.
#'
#' @return A character scalar URL.
#'
#' @examples
#' ftuk_url("italy", "div1", 2024)
#'
#' @export
ftuk_url <- function(country, division, year) {
  country <- .ftuk_validate_country(country)
  division <- .ftuk_validate_division(country, division)
  year <- .ftuk_validate_year(year)

  registry <- .ftuk_league_registry()
  code <- registry$code[registry$country == country & registry$division == division]
  paste0("https://www.football-data.co.uk/mmz4281/", .ftuk_season_code(year), "/", code, ".csv")
}

#' Read a local football-data.co.uk CSV file
#'
#' @param path Path to a local CSV file.
#' @param country Optional supported country identifier.
#' @param division Optional supported division identifier.
#' @param year Optional season-ending year. For example, `year = 2024` means
#'   season 2023-2024.
#' @param raw Logical scalar. If `TRUE`, return the parsed CSV without cleaning.
#'
#' @return A tibble.
#'
#' @examples
#' csv <- tempfile(fileext = ".csv")
#' writeLines(
#'   paste(
#'     "Date,HomeTeam,AwayTeam,HTHG,FTHG,HTAG,FTAG",
#'     "13/08/2022,Milan,Udinese,2,4,2,2",
#'     sep = "\n"
#'   ),
#'   csv
#' )
#' ftuk_read(csv, country = "italy", division = "div1", year = 2023)
#'
#' @export
ftuk_read <- function(path, country = NULL, division = NULL, year = NULL, raw = FALSE) {
  if (!is.character(path) || length(path) != 1L || is.na(path)) {
    stop("`path` must be one non-missing file path.", call. = FALSE)
  }
  if (!file.exists(path)) {
    stop("`path` does not exist: ", path, call. = FALSE)
  }

  raw <- .ftuk_validate_logical(raw, "raw")

  data <- tryCatch(
    readr::read_csv(path, show_col_types = FALSE, progress = FALSE),
    error = function(e) {
      stop("Could not parse CSV at `", path, "`. ", conditionMessage(e), call. = FALSE)
    }
  )

  if (nrow(data) == 0L || ncol(data) == 0L) {
    stop("CSV at `", path, "` has no rows or columns.", call. = FALSE)
  }

  if (raw) {
    return(tibble::as_tibble(data))
  }

  ftuk_clean(data, country = country, division = division, year = year)
}

#' Download football-data.co.uk match data
#'
#' @param country Character vector. A supported country, or `"all"`.
#' @param division Character vector. A supported division for each selected
#'   country, or `"all"`.
#' @param years Numeric vector of length 1 or 2. Season-ending years to
#'   download. For example, `years = c(2020, 2024)` requests seasons 2019-2020
#'   through 2023-2024.
#' @param raw Logical scalar. If `TRUE`, return parsed CSV rows before cleaning.
#' @param quiet Logical scalar. If `FALSE`, report successful downloads.
#'
#' @details
#' This function requires internet access. Package examples and tests use local
#' files or the [serieA] dataset instead.
#'
#' @return A tibble.
#'
#' @seealso [ftuk_url()], [ftuk_read()], [ftuk_clean()], [serieA]
#'
#' @examples
#' data(serieA)
#' head(serieA)
#'
#' if (interactive()) {
#'   ftuk_download("italy", "div1", years = 2024, quiet = TRUE)
#' }
#'
#' @export
ftuk_download <- function(country = "all",
                          division = "all",
                          years = c(2020, 2024),
                          raw = FALSE,
                          quiet = FALSE) {
  raw <- .ftuk_validate_logical(raw, "raw")
  quiet <- .ftuk_validate_logical(quiet, "quiet")
  years <- .ftuk_validate_years(years)

  countries <- .ftuk_expand_countries(country)

  out <- purrr::map_dfr(countries, function(country_one) {
    divisions <- .ftuk_expand_divisions(country_one, division)
    purrr::map_dfr(divisions, function(division_one) {
      purrr::map_dfr(seq.int(years[1L], years[2L]), function(year_one) {
        url <- ftuk_url(country_one, division_one, year_one)
        tmp <- .ftuk_download_file(url, quiet = quiet)
        if (!quiet) {
          message("Downloaded ", country_one, " ", division_one, " ", year_one, ".")
        }
        ftuk_read(
          tmp,
          country = country_one,
          division = division_one,
          year = year_one,
          raw = raw
        )
      })
    })
  })

  if ("date" %in% names(out)) {
    out <- dplyr::arrange(out, dplyr::desc(.data$date))
  }

  out
}

.ftuk_expand_countries <- function(country) {
  if (!is.character(country) || length(country) < 1L || anyNA(country)) {
    stop("`country` must be a non-missing character vector.", call. = FALSE)
  }
  country <- tolower(country)
  if ("all" %in% country) {
    return(ftuk_countries())
  }
  bad <- setdiff(country, ftuk_countries())
  if (length(bad) > 0L) {
    stop("Unsupported `country`: ", paste(bad, collapse = ", "), ".", call. = FALSE)
  }
  unique(country)
}

.ftuk_expand_divisions <- function(country, division) {
  if (!is.character(division) || length(division) < 1L || anyNA(division)) {
    stop("`division` must be a non-missing character vector.", call. = FALSE)
  }
  division <- tolower(division)
  supported <- ftuk_divisions(country)$division
  if ("all" %in% division) {
    return(supported)
  }
  bad <- setdiff(division, supported)
  if (length(bad) > 0L) {
    stop(
      "Unsupported `division` for `country = \"",
      country,
      "\"`: ",
      paste(bad, collapse = ", "),
      ". Supported divisions are: ",
      paste(supported, collapse = ", "),
      ".",
      call. = FALSE
    )
  }
  unique(division)
}

.ftuk_download_file <- function(url, quiet) {
  tmp <- tempfile(fileext = ".csv")
  tryCatch(
    utils::download.file(url, tmp, mode = "wb", quiet = quiet),
    error = function(e) {
      stop(
        "Could not download `",
        url,
        "`. Check your internet connection or whether the season is available. ",
        conditionMessage(e),
        call. = FALSE
      )
    },
    warning = function(w) {
      stop(
        "Could not download `",
        url,
        "`. The file may be missing or unavailable. ",
        conditionMessage(w),
        call. = FALSE
      )
    }
  )

  if (!file.exists(tmp) || file.info(tmp)$size == 0L) {
    stop("Downloaded CSV is empty: `", url, "`.", call. = FALSE)
  }

  tmp
}

