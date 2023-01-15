#'@title get_football_uk
#'@description base function to get in a clean way the data availables on \href{https://www.football-data.co.uk}{football-uk}.
#'@param country character. One of the available countries.
#'@param division character. One of the available divisions.
#'@param year character. The year for which you want to import the data.
#'@param raw logical. If TRUE will be applied a function to reduce and rename the variables,
#'                    otherwise it will return the original data.frame.
#'@param quiet logical. When TRUE function evalueates without displaying customary messages.
#'@name get_football_uk
#'@rdname get_football_uk
#'@return tibble

get_football_uk <- function(country = NULL, division = "div1", year = 2020, raw = FALSE, verbose = FALSE){

  supported_country <- list(
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

  # Last Year
  last_year <- lubridate::year(Sys.Date()) - 2000 - 1

  supported_years <- c(paste0(seq(90,98,1), seq(91,99,1)),"9900",
                      paste0("0",seq(0,8,1),"0",seq(1,9,1)),"0910",
                      paste0(seq(10,last_year, 1), seq(11, last_year + 1, 1)) )


  names(supported_years)<- seq(1990 , as.numeric(paste0("20", last_year))) + 1

  # matching arguments
  match_country <- match.arg(tolower(country), choices = names(supported_country))
  match_year    <- match.arg(tolower(year), choices = names(supported_years))
  match_div     <- match.arg(tolower(division), choices = names(supported_country[[match_country]]))
  path_year     <- supported_years[[match_year]]

  # file name
  file_name <- paste0(supported_country[[match_country]][[match_div]] ,".csv")

  # Url file for download
  file_url <- paste0("https://www.football-data.co.uk", "/", "mmz4281", "/",  path_year, "/", file_name)

  # importing file
  file_get <- RCurl::getURL(file_url)
  file_csv <- utils::read.csv(textConnection(file_get))
  file_tbl <- dplyr::as_tibble(file_csv)

  # Messages
  if(verbose) message('Download of: "', match_div, '" (', match_year, ') of "', match_country,  '" done with success!')

  # Raw file (no cleaned)
  if(raw) return(file_tbl)

  file_tbl <- clean_football_uk(x = file_tbl)

  # Insert variables foor Country, Year and Division
  file_tbl$country <- country
  file_tbl$year <- year
  file_tbl$division <- division

  # Reordering the variables
  file_tbl <- dplyr::select(file_tbl, country, division, season, year, dplyr::everything())

  return(file_tbl)

}

#'@title clean_football_uk
#'@description
#'@param x dataset from the function "get_football_uk"
#'@name clean_football_uk
#'@return tibble

clean_football_uk <- function(x = NULL){

  # Dataset to be cleaned
  df <- x

  # Variables Codex
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
  standard_condition_hg <- colnames(df) %in% "HG"

  if (sum(standard_condition_hg) == 1) {

    colnames(df)[which(standard_condition_hg)] <- "FTHG"

  }

  standard_condition_ag <- colnames(df) %in% "AG"

  if (sum(standard_condition_ag) == 1) {

    colnames(df)[which(standard_condition_ag)] <- "FTAG"

  }

  # inizializzation of an empty matrix with:
  # nrow = nrow of the input dataframe
  # ncol = number of variables in the codex

  empty_df <- matrix(nrow = nrow(df), ncol = length(variables_codex))

  empty_df <- as.data.frame(empty_df)

  # original name of the input dataset
  original_variables <- colnames(df)

  # selected original variables to rename
  selected_variables <- names(variables_codex)

  # new names for the new selected variables
  new_variables  <- unlist(variables_codex)

  # ciclo per identificare le variabili di interesse e inserimento in un dataframe standardizzato
  for(i in 1:length(original_variables)){

    index <- which(original_variables %in% selected_variables[i])

    if(!purrr::is_empty(index)){

      empty_df[,i] <- df[,index]

    }
  }

  colnames(empty_df) <- new_variables

  output <- dplyr::as_tibble(empty_df)

  output <- dplyr::mutate(output,
                          home_team = as.character(home_team),
                          away_team = as.character(away_team),
                          home_goal_2T = as.numeric(home_goal_2T),
                          home_goal_1T = as.numeric(home_goal_1T),
                          away_goal_2T = as.numeric(away_goal_2T),
                          away_goal_1T = as.numeric(away_goal_1T),
                          home_shots = as.numeric(home_shots),
                          home_target_shots = as.numeric(home_target_shots),
                          home_corners = as.numeric(home_corners),
                          home_yellow = as.numeric(home_yellow),
                          home_red = as.numeric(home_red),
                          away_shots = as.numeric(away_shots),
                          away_target_shots = as.numeric(away_target_shots),
                          away_corners = as.numeric(away_corners),
                          away_yellow = as.numeric(away_yellow),
                          away_red = as.integer(away_red),
                          home_quote = as.numeric(home_quote),
                          drow_quote = as.numeric(drow_quote),
                          away_quote = as.numeric(away_quote)
  )

  output <- dplyr::mutate_if(output, is.factor, as.character)

  output <- dplyr::filter(output, !is.na(home_goal_2T) & !is.na(away_goal_2T) & !is.na(home_goal_1T & !is.na(away_goal_1T) ))

  output <- dplyr::mutate(output,
                          "date" = as.POSIXct(lubridate::dmy(date)),
                          "time" = lubridate::hm(time, quiet = TRUE),
                          "time" = ifelse(is.na(time), lubridate::hm("00:00"), time),
                          "date" = date + time,
                          "under0.5" = ifelse((home_goal_2T + away_goal_2T) < 1, 1, 0 ),
                          "under1.5" = ifelse((home_goal_2T + away_goal_2T) < 2, 1, 0 ),
                          "under2.5" = ifelse((home_goal_2T + away_goal_2T) < 3, 1, 0 ),
                          "under3.5" = ifelse((home_goal_2T + away_goal_2T) < 4, 1, 0 ),
                          "under4.5" = ifelse((home_goal_2T + away_goal_2T) < 5, 1, 0 ),
                          "under5.5" = ifelse((home_goal_2T + away_goal_2T) < 6, 1, 0 ),
                          "goal1T" = ifelse(home_goal_1T == 0 | away_goal_1T == 0, 0,1),
                          "goal2T" = ifelse(home_goal_2T == 0 | away_goal_2T == 0, 0,1)

  )

  season <- lubridate::year(output$date)
  season <- min(unique(season))
  output$season <- paste0(season,"-", season + 1)

  output <- dplyr::select(output, -time)
  output <- dplyr::select(output, division, date, season, dplyr::everything())

  return(output)

}
