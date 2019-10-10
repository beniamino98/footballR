#'@title football_single
#'@param country  country
#'@param div division
#'@param anno year
#'@param verbose TRUE /FALSE
#'@export
football_single <- function(country, div = "div1", anno = "2018", verbose = TRUE ){

  codex <-
    list(
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


  # creazione degli anni
  anni <- c( paste0(seq(90,98,1), seq(91,99,1)),   "0000",
             paste0("0",seq(0,8,1),"0",seq(1,9,1)),"0910",
             paste0(seq(10,28,1), seq(11,29,1))            )

  names(anni)<- seq(1990 , 2028)


  anno    <- match.arg( anno, names( anni ) )
  country <- match.arg( country, names( codex ) )
  div     <- match.arg( div, names( codex[[ country ]] ) )

  url <- paste0( "https://www.football-data.co.uk/mmz4281/",anni[ anno ],"/",codex[[ country ]] [[ div ]], ".csv" )

  out <- suppressMessages(suppressWarnings(readr::read_csv(url)))

  attr(out, "country") <- country
  attr(out, "class") <- c("football", class(out))
  if(verbose) {message("importazione ", country," ",  anno," ", div,  " completata!")}
  simplify_football(out)

}









