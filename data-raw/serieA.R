# Rebuild the `serieA` example dataset.
#
# This script is not run during R CMD check. It downloads source CSV files from
# football-data.co.uk, cleans them, and stores a small representative sample.
# The sample is bundled because explicit redistribution terms for full CSV data
# were not found during package preparation.

library(dplyr)
library(usethis)

source("R/registry.R")
source("R/clean.R")
source("R/read-download.R")

serieA_full <- ftuk_download(
  country = "italy",
  division = "div1",
  years = c(2019, 2023),
  quiet = TRUE
)

serieA <- serieA_full |>
  dplyr::arrange(season, date, home_team, away_team) |>
  dplyr::group_by(season) |>
  dplyr::slice_head(n = 10) |>
  dplyr::ungroup()

usethis::use_data(serieA, overwrite = TRUE, compress = "xz")

