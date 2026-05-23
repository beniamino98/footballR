#' Deprecated function names
#'
#' These functions are retained as soft-deprecated wrappers around the `ftuk_*`
#' API.
#'
#' @param data A data frame or tibble created from a football-data.co.uk CSV.
#' @param ... Arguments passed to the replacement function.
#' @param country,division,years,year,raw,quiet Arguments from the old API.
#' @param verbose Deprecated. Use `quiet`; `verbose = TRUE` becomes
#'   `quiet = FALSE`.
#'
#' @return A tibble.
#'
#' @name footballdatauk-deprecated
NULL

#' @rdname footballdatauk-deprecated
#' @export
football_uk <- function(country = "all",
                        division = "all",
                        years = c(2020, 2024),
                        quiet = FALSE,
                        verbose = NULL,
                        ...) {
  .ftuk_soft_deprecated("football_uk()", "ftuk_download()")
  if (!is.null(verbose)) {
    warning("`verbose` is deprecated; use `quiet` instead.", call. = FALSE)
    quiet <- !.ftuk_validate_logical(verbose, "verbose")
  }

  ftuk_download(
    country = country,
    division = division,
    years = years,
    quiet = quiet,
    ...
  )
}

#' @rdname footballdatauk-deprecated
#' @export
get_football_uk <- function(country = NULL,
                            division = "div1",
                            year = 2020,
                            raw = FALSE,
                            quiet = FALSE,
                            verbose = NULL,
                            ...) {
  .ftuk_soft_deprecated("get_football_uk()", "ftuk_download()")
  if (!is.null(verbose)) {
    warning("`verbose` is deprecated; use `quiet` instead.", call. = FALSE)
    quiet <- !.ftuk_validate_logical(verbose, "verbose")
  }

  ftuk_download(
    country = country,
    division = division,
    years = year,
    raw = raw,
    quiet = quiet,
    ...
  )
}

#' @rdname footballdatauk-deprecated
#' @export
clean_football_uk <- function(data = NULL, year = NULL, ...) {
  .ftuk_soft_deprecated("clean_football_uk()", "ftuk_clean()")
  ftuk_clean(data, year = year, ...)
}

.ftuk_soft_deprecated <- function(old, new) {
  warning(old, " is deprecated; use ", new, " instead.", call. = FALSE)
}
