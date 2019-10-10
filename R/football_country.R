#'@title football_country
#'@description  funzione per importare tutti i dati di un paese
#'@param country  country
#'@export


football_country <- function( country ){

  countries <- readRDS("country.RDS")
  division  <- readRDS("division.RDS")

  country <- match.arg(country, countries )
  div <- unlist(division[country])
  out <- purrr::map(div, ~football_anni(country, .x) )
  names(out) <- div
  out
}

