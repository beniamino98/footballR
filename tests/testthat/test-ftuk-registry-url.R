test_that("season codes and URLs are deterministic", {
  expect_equal(footballdatauk:::.ftuk_season_code(2024), "2324")
  expect_equal(
    ftuk_url("italy", "div1", 2024),
    "https://www.football-data.co.uk/mmz4281/2324/I1.csv"
  )
  expect_equal(
    ftuk_url("england", "premier", 2023),
    "https://www.football-data.co.uk/mmz4281/2223/E0.csv"
  )
})

test_that("country, division, and season helpers use registry data", {
  expect_true("italy" %in% ftuk_countries())

  italy <- ftuk_divisions("italy")
  expect_s3_class(italy, "tbl_df")
  expect_true(all(c("country", "division", "code", "label", "first_year", "last_year") %in% names(italy)))
  expect_true("div1" %in% italy$division)
  expect_equal(italy$code[italy$division == "div1"], "I1")

  seasons <- ftuk_seasons()
  expect_true(all(c("year", "season", "code") %in% names(seasons)))
  expect_true(2024 %in% seasons$year)
  expect_equal(seasons$season[seasons$year == 2024], "2023-2024")
})

test_that("validation gives useful errors", {
  expect_error(footballdatauk:::.ftuk_validate_country("atlantis"), "`country` must be one of")
  expect_error(footballdatauk:::.ftuk_validate_division("italy", "premier"), "`division` must be valid")
  expect_error(footballdatauk:::.ftuk_validate_years(c(2024, 2023)), "ordered")
  expect_error(footballdatauk:::.ftuk_validate_logical(c(TRUE, FALSE), "quiet"), "`quiet` must be TRUE or FALSE")
})

