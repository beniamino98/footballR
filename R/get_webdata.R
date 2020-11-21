

#'@title get_webdata 
#'@description base function to get in a clean way the data availables on \href{https://www.football-data.co.uk}{football-uk}. 
#'@param country character. One of the available countries. See  \code{info_country}.
#'@param division character. One of the available divisions See  \code{info_divisions}.
#'@param year character. The year for which you want to import the data. 
#'@param raw logical. If TRUE will be applied a function to reduce and rename the variables, 
#'                    otherwise it will return the original data.frame.
#'@param quiet logical. When TRUE function evalueates without displaying customary messages.
#'@name get_webdata
#'@rdname get_webdata
#'@return tibble

get_webdata <- function( country = NULL, division = "div1", year = 2020, raw = FALSE, quiet = FALSE){
  

  clean_football_data <- function(df = NULL){
    
    
    # dichiarazione variabili di interesse 
    variables_codex <- list(
      
      Div = "division",
      Time = "time",
      Date = "date",
      HomeTeam = "home_team",
      AwayTeam = "away_team",
      HTHG = "home_goal_1T",
      FTHG = "home_goal_2T",
      HTAG = "away_goal_1T",
      FTAG = "away_goal_2T",
      HTR = "result_1T",
      FTR = "result_2T",
      
      HS  = "home_shots",
      HST = "home_target_shots",
      HC = "home_corners",
      HY = "home_yellow",
      HR = "home_red",
      AS  = "away_shots",
      AST = "away_target_shots",
      AC = "away_corners",
      AY = "away_yellow",
      AR = "away_red",
      
      B365H = "home_quote",
      B365D = "drow_quote",
      B365A = "away_quote"
      
    )
    
    # standardizzation for double names (see variables_notes) 
    # first case:  HG = FTHG
    # second case: AG = FTAG
    
    standard_condition_hg <- sum(colnames(df) %in% "HG")
    
    if( standard_condition_hg == 1 ){
      
      colnames(df)[standard_condition_hg] <- "FTHG" 
      
    }
    
    standard_condition_ag <- sum(colnames(df) %in% "AG")
    
    if( standard_condition_ag == 1 ){
      
      colnames(df)[standard_condition_ag] <- "FTAG" 
      
    }
    
    
    # inizializzation of an empty matrix with: 
    # nrow = nrow of the input dataframe
    # ncol = number of variables in the codex 
    empty_df <- matrix(nrow = nrow(df), ncol = length(variables_codex))
    empty_df <- as.data.frame(empty_df )
    
    # original name of the input dataset 
    original_variables  <- colnames(df)     
    
    # selected original variables to rename
    selected_variables  <- names(variables_codex)
    
    # new names for the new selected variables 
    new_variables       <- unlist(variables_codex) 
    
    
    # ciclo per identificare le variabili di interesse e inserimento in un dataframe standardizzato 
    for(i in 1:length(original_variables)){
      
      index <- which(original_variables %in% selected_variables[i])
      
      if(!purrr::is_empty(index)){
        empty_df[,i] <- df[,index]
      }
    }
    
    # rinomino le colonne con i nomi precedentemente selezionati e la converto in tibble 
    colnames(empty_df) <- new_variables
    
    
    output <- dplyr::as_tibble(empty_df)
    
    
    
    # effettuo alcune modifiche e inserisco delle nuove variabili costruite a partire da quelle di interesse 
    
    output <- dplyr::mutate(output, 
                            home_team = as.character(home_team),
                            away_team = as.character(away_team),
                            home_goal_2T = as.integer(home_goal_2T),
                            home_goal_1T = as.integer(home_goal_1T),
                            away_goal_2T = as.integer(away_goal_2T),
                            away_goal_1T = as.integer(away_goal_1T),
                            home_shots = as.integer(home_shots),
                            home_target_shots = as.integer(home_target_shots),
                            home_corners = as.integer(home_corners),
                            home_yellow = as.integer(home_yellow),
                            home_red = as.integer(home_red), 
                            away_shots = as.integer(away_shots),
                            away_target_shots = as.integer(away_target_shots),
                            away_corners = as.integer(away_corners),
                            away_yellow = as.integer(away_yellow),
                            away_red = as.integer(away_red), 
                            home_quote = as.double(home_quote),
                            drow_quote = as.double(drow_quote),
                            away_quote = as.double(away_quote)
    )
    
    output <- dplyr::filter(output, !is.na(home_goal_2T) & !is.na(away_goal_2T) & !is.na(home_goal_1T & !is.na(away_goal_1T) ))
    
    output <- dplyr::mutate(output,
                            "date" = as.character(lubridate::dmy(date)),
                            
                            "over0.5" = ifelse( (home_goal_2T + away_goal_2T) > 0, 1, 0 ),
                            "over1.5" = ifelse( (home_goal_2T + away_goal_2T) > 1, 1, 0 ),
                            "over2.5" = ifelse( (home_goal_2T + away_goal_2T) > 2, 1, 0 ),
                            "over3.5" = ifelse( (home_goal_2T + away_goal_2T) > 3, 1, 0 ),
                            "over4.5" = ifelse( (home_goal_2T + away_goal_2T) > 4, 1, 0 ),
                            "over5.5" = ifelse( (home_goal_2T + away_goal_2T) > 5, 1, 0 ),
                            
                            "under0.5" = ifelse( (home_goal_2T + away_goal_2T) < 1, 1, 0 ),
                            "under1.5" = ifelse( (home_goal_2T + away_goal_2T) < 2, 1, 0 ),
                            "under2.5" = ifelse( (home_goal_2T + away_goal_2T) < 3, 1, 0 ),
                            "under3.5" = ifelse( (home_goal_2T + away_goal_2T) < 4, 1, 0 ),
                            "under4.5" = ifelse( (home_goal_2T + away_goal_2T) < 5, 1, 0 ),
                            "under5.5" = ifelse( (home_goal_2T + away_goal_2T) < 6, 1, 0 ),
                            
                            "winHome" = ifelse(result_2T == "H", 1,0),
                            "winAway" = ifelse(result_2T == "A", 1,0),
                            "isGoal_1T" = ifelse(home_goal_1T == 0 | away_goal_1T == 0, 0,1),
                            "isGoal_2T" = ifelse(home_goal_2T == 0 | away_goal_2T == 0, 0,1)
                            
    )
    
    output <- na_if(output)
    
    output$season <- paste0(unique(lubridate::year(lubridate::ymd(output$date))), collapse = "-")
    
    return(output)
    
  }
  
  
  supported.country <-list(
    england     =  c(premier = "E0", championship = "E1", div1 = "E2", div2 = "E3"  ),
    scotland    =  c(premier = "SC0", div1 = "SC1", div2 = "SC2", div3 = "SC3"),
    germany     =  c( div1 = "D1",  div2 = "D2" ),
    italy       =  c( div1 = "I1",  div2 = "I2" ),
    spain       =  c( div1 = "SP1", div2 = "SP2"),
    france      =  c( div1 = "F1",  div2 = "F2" ),
    netherlands =  c( div1 = "N1" ),
    belgium     =  c( div1 = "B1"),
    portugal    =  c( div1 = "P1" ),
    turkey      =  c( div1 = "T1" ),
    greece      =  c( div1 = "G1" )
  )
  
  last.year <- 21
  
  year <- as.character(year)
  
  supported.year <- c( paste0(seq(90,98,1), seq(91,99,1)),"0000",
                       paste0("0",seq(0,8,1),"0",seq(1,9,1)),"0910",
                       paste0(seq(10,(last.year-1),1), seq(11,last.year,1)) )
  
  
  names(supported.year)<- seq(1990 , as.numeric(paste0("20",last.year-1)))
  
  
  # matching arguments 
  
  match.country <- match.arg(country, names(supported.country))
  match.year    <- match.arg(year, names( supported.year ))
  match.div     <- supported.country[[match.country]]
  match.div     <- match.arg(division, names(match.div))
  
  
  # creating paths 
  path.year <- supported.year[[match.year]]
  path.file <- paste0(supported.country[[match.country]] [[match.div]] ,".csv")
  
  # creating url 
  url.file <- httr::modify_url("https://www.football-data.co.uk", path = c("mmz4281", path.year, path.file))
  
  # importing file 
  file.get <- RCurl::getURL(url.file)
  file.csv <- read.csv(textConnection(file.get))
  file.tbl <- dplyr::tbl_df(file.csv)
  
  # importation message 
  if(!quiet) message("Importation of: ", match.country, " ", match.year, " ",match.div,  " done!")
  
  # output file 
  if(raw) return(file.tbl)
  
  file.tbl <- clean_football_data(file.tbl)
  
  # inserimento variabili di riconoscimento 
  file.tbl$country <- country
  file.tbl$year <- year 
  file.tbl$division <- division
  
  file.tbl <- dplyr::select(file.tbl, country,division, season, year, dplyr::everything())
  
  return(file.tbl)
  
}



