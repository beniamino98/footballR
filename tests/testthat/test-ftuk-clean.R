test_that("ftuk_clean returns expected schema and derived variables", {
  raw <- tibble::tibble(
    Div = "I1",
    Date = c("13/08/2022", "14/08/2022", "15/08/2022"),
    Time = c("17:30", NA, "20:45"),
    HomeTeam = c("Milan", "Lazio", "Roma"),
    AwayTeam = c("Udinese", "Bologna", "Atalanta"),
    HTHG = c(2, 0, 0),
    FTHG = c(4, 2, 0),
    HTAG = c(2, 1, 0),
    FTAG = c(2, 1, 1),
    HTR = c("D", "A", "D"),
    FTR = c("H", "H", "A"),
    HS = c(14, 11, 8),
    HST = c(5, 6, 2),
    HC = c(5, 3, 2),
    HY = c(1, 2, 3),
    HR = c(0, 0, 0),
    AS = c(9, 10, 12),
    AST = c(4, 3, 4),
    AC = c(1, 2, 5),
    AY = c(4, 1, 2),
    AR = c(0, 1, 0),
    B365H = c(1.45, 1.8, 2.1),
    B365D = c(4.5, 3.8, 3.2),
    B365A = c(7.0, 4.75, 3.6)
  )

  out <- ftuk_clean(raw, country = "italy", division = "div1", year = 2023)

  expect_s3_class(out, "tbl_df")
  expect_true(all(c(
    "country", "division", "season", "year", "date", "home_team",
    "away_team", "home_goals_1h", "home_goals_ft", "away_goals_1h",
    "away_goals_ft", "draw_quote", "drow_quote", "total_goals_1h",
    "total_goals_ft", "goal_1h", "goal_ft", "btts_1h", "btts_ft",
    "home_win", "draw", "away_win", "home_points", "away_points",
    "goal_difference", "under2.5"
  ) %in% names(out)))
  expect_equal(out$season, rep("2022-2023", 3))
  expect_equal(as.POSIXlt(out$date[1], tz = "UTC")$hour, 17)
  expect_equal(as.POSIXlt(out$date[2], tz = "UTC")$hour, 0)
  expect_equal(out$total_goals_1h, c(4, 1, 0))
  expect_equal(out$total_goals_ft, c(6, 3, 1))
  expect_equal(out$goal_1h, c(1L, 1L, 0L))
  expect_equal(out$goal_ft, c(1L, 1L, 1L))
  expect_equal(out$btts_1h, c(1L, 0L, 0L))
  expect_equal(out$btts_ft, c(1L, 1L, 0L))
  expect_equal(out$home_points, c(3L, 3L, 0L))
  expect_equal(out$away_points, c(0L, 0L, 3L))
  expect_equal(out$goal_difference, c(2, 1, -1))
  expect_equal(out$draw_quote, out$drow_quote)
})

test_that("ftuk_clean supports old HG and AG aliases", {
  raw <- tibble::tibble(
    Date = "01/09/1996",
    HomeTeam = "Roma",
    AwayTeam = "Milan",
    HTHG = 0,
    HG = 1,
    HTAG = 0,
    AG = 0
  )

  out <- ftuk_clean(raw, country = "italy", division = "div1", year = 1997)

  expect_equal(out$home_goals_ft, 1)
  expect_equal(out$away_goals_ft, 0)
  expect_equal(out$under1.5, 1L)
})

test_that("ftuk_clean reports missing required columns", {
  expect_error(
    ftuk_clean(tibble::tibble(Date = "01/01/2023")),
    "missing required"
  )
})

