#' Italian Serie A example data
#'
#' A small offline sample of Italian Serie A match results derived from
#' football-data.co.uk CSV files.
#'
#' @format A tibble with 50 rows and 45 columns:
#' \describe{
#'   \item{country, division}{Competition identifiers. `country` is `"italy"`
#'   and `division` is `"div1"`.}
#'   \item{season, year}{Season label and season-ending year. Included seasons
#'   are 2018-2019, 2019-2020, 2020-2021, 2021-2022, and the available portion
#'   of 2022-2023.}
#'   \item{date}{Match date and time as a POSIXct value in UTC.}
#'   \item{home_team, away_team}{Home and away team names.}
#'   \item{home_goals_1h, away_goals_1h}{Half-time home and away goals.}
#'   \item{home_goals_ft, away_goals_ft}{Full-time home and away goals.}
#'   \item{result_1h, result_ft}{Half-time and full-time result codes:
#'   `"H"`, `"D"`, or `"A"`.}
#'   \item{home_shots, home_shots_target, home_corners, home_yellow_cards,
#'   home_red_cards}{Home team match statistics.}
#'   \item{away_shots, away_shots_target, away_corners, away_yellow_cards,
#'   away_red_cards}{Away team match statistics.}
#'   \item{home_quote, draw_quote, drow_quote, away_quote}{Bet365 home, draw,
#'   and away odds. `drow_quote` is retained as a compatibility alias for the
#'   corrected `draw_quote` column.}
#'   \item{total_goals_1h, total_goals_ft, goal_1h, goal_ft, btts_1h, btts_ft,
#'   home_win, draw, away_win, home_points, away_points,
#'   goal_difference}{Derived football outcome variables.}
#'   \item{under0.5, under1.5, under2.5, under3.5, under4.5, under5.5}{Indicators
#'   for total full-time goals below each threshold.}
#' }
#'
#' @details
#' The source is the public CSV archive at <https://www.football-data.co.uk>.
#' The site's CSV files are free to download, but explicit redistribution terms
#' for bundling full datasets were not found during package preparation.
#' Therefore this object is a small representative sample for documentation,
#' examples, and tests. The reproducible script for rebuilding the example data
#' is in `data-raw/serieA.R`.
#'
#' @source <https://www.football-data.co.uk/italym.php>
"serieA"

