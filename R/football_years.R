#'@title football_anni
#'@description  funzione per importare tutti gli anni di ua divisione
#'@param country  country
#'@param div division
#'@param start_year  anno di inizio
#'@param end_year  anno di fine
#'@export

football_years <- function(country, div, start_year = 2003, end_year = 2019 ){

  anno = as.character( seq(start_year, end_year,1) )

  pmap_args <- list(
    country = rep( country, length(anno)),
        div = rep( div, length(anno)),
       anno = anno

  )

  out <- purrr::pmap(pmap_args, football_single)

  out <- dplyr::bind_rows(out)

  return(out)

}
