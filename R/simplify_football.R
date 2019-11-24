#'@title clean_football
#'@param .data dataframe to clean
#'@export 

clean_football <- function(.data) {
  
  .data_tbl <- NA
  codex <- list(
    Div = "division",
    Date = "date",
    HomeTeam = "home_team",
    AwayTeam = "away_team",
    FTHG = "home_goal_2T",
    HG = "home_goal_2T",
    FTAG = "away_goal_2T",
    AG = "away_goal_2T",
    FTR = "result_2T",
    HTHG = "home_goal_1T",
    HTAG = "away_goal_1T",
    HTR = "result_1T",
    HS = "home_shots",
    AS = "away_shots",
    HST = "home_target_shots",
    AST = "away_target_shots",
    HC = "home_corners",
    AC = "away_corners",
    HY = "home_yellow",
    AY = "away_yellow",
    HR = "home_red",
    AR = "away_red",
    B365H = "home_quote",
    B365D = "drow_quote",
    B365A = "away_quote",
    `B365>2.5` = "quote_over2.5",
    `B365<2.5` = "quote_under2.5"
  )
  
  var_in_codex  <-  names(.data) %in% names(codex)
  codex_in_var  <-  names(codex) %in% names(.data)
  
  .data_tbl <- .data[,var_in_codex ]
  
  names(.data_tbl) <- unlist( codex[ codex_in_var ] )
  
  
  .data_tbl <- dplyr::mutate(.data_tbl ,
                      "date" = as.character(lubridate::dmy(date)),
                      "year" = as.character(lubridate::year(lubridate::ymd(date))) )
  
  .data_tbl <- dplyr::select(.data_tbl, "division", "date", "year", dplyr::everything() )
  
  
  if(purrr::is_empty(.data_tbl) || is.na(.data_tbl) ){
    return(.data)
  } else {
    return(.data_tbl)
  }
  
 
}






