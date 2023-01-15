#'@title football_uk
#'@description base function to get in a clean way the data available on \href{https://www.football-data.co.uk}{football-uk}.
#'@param country character vector. One or more of the available countries.
#'                By default is set to 'all' and will consider all the countries available.
#'@param division character vector. One or more of the available divisions.
#'                By default is set to 'all' and will consider all the divisions available for a specific country.
#'@param years integer vector. The first item is the first year of importation and the second item is the last year.
#'@param verbose logical. When TRUE function evaluates without displaying customary messages.
#'@name football_uk
#'@rdname football_uk
#'@return tibble
#'@export

football_uk <- function(country = "all", division = "all", years = c(start = 2010, end = 2020), verbose = TRUE) {

    supported_country <- c("england", "scotland", "germany", "italy", "spain", "france", "netherlands", "belgium", "portugal", "turkey", "greece")

    if ("all" %in% country) {

        country <- supported_country

    } else {

        country <- match.arg(tolower(country), supported_country, several.ok = TRUE)

    }

    output <- purrr::map_df(country, ~get_divisions(country = .x, division = division, years = years, verbose = verbose))

    output <- dplyr::arrange(output, dplyr::desc(date))

    return(output)

}

#'@title get_divisions
#'@description base function to get in a clean way the data available on \href{https://www.football-data.co.uk}{football-uk}.
#'@param country character. One of the available countries.
#'@param division character vector. One or more of the available divisions.
#'                By default is set to 'all' and will consider all the divisions available for a specific country.
#'@param years integer vector. The first item is the first year of importation and the second item is the last year.
#'@param verbose logical. When TRUE function evaluates without displaying customary messages.
#'@name get_divisions
#'@rdname get_divisions
#'@return tibble

get_divisions <- function(country = NULL, division = "all", years = c(start = 2010, end = 2020), verbose = TRUE) {

    supported_divisions <- list(england = c("premier", "championship", "div1", "div2"),
                                scotland = c("premier", "div1", "div2", "div3"),
                                germany = c("div1", "div2"),
                                italy = c("div1", "div2"),
                                spain = c("div1", "div2"),
                                france = c("div1", "div2"),
                                netherlands = c("div1"),
                                belgium = c("div1"),
                                portugal = c("div1"),
                                turkey = c("div1"),
                                greece = c("div1"))

    country <- match.arg(tolower(country), names(supported_divisions))

    all_divisions <- supported_divisions[[country]]

    if ("all" %in% division) {

        divisions <- all_divisions

    } else {

        divisions <- match.arg(division, all_divisions, several.ok = TRUE)

    }

    output <- purrr::map_df(divisions, ~get_years(country = country, division = .x, years = years, verbose = verbose))

    return(output)

}

#'@title get_years
#'@description base function to get in a clean way the data available on \href{https://www.football-data.co.uk}{football-uk}.
#'@param country character. One of the available countries.
#'@param division character. One of the available divisions.
#'@param years integer vector. The first item is the first year of importation and the second item is the last year.
#'@param verbose logical. When TRUE function evaluates without displaying customary messages.
#'@name get_years
#'@rdname get_years
#'@return tibble

get_years <- function(country = NULL, division = "div1", years = c(start = 2010, end = 2020), verbose = TRUE) {

    seq_years <- seq(years[1], years[2])

    safe_function <- purrr::safely(get_football_uk)

    output <- purrr::map_df(seq.years, ~safe_function(country = country, division = division, year = .x, raw = FALSE, verbose = verbose)$result)

    return(output)

}

