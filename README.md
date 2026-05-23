# footballdatauk

`footballdatauk` reads, downloads, and cleans football-data.co.uk CSV files. The
public API uses the `ftuk_` prefix, while internal helpers use `.ftuk_`.

The package includes `serieA`, a small Italian Serie A sample dataset for
offline examples, documentation, and tests.

## Installation

```r
remotes::install_github("beniamino98/footballdatauk")
```

```r
library(footballdatauk)
```

## Offline usage

```r
data(serieA)
head(serieA)
```

Summarise the sample by season and team:

```r
library(dplyr)

home <- serieA |>
  transmute(season, team = home_team, goals_for = home_goals_ft,
            goals_against = away_goals_ft, points = home_points)

away <- serieA |>
  transmute(season, team = away_team, goals_for = away_goals_ft,
            goals_against = home_goals_ft, points = away_points)

bind_rows(home, away) |>
  group_by(season, team) |>
  summarise(
    matches = n(),
    goals_for = sum(goals_for),
    goals_against = sum(goals_against),
    points = sum(points),
    .groups = "drop"
  ) |>
  arrange(desc(season), desc(points)) |>
  head(10)
```

## Downloading live data

Live downloads require internet access, so examples are wrapped in
`interactive()`.

```r
if (interactive()) {
  italy_2024 <- ftuk_download(
    country = "italy",
    division = "div1",
    years = 2024,
    quiet = TRUE
  )
}
```

To build a URL without downloading:

```r
ftuk_url("italy", "div1", 2024)
```

To clean a local CSV:

```r
if (interactive()) {
  local_data <- ftuk_read(
    "I1.csv",
    country = "italy",
    division = "div1",
    year = 2024
  )
}
```

## Supported countries and divisions

```r
ftuk_countries()
ftuk_divisions("italy")
tail(ftuk_seasons())
```

Currently supported countries are England, Scotland, Germany, Italy, Spain,
France, Netherlands, Belgium, Portugal, Turkey, and Greece. Supported divisions
come from the package registry used by `ftuk_divisions()`.

The `year` convention is the football-data.co.uk season-ending year:
`year = 2024` means season 2023-2024.

## Cleaned output

Cleaned data include:

- identifiers: `country`, `division`, `season`, `year`
- match fields: `date`, `home_team`, `away_team`
- score fields: `home_goals_1h`, `away_goals_1h`, `home_goals_ft`,
  `away_goals_ft`, `result_1h`, `result_ft`
- match statistics: shots, target shots, corners, yellow cards, and red cards
- odds: `home_quote`, `draw_quote`, `away_quote`
- clear outcomes: `total_goals_1h`, `total_goals_ft`, `goal_1h`, `goal_ft`,
  `btts_1h`, `btts_ft`, `home_win`, `draw`, `away_win`, `home_points`,
  `away_points`, `goal_difference`
- under-goal indicators: `under0.5` through `under5.5`

Odds are kept as quoted prices. The package does not compute unnormalised
implied probabilities. `drow_quote` is retained only as a compatibility alias
for the older misspelled column name; new code should use `draw_quote`.

## Source

Data are sourced from [football-data.co.uk](https://www.football-data.co.uk/).
Please acknowledge football-data.co.uk when using downloaded match data.

