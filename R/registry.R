#' Supported football-data.co.uk countries
#'
#' @return A character vector of supported country identifiers.
#'
#' @examples
#' ftuk_countries()
#'
#' @export
ftuk_countries <- function() {
  unique(.ftuk_league_registry()$country)
}

#' Supported football-data.co.uk divisions
#'
#' @param country Character scalar. A supported country.
#'
#' @return A tibble with `country`, `division`, `code`, `label`, `first_year`,
#'   and `last_year` columns.
#'
#' @examples
#' ftuk_divisions("italy")
#'
#' @export
ftuk_divisions <- function(country) {
  country <- .ftuk_validate_country(country)
  country_value <- country
  registry <- .ftuk_league_registry()
  dplyr::filter(registry, .data$country == country_value)
}

#' Supported football-data.co.uk seasons
#'
#' @return A tibble with season-ending `year`, `season`, and football-data.co.uk
#'   `code`. For example, `year = 2024` means season 2023-2024.
#'
#' @examples
#' tail(ftuk_seasons())
#'
#' @export
ftuk_seasons <- function() {
  years <- .ftuk_supported_years()
  tibble::tibble(
    year = years,
    season = paste0(years - 1L, "-", years),
    code = vapply(years, .ftuk_season_code, character(1))
  )
}

.ftuk_league_registry <- function() {
  first_year <- 1994L
  last_year <- max(.ftuk_supported_years())

  tibble::tribble(
    ~country, ~division, ~code, ~label, ~first_year, ~last_year,
    "england", "premier", "E0", "Premier League", first_year, last_year,
    "england", "championship", "E1", "Championship", first_year, last_year,
    "england", "div1", "E2", "League One", first_year, last_year,
    "england", "div2", "E3", "League Two", first_year, last_year,
    "scotland", "premier", "SC0", "Scottish Premiership", first_year, last_year,
    "scotland", "div1", "SC1", "Scottish Championship", first_year, last_year,
    "scotland", "div2", "SC2", "Scottish League One", first_year, last_year,
    "scotland", "div3", "SC3", "Scottish League Two", first_year, last_year,
    "germany", "div1", "D1", "Bundesliga", first_year, last_year,
    "germany", "div2", "D2", "2. Bundesliga", first_year, last_year,
    "italy", "div1", "I1", "Serie A", first_year, last_year,
    "italy", "div2", "I2", "Serie B", first_year, last_year,
    "spain", "div1", "SP1", "La Liga", first_year, last_year,
    "spain", "div2", "SP2", "Segunda Division", first_year, last_year,
    "france", "div1", "F1", "Ligue 1", first_year, last_year,
    "france", "div2", "F2", "Ligue 2", first_year, last_year,
    "netherlands", "div1", "N1", "Eredivisie", first_year, last_year,
    "belgium", "div1", "B1", "Belgian Pro League", first_year, last_year,
    "portugal", "div1", "P1", "Primeira Liga", first_year, last_year,
    "turkey", "div1", "T1", "Super Lig", first_year, last_year,
    "greece", "div1", "G1", "Super League Greece", first_year, last_year
  )
}

.ftuk_supported_years <- function() {
  seq.int(1994L, as.integer(format(Sys.Date(), "%Y")) - 1L)
}

.ftuk_validate_country <- function(country, allow_all = FALSE) {
  supported <- unique(.ftuk_league_registry()$country)

  if (!is.character(country) || length(country) != 1L || is.na(country)) {
    stop("`country` must be one non-missing character value.", call. = FALSE)
  }

  country <- tolower(country)
  if (allow_all && identical(country, "all")) {
    return(country)
  }

  if (!country %in% supported) {
    stop(
      "`country` must be one of: ",
      paste(supported, collapse = ", "),
      ".",
      call. = FALSE
    )
  }

  country
}

.ftuk_validate_division <- function(country, division, allow_all = FALSE) {
  country <- .ftuk_validate_country(country)
  supported <- ftuk_divisions(country)$division

  if (!is.character(division) || length(division) != 1L || is.na(division)) {
    stop("`division` must be one non-missing character value.", call. = FALSE)
  }

  division <- tolower(division)
  if (allow_all && identical(division, "all")) {
    return(division)
  }

  if (!division %in% supported) {
    stop(
      "`division` must be valid for `country = \"",
      country,
      "\"`. Supported divisions are: ",
      paste(supported, collapse = ", "),
      ".",
      call. = FALSE
    )
  }

  division
}

.ftuk_validate_year <- function(year) {
  if (!is.numeric(year) || length(year) != 1L || is.na(year)) {
    stop("`year` must be one non-missing numeric season-ending year.", call. = FALSE)
  }

  if (year != as.integer(year)) {
    stop("`year` must be a whole season-ending year.", call. = FALSE)
  }

  year <- as.integer(year)
  supported <- .ftuk_supported_years()

  if (!year %in% supported) {
    stop(
      "`year` must be between ",
      min(supported),
      " and ",
      max(supported),
      ".",
      call. = FALSE
    )
  }

  year
}

.ftuk_validate_years <- function(years) {
  if (!is.numeric(years) || !length(years) %in% c(1L, 2L) || anyNA(years)) {
    stop("`years` must be a numeric vector of length 1 or 2.", call. = FALSE)
  }

  if (any(years != as.integer(years))) {
    stop("`years` must contain whole season-ending years.", call. = FALSE)
  }

  years <- as.integer(years)
  if (length(years) == 1L) {
    years <- c(years, years)
  }

  if (years[1L] > years[2L]) {
    stop("`years` must be ordered from first to last season-ending year.", call. = FALSE)
  }

  seq_years <- seq.int(years[1L], years[2L])
  invisible(vapply(seq_years, .ftuk_validate_year, integer(1)))
  years
}

.ftuk_validate_logical <- function(x, arg) {
  if (!is.logical(x) || length(x) != 1L || is.na(x)) {
    stop("`", arg, "` must be TRUE or FALSE.", call. = FALSE)
  }
  x
}

.ftuk_season_code <- function(year) {
  year <- .ftuk_validate_year(year)
  sprintf("%02d%02d", (year - 1L) %% 100L, year %% 100L)
}

.ftuk_season_label <- function(year) {
  year <- .ftuk_validate_year(year)
  paste0(year - 1L, "-", year)
}
