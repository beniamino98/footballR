#'@title football
#'@description  funzione per importare tutti gli anni di ua divisione
#'@param country  country
#'@param div division
#'@param from  anno di inizio
#'@param to  anno di fine
#'@param raw jjs
#'@param quiet TRUE /FALSE
#'@export

football <- function(country = "italy", div = "div1", from = 2003, to = 2019, raw = FALSE,  quiet = FALSE ){

  bind_rows_safe <- purrr::safely(dplyr::bind_rows)
  
  seq.years <- NA_character_
  pmap_args <- list()
  file.list <- NA
  file.tbl  <- NA
  seq.years <- as.character( seq(from, to,1) )

  pmap_args$country  <- rep( country, length(seq.years))
  pmap_args$div      <- rep( div, length(seq.years))
  pmap_args$year     <- seq.years
  pmap_args$raw      <- raw
  pmap_args$quiet    <- quiet 
  
  
  file.list <- purrr::pmap(pmap_args, football_single)
  file.tbl <- bind_rows_safe(file.list)
  
  if(is.null( file.tbl$result) ){
    message("something goes wrong during the binding of the list try with simplify = TRUE ")
    return(file.list)
  } else {
    return(file.tbl$result)
  }
}
