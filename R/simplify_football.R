#'@title simplify_football
#'@param df dataframe to clean
#'@export
simplify_football <- function(df) {

  df <- dplyr::select(df ,
               div = Div,
               date = Date,
               resultT1 = HTR,
               resultT2 = FTR,
               home = HomeTeam,
               away = AwayTeam,
               home1T_goal = HTHG,
               home2T_goal = FTHG,
               away1T_goal = HTAG,
               away2T_goal = FTAG,
               home_quote = B365H,
               drow_quote = B365D,
               away_quote = B365A)

  df <- dplyr::mutate(df ,
               date = as.character(lubridate::dmy(date)),
               year = as.character(lubridate::year(lubridate::ymd(date))) )

  dplyr::select(df, div, date, year, dplyr::everything() )
}
