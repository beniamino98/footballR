#' Clean football-data.co.uk match data
#'
#' Standardise a parsed football-data.co.uk CSV to stable column names and add
#' clear football outcome variables.
#'
#' @param data A data frame or tibble created from a football-data.co.uk CSV.
#' @param country Optional supported country identifier.
#' @param division Optional supported division identifier.
#' @param year Optional season-ending year. For example, `year = 2024` means
#'   season 2023-2024.
#'
#' @details
#' `ftuk_clean()` accepts older and newer football-data.co.uk schemas. It
#' handles `HG`/`AG` as aliases for `FTHG`/`FTAG`, missing or partially missing
#' `Time`, and missing optional statistics or odds columns.
#'
#' The returned odds columns are quoted prices. The function does not compute
#' implied probabilities.
#'
#' `draw_quote` is the corrected Bet365 draw-odds column. The legacy misspelled
#' `drow_quote` column is retained as a compatibility alias.
#'
#' @return A tibble with standardised columns and derived variables including
#'   `total_goals_1h`, `total_goals_ft`, `goal_1h`, `goal_ft`, `btts_1h`,
#'   `btts_ft`, match result indicators, points, goal difference, and under-goal
#'   market indicators.
#'
#' @seealso [ftuk_read()], [ftuk_download()], [serieA]
#'
#' @examples
#' raw_match <- tibble::tibble(
#'   Date = "13/08/2022",
#'   HomeTeam = "Milan",
#'   AwayTeam = "Udinese",
#'   HTHG = 2,
#'   FTHG = 4,
#'   HTAG = 2,
#'   FTAG = 2
#' )
#' ftuk_clean(raw_match, country = "italy", division = "div1", year = 2023)
#'
#' @export
ftuk_clean <- function(data, country = NULL, division = NULL, year = NULL) {
  .ftuk_validate_raw_data(data)

  if (!is.null(country)) {
    country <- .ftuk_validate_country(country)
  }
  if (!is.null(division)) {
    if (is.null(country)) {
      stop("`country` must be supplied when validating `division`.", call. = FALSE)
    }
    division <- .ftuk_validate_division(country, division)
  }
  if (!is.null(year)) {
    year <- .ftuk_validate_year(year)
  }

  out <- .ftuk_standardize_names(data)
  out$date <- .ftuk_parse_datetime(out$date, out$time)
  out$time <- NULL

  if (!is.null(country)) {
    out$country <- country
  }
  if (!is.null(division)) {
    out$division <- division
  }
  if (!is.null(year)) {
    out$year <- year
    out$season <- .ftuk_season_label(year)
  } else {
    first_year <- min(as.integer(format(out$date, "%Y")), na.rm = TRUE)
    out$season <- paste0(first_year, "-", first_year + 1L)
  }

  out <- .ftuk_add_outcomes(out)
  out <- .ftuk_add_goal_markets(out)
  out <- .ftuk_validate_clean_data(out)

  leading <- c("country", "division", "season", "year")
  leading <- leading[leading %in% names(out)]

  dplyr::select(out, dplyr::all_of(leading), dplyr::everything())
}

.ftuk_standardize_names <- function(data) {
  df <- tibble::as_tibble(data)

  if ("HG" %in% names(df) && !"FTHG" %in% names(df)) {
    names(df)[names(df) == "HG"] <- "FTHG"
  }
  if ("AG" %in% names(df) && !"FTAG" %in% names(df)) {
    names(df)[names(df) == "AG"] <- "FTAG"
  }

  schema <- c(
    Div = "division",
    Date = "date",
    Time = "time",
    HomeTeam = "home_team",
    AwayTeam = "away_team",
    HTHG = "home_goals_1h",
    FTHG = "home_goals_ft",
    HTAG = "away_goals_1h",
    FTAG = "away_goals_ft",
    HTR = "result_1h",
    FTR = "result_ft",
    HS = "home_shots",
    HST = "home_shots_target",
    HC = "home_corners",
    HY = "home_yellow_cards",
    HR = "home_red_cards",
    AS = "away_shots",
    AST = "away_shots_target",
    AC = "away_corners",
    AY = "away_yellow_cards",
    AR = "away_red_cards",
    B365H = "home_quote",
    B365D = "draw_quote",
    B365A = "away_quote"
  )

  out <- tibble::tibble(.rows = nrow(df))
  for (source_name in names(schema)) {
    target_name <- unname(schema[[source_name]])
    if (source_name %in% names(df)) {
      out[[target_name]] <- df[[source_name]]
    } else {
      out[[target_name]] <- NA
    }
  }

  out <- dplyr::mutate(
    out,
    division = as.character(.data$division),
    home_team = as.character(.data$home_team),
    away_team = as.character(.data$away_team),
    result_1h = as.character(.data$result_1h),
    result_ft = as.character(.data$result_ft),
    home_goals_1h = readr::parse_number(as.character(.data$home_goals_1h)),
    home_goals_ft = readr::parse_number(as.character(.data$home_goals_ft)),
    away_goals_1h = readr::parse_number(as.character(.data$away_goals_1h)),
    away_goals_ft = readr::parse_number(as.character(.data$away_goals_ft)),
    home_shots = readr::parse_number(as.character(.data$home_shots)),
    home_shots_target = readr::parse_number(as.character(.data$home_shots_target)),
    home_corners = readr::parse_number(as.character(.data$home_corners)),
    home_yellow_cards = readr::parse_number(as.character(.data$home_yellow_cards)),
    home_red_cards = readr::parse_number(as.character(.data$home_red_cards)),
    away_shots = readr::parse_number(as.character(.data$away_shots)),
    away_shots_target = readr::parse_number(as.character(.data$away_shots_target)),
    away_corners = readr::parse_number(as.character(.data$away_corners)),
    away_yellow_cards = readr::parse_number(as.character(.data$away_yellow_cards)),
    away_red_cards = readr::parse_number(as.character(.data$away_red_cards)),
    home_quote = readr::parse_number(as.character(.data$home_quote)),
    draw_quote = readr::parse_number(as.character(.data$draw_quote)),
    drow_quote = .data$draw_quote,
    away_quote = readr::parse_number(as.character(.data$away_quote))
  )

  dplyr::filter(
    out,
    !is.na(.data$home_goals_1h),
    !is.na(.data$home_goals_ft),
    !is.na(.data$away_goals_1h),
    !is.na(.data$away_goals_ft)
  )
}

.ftuk_parse_datetime <- function(date, time = NULL) {
  date_chr <- as.character(date)
  parsed_date <- suppressWarnings(lubridate::dmy(date_chr, quiet = TRUE))
  missing_date <- is.na(parsed_date)

  if (any(missing_date)) {
    parsed_date[missing_date] <- suppressWarnings(lubridate::ymd(date_chr[missing_date], quiet = TRUE))
  }

  if (any(is.na(parsed_date))) {
    stop("`Date` contains values that could not be parsed as dates.", call. = FALSE)
  }

  if (is.null(time)) {
    time <- rep(NA_character_, length(parsed_date))
  }

  time_chr <- as.character(time)
  time_chr[is.na(time_chr) | !nzchar(time_chr)] <- "00:00"
  parsed_time <- suppressWarnings(lubridate::hm(time_chr, quiet = TRUE))
  parsed_time[is.na(parsed_time)] <- lubridate::hm("00:00")

  as.POSIXct(parsed_date, tz = "UTC") + parsed_time
}

.ftuk_add_outcomes <- function(data) {
  dplyr::mutate(
    data,
    total_goals_1h = .data$home_goals_1h + .data$away_goals_1h,
    total_goals_ft = .data$home_goals_ft + .data$away_goals_ft,
    goal_1h = as.integer(.data$total_goals_1h > 0),
    goal_ft = as.integer(.data$total_goals_ft > 0),
    btts_1h = as.integer(.data$home_goals_1h > 0 & .data$away_goals_1h > 0),
    btts_ft = as.integer(.data$home_goals_ft > 0 & .data$away_goals_ft > 0),
    home_win = as.integer(.data$home_goals_ft > .data$away_goals_ft),
    draw = as.integer(.data$home_goals_ft == .data$away_goals_ft),
    away_win = as.integer(.data$home_goals_ft < .data$away_goals_ft),
    home_points = dplyr::case_when(
      .data$home_win == 1L ~ 3L,
      .data$draw == 1L ~ 1L,
      TRUE ~ 0L
    ),
    away_points = dplyr::case_when(
      .data$away_win == 1L ~ 3L,
      .data$draw == 1L ~ 1L,
      TRUE ~ 0L
    ),
    goal_difference = .data$home_goals_ft - .data$away_goals_ft
  )
}

.ftuk_add_goal_markets <- function(data) {
  dplyr::mutate(
    data,
    under0.5 = as.integer(.data$total_goals_ft < 1),
    under1.5 = as.integer(.data$total_goals_ft < 2),
    under2.5 = as.integer(.data$total_goals_ft < 3),
    under3.5 = as.integer(.data$total_goals_ft < 4),
    under4.5 = as.integer(.data$total_goals_ft < 5),
    under5.5 = as.integer(.data$total_goals_ft < 6)
  )
}

.ftuk_validate_raw_data <- function(data) {
  if (is.null(data) || !is.data.frame(data)) {
    stop("`data` must be a data frame or tibble.", call. = FALSE)
  }
  if (nrow(data) == 0L || ncol(data) == 0L) {
    stop("`data` must not be empty.", call. = FALSE)
  }

  names_data <- names(data)
  if ("HG" %in% names_data && !"FTHG" %in% names_data) {
    names_data[names_data == "HG"] <- "FTHG"
  }
  if ("AG" %in% names_data && !"FTAG" %in% names_data) {
    names_data[names_data == "AG"] <- "FTAG"
  }

  required <- c("Date", "HomeTeam", "AwayTeam", "HTHG", "FTHG", "HTAG", "FTAG")
  missing_required <- setdiff(required, names_data)
  if (length(missing_required) > 0L) {
    stop(
      "`data` is missing required football-data.co.uk columns: ",
      paste(missing_required, collapse = ", "),
      ".",
      call. = FALSE
    )
  }

  invisible(data)
}

.ftuk_validate_clean_data <- function(data) {
  required <- c(
    "date", "home_team", "away_team", "home_goals_1h", "away_goals_1h",
    "home_goals_ft", "away_goals_ft", "total_goals_1h", "total_goals_ft",
    "goal_1h", "goal_ft", "btts_1h", "btts_ft", "home_win", "draw",
    "away_win", "home_points", "away_points", "goal_difference"
  )
  missing_required <- setdiff(required, names(data))
  if (length(missing_required) > 0L) {
    stop(
      "Clean data are missing required columns: ",
      paste(missing_required, collapse = ", "),
      ".",
      call. = FALSE
    )
  }
  if (nrow(data) == 0L) {
    stop("Clean data contain no completed matches.", call. = FALSE)
  }
  if (anyNA(data$date)) {
    stop("Clean data contain missing parsed dates.", call. = FALSE)
  }

  tibble::as_tibble(data)
}

