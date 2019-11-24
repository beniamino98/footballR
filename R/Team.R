#'@title Team
#'@description filter data 
#'@param .data the data 
#'@param team character the team 
#'@param year vector, the years 
#'@param vs   vector, the other teams 
#'@param away logical, if TRUE all match away 
#'@param home logical, if TRUE all match in home 
#'


Team <- function(.data, team = NULL, year = NULL, vs = NULL, away = FALSE, home = FALSE ){
  
  
   if( sum(c("home_team", "away_team") %in% names(.data)) == 2  ) {
     .data_tbl <- force(.data)
   } else {
     .data_tbl <- clean_football(force(.data))
   }
  
  
  
  
  if (!is.null(team) ){
    
    first.case_up <- toupper(stringr::str_extract(team, "^[a-z]"))
    team <- stringr::str_replace(team, "^[a-z]", first.case_up)
    
    if ( !away & !home ){
      
      .data_tbl <- dplyr::filter(.data_tbl, .data_tbl$away_team == team | .data_tbl$home_team == team )
      
      
    } else if ( away  &  !home ){
      
      .data_tbl <- dplyr::select(.data_tbl, "division", "date", "year", 
                                 dplyr::contains("team"),
                                 dplyr::contains("away") )
      .data_tbl <- dplyr::filter(.data_tbl, .data_tbl$away_team == team )
      
      
    } else if ( !away &  home  ){
      
      .data_tbl <- dplyr::select(.data_tbl, "division", "date", "year", 
                                 dplyr::contains("team"),
                                 dplyr::contains("home") )
      
      .data_tbl <- dplyr::filter(.data_tbl, .data_tbl$home_team == team)
      
    } else {
      
      .data_tbl <- dplyr::filter(.data_tbl, .data_tbl$away_team == team | .data_tbl$home_team == team )
    }

  }
 
  if(!is.null(vs)){
    
    vs.search  <- match.arg(vs, c(unique(.data_tbl$home_team),unique(.data_tbl$away_team)) , several.ok = TRUE)
    
    .data_tbl <- dplyr::filter(.data_tbl, .data_tbl$home_team %in% c( vs.search ) | .data_tbl$away_team %in% c( vs.search )  )
    
  } 
  
  
  if(!is.null(year)){
    
    year.search  <- match.arg(year, unique(.data_tbl$year), several.ok = TRUE)
    
    .data_tbl <- dplyr::filter(.data_tbl, .data_tbl$year  %in% c(year.search) )
    
  } 
  
  
  return(.data_tbl)
  
  
}
