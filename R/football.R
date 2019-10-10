#'@title football
#'@param save  TRUE / FALSE
#'@param name newname

#'@export



football_data <- readRDS("football_db.RDS")

# importazione di tutti i paesi e tutte le divisioni
football <- function(save = FALSE, name = "newname" ){
  countries <- readRDS("country.RDS")
  out <- purrr::map(countries, ~football_country(.x) )
  names(out) <- countries
  if(save){
    saveRDS(out, paste0(name, ".RDS"))
  }
  out
}
