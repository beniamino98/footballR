#'@title football_
#'@description "rh"
#'@param country  country
#'@param div division
#'@param year year
#'@param quiet TRUE /FALSE
#'@param raw TRUE / FALSE 
#'@export

football_single<- function( country = NULL, div = "div1", year = "2018", raw = FALSE,  quiet = TRUE ) {
  
  file.out      <- NA
  year.match    <- NA_character_
  country.match <- NA_character_
  div.match     <- NA_character_
  year.paths    <- NA
  file.paths    <- NA
  file.url      <- NA_character_
  
 
  
  read_csv_ <- function(x,...) suppressMessages(suppressWarnings(readr::read_csv(x,...)))
  
  # country supported 
  country.supported <-list(
      england     =  c(premier = "E0", championship = "E1", div1 = "E2", div2 = "E3"  ),
      scotland    =  c(premier = "SC0", div1 = "SC1", div2 = "SC2", div3 = "SC3"),
      germany     =  c( div1 = "D1",  div2 = "D2" ),
      italy       =  c( div1 = "I1",  div2 = "I2" ),
      spain       =  c( div1 = "SP1", div2 = "SP2"),
      france      =  c( div1 = "F1",  div2 = "F2" ),
      netherlands =  c( div1 = "N1" ),
      belgium     =  c( div1 = "B1"),
      portugal    =  c( div1 = "P1" ),
      turkey      =  c( div1 = "T1" )
    )
  
  
  # year supported 
  year.supported <- c( paste0(seq(90,98,1), seq(91,99,1)),"0000",
                       paste0("0",seq(0,8,1),"0",seq(1,9,1)),"0910",
                       paste0(seq(10,28,1), seq(11,29,1)) )
  
  names(year.supported)<- seq(1990 , 2028)
  
  year.match    <- match.arg( year, names( year.supported ) )
  country.match <- match.arg( country, names( country.supported ) )
  div.match     <- match.arg( div, names( country.supported[[ country.match ]] ) )
  
  year.paths <- year.supported[[year.match]]
  file.paths <- paste0(country.supported[[ country.match ]] [[  div.match ]] ,".csv")
  
  
  file.url <- httr::modify_url("https://www.football-data.co.uk", path = c("mmz4281", year.paths, file.paths))
                                   
  file.out <- read_csv_(file.url)
  
  if(!quiet) message("importazione ", country.match, " ", year.match, " ", div.match,  " completata!")
  
  if(raw){
    return(file.out)
  } else {
    return(clean_football(file.out))
  }

}



