test_that("serieA loads as an offline example dataset", {
  data("serieA", package = "footballdatauk")

  expect_s3_class(serieA, "tbl_df")
  expect_gte(nrow(serieA), 25)
  expect_gte(ncol(serieA), 40)
  expect_equal(unique(serieA$country), "italy")
  expect_equal(unique(serieA$division), "div1")
  expect_true(all(c(
    "season", "date", "home_team", "away_team", "home_goals_ft",
    "away_goals_ft", "draw_quote", "total_goals_ft", "goal_ft", "btts_ft",
    "home_points", "away_points", "goal_difference"
  ) %in% names(serieA)))
  expect_true(all(c(
    "2018-2019", "2019-2020", "2020-2021", "2021-2022", "2022-2023"
  ) %in% unique(serieA$season)))
})

