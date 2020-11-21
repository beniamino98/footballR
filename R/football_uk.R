#'@title get_years 
#'@description base function to get in a clean way the data availables on \href{https://www.football-data.co.uk}{football-uk}. 
#'@param country character. One of the available countries. See  \code{info_country}.
#'@param division character. One of the available divisions See  \code{info_divisions}.
#'@param year integer vector. The first item is the first year of importation and the second item is the last year. 
#'@param quiet logical. When TRUE function evalueates without displaying customary messages.
#'@name get_years
#'@rdname get_years
#'@return tibble

get_years <- function( country = NULL, division = "div1", year = c(start = 2010, end = 2020), quiet = FALSE){
  
  output <- NULL
  
  seq.year <- seq(year[1], year[2])
  
  output <- purrr::map_df(seq.year, ~get_webdata(country = country, division = division, year = .x, raw = FALSE,  quiet = quiet)  )
  
  return(output)
  
}

#'@title get_divisions 
#'@description base function to get in a clean way the data availables on \href{https://www.football-data.co.uk}{football-uk}. 
#'@param country character. One of the available countries. See  \code{info_country}.
#'@param division character vector. One or more of the available divisions. See  \code{info_divisions}. 
#'                By default is set to "all" and will consider all the divisions availables for a specific country.  
#'@param year integer vector. The first item is the first year of importation and the second item is the last year. 
#'@param quiet logical. When TRUE function evalueates without displaying customary messages.
#'@name get_divisions
#'@rdname get_divisions
#'@return tibble
#'
get_divisions <- function( country = NULL, division = "all", year = c(start = 2010, end = 2020), quiet = FALSE){
  
  output  <- NULL
  
  all_div <- info_divisions(country)
  
  if("all" %in% division){
    
    div <- all_div
    
  } else {
    
    div <- all_div[all_div %in% division]
    
  }
  
  output <- purrr::map_df(div, ~get_years(country = country, division = .x, year = year,  quiet = quiet)  )
  
  return(output)
  
}


#'@title football_uk 
#'@description base function to get in a clean way the data availables on \href{https://www.football-data.co.uk}{football-uk}. 
#'@param country character vector. One or more of the availables countries. See  \code{info_country}.
#'                By default is set to "all" and will consider all the countries availables.  
#'@param division character vector. One or more of the availables divisions. See  \code{info_divisions}. 
#'                By default is set to "all" and will consider all the divisions availables for a specific country.  
#'@param year integer vector. The first item is the first year of importation and the second item is the last year. 
#'@param quiet logical. When TRUE function evalueates without displaying customary messages.
#'@name football_uk
#'@rdname football_uk
#'@return tibble
#'@export

football_uk <-  function(country = "all", division = "all", year = c(start = 2010, end = 2020), quiet = FALSE){
  
  output <- NULL
  
  if(country == "all"){
    
    country <- info_countries()
    
  } else {
    
    country <- country[country %in% info_countries()]
    
  }
  
  output <- purrr::map_df(country, ~get_divisions(country = .x, division = division, year = year,  quiet = quiet))
  
  output <- dplyr::mutate(output, 
                          date = as.Date(date),
                          home_quote = as.double(home_quote),
                          drow_quote = as.double(drow_quote),
                          away_quote = as.double(away_quote),
                          result_1T = as.factor(result_1T),
                          result_2T = as.factor(result_2T), 
                          time = lubridate::hm(time, quiet = TRUE))
  
  output <- dplyr::arrange(output, dplyr::desc(date))
  
  return(output)
  
}

