# decalring global variables
utils::globalVariables(c("home_team", "away_team", 
                         "home_goal_2T","home_goal_1T", "away_goal_1T", "away_goal_2T",
                         "home_shots", "home_target_shots", "home_corners", "home_yellow", "home_red", 
                         "away_shots", "away_target_shots", "away_corners", "away_yellow", "away_red",
                         "home_quote", "away_quote", "drow_quote", "season", "result_2T", "result_1T", "time"))


#'@title info_countries 
#'@description a function to obtain all the available countries. 
#'@return character vector
#'@name info_countries
#'@rdname info_countries
#'@export

info_countries <- function(){
  
  c("england", "scotland", "germany", "italy", "spain", 
    "france", "netherlands", "belgium", "portugal", "turkey",
    "greece")
  
}



#'@title info_divisions
#'@description a function to obtain all the available division for all countries or for a specific country. 
#'@param country : character. One of the available countries. See  \code{info_country}
#'@name info_divisions
#'@rdname info_divisions
#'@export

info_divisions <- function(country = "all"){
  
  supported.divisions <-list(
    england     =  c("premier", "championship", "div1", "div2"  ),
    scotland    =  c("premier", "div1", "div2", "div3"),
    germany     =  c( "div1", "div2" ),
    italy       =  c( "div1", "div2" ),
    spain       =  c( "div1", "div2" ),
    france      =  c( "div1", "div2" ),
    netherlands =  c( "div1" ),
    belgium     =  c( "div1" ),
    portugal    =  c( "div1" ),
    turkey      =  c( "div1" ),
    greece      =  c( "div1" )
  )
  
  if(country != "all" && is_country(country)){
    
    supported.divisions <- supported.divisions[[country]]
    names(supported.divisions) <- rep(country, length(supported.divisions))
    
  } 
  
  return(supported.divisions)
}



#'@title is_country  
#'@description a function to check if is a valid country or not. 
#'@param country : character. One of the available countries. See  \code{info_country}

is_country <- function(country = NULL){
  
  if(!is.character(country)) return(FALSE)
  if(is.null(country)) return(FALSE)
  
  all_countries <- info_countries()
  country %in% all_countries
  
}



#'@title is_division 
#'@description a function to check if is a valid division or not.
#'@param country  : character. One of the available countries. See  \code{info_country}
#'@param division : character. One of the available divisions See  \code{info_divisions}

is_division <- function(country = NULL, division = NULL){
  
  
  if(!is_country(country) && is.null(division)) return(FALSE)
  
  division %in% info_divisions(country)
  
}



#'@title na_if 
#'@description a function to substitute others forms of NA's. It is a consistent function in the sense 
#'             that if x is a list the output will be a list;
#'             if is a data.frame, will be a data.frame;
#'             and if it is a vector it will be a vector.   
#'@param x an object, can be a vector, a list or a dataframe.
#'@param .if others type of NA's. By default is  c("", " ", "N/A", "NA")
#'@name na_if
#'@rdname na_if
#'@export

na_if <- function(x = NULL, .if = c("", " ", "N/A", "NA")){
  
  .f <- function(x = NULL, .if = NULL){
    ifelse(x %in% .if, NA, x)
  }
  
  
  # case for list and for vectors (vectors contained in list)
  # the list case has to be evaluated first
  
  if(is.list(x) & !is.data.frame(x) & !is.vector(x)){
    x <- purrr::map(x, ~.f(x = .x, .if = .if))
  } else if(!is.list(x) & !is.data.frame(x) & is.vector(x)){
    x <- .f(x = x, .if = .if)
  }
  
  # case for data.frame/tibble...
  if(!is.list(x) & is.data.frame(x) & !is.vector(x)){
    x <- purrr::map_df(x, ~.f(x = .x, .if = .if))
  }
  
  return(x)
  
}
