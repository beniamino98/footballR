#'@title info_countries 
#'@description  

info_countries <- function(){
  
  c("england", "scotland", "germany", "italy", "spain", 
    "france", "netherlands", "belgium", "portugal", "turkey",
    "greece")
  
}

#'@title info_divisions
#'@description  
#'@param country 

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
#'@description  
#'@param country 

is_country <- function(country = NULL){
  
  if(!is.character(country)) return(FALSE)
  if(is.null(country)) return(FALSE)
  
  all_countries <- info_countries()
  country %in% all_countries
  
}


#'@title is_division 
#'@description  
#'@param country  
#'@param division division

is_division <- function(country = NULL, division = NULL){
  
  
  if(!is_country(country) && is.null(division)) return(FALSE)
  
  division %in% info_divisions(country)
  
}

#'@title na_if 
#'@description  
#'@param x
#'@param .if

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

