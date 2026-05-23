test_that("ftuk_read cleans a local football-data CSV", {
  csv <- tempfile(fileext = ".csv")
  writeLines(
    c(
      "Date,Time,HomeTeam,AwayTeam,HTHG,FTHG,HTAG,FTAG,B365H,B365D,B365A",
      "13/08/2022,17:30,Milan,Udinese,2,4,2,2,1.45,4.5,7"
    ),
    csv
  )

  out <- ftuk_read(csv, country = "italy", division = "div1", year = 2023)

  expect_s3_class(out, "tbl_df")
  expect_equal(out$country, "italy")
  expect_equal(out$division, "div1")
  expect_equal(out$year, 2023L)
  expect_equal(out$total_goals_ft, 6)
  expect_equal(out$btts_ft, 1L)
})

test_that("ftuk_read can return raw local CSV data", {
  csv <- tempfile(fileext = ".csv")
  writeLines(
    c(
      "Date,HomeTeam,AwayTeam,HTHG,FTHG,HTAG,FTAG",
      "13/08/2022,Milan,Udinese,2,4,2,2"
    ),
    csv
  )

  out <- ftuk_read(csv, raw = TRUE)

  expect_s3_class(out, "tbl_df")
  expect_named(out, c("Date", "HomeTeam", "AwayTeam", "HTHG", "FTHG", "HTAG", "FTAG"))
})

test_that("ftuk_download reuses URL, download, and read helpers", {
  csv <- tempfile(fileext = ".csv")
  writeLines(
    c(
      "Date,HomeTeam,AwayTeam,HTHG,FTHG,HTAG,FTAG",
      "13/08/2022,Milan,Udinese,2,4,2,2"
    ),
    csv
  )

  testthat::local_mocked_bindings(
    .ftuk_download_file = function(url, quiet) {
      expect_equal(url, "https://www.football-data.co.uk/mmz4281/2223/I1.csv")
      csv
    },
    .package = "footballdatauk"
  )

  out <- ftuk_download("italy", "div1", years = 2023, quiet = TRUE)

  expect_s3_class(out, "tbl_df")
  expect_equal(out$season, "2022-2023")
  expect_equal(out$total_goals_ft, 6)
})

test_that("deprecated wrappers call new API", {
  csv <- tempfile(fileext = ".csv")
  writeLines(
    c(
      "Date,HomeTeam,AwayTeam,HTHG,FTHG,HTAG,FTAG",
      "13/08/2022,Milan,Udinese,2,4,2,2"
    ),
    csv
  )

  testthat::local_mocked_bindings(
    .ftuk_download_file = function(url, quiet) csv,
    .package = "footballdatauk"
  )

  expect_warning(
    out <- get_football_uk("italy", "div1", year = 2023, quiet = TRUE),
    "deprecated"
  )
  expect_s3_class(out, "tbl_df")

  expect_warning(
    old_clean <- clean_football_uk(
      tibble::tibble(Date = "13/08/2022", HomeTeam = "Milan", AwayTeam = "Udinese", HTHG = 2, FTHG = 4, HTAG = 2, FTAG = 2),
      year = 2023
    ),
    "deprecated"
  )
  expect_s3_class(old_clean, "tbl_df")
})

