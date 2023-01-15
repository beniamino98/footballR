# FootballR: wrapper for historical football data with R 

## About 

FootballR is an [R](https://www.r-project.org) package that allows to download in a standardized way the data availables as csv,  in the website [football-data.uk](https://www.football-data.co.uk). 

In general, for each country there are different divisions that can be downloaded. In general:  

 - `div1`: stands for the first division.
 - `div2`: stands for the second division.
 - `div3`: stands for the third division.
 - `premier`: stands for the premier league, available just for England and Scotland.
 - `championship`: stands for the champioship league, available just for England.

The informations available for each country are the following country: 

- england (`championship`, `premier`, `div1`, `div2`, `div3`)
- scotland (`premier`, `div1`, `div2`, `div3`)
- germany (`div1` = "Bundesliga 1", `div2` = "Bundesliga 2")
- italy (`div1` = "SerieA", `div2` = "SerieB")
- spain (`div1` = "La Liga 1° Division", `div `= "La Liga 2° Division")
- france (`div1` = "Le Championnat", `div2` = "Division 2")
- netherlands (`div1` = "Eredivisie")
- belgium (`div1` = "Jupiler League")
- portugal (`div1` = "Liga 1")
- turkey (`div1` = "Futbol Ligi 1")
- greece (`div1` = "Ethniki Katigoria")

## Installation

To install the development version, you need to clone the repository and build
from source, or run one of:

```r
# lightweight
remotes::install_github("beniamino98/footballR")
# or
devtools::install_github("beniamino98/footballR")

library(footballR)
```

## Importing Data 

There is just one function exported that allows to download all the data needed with just one line of code. The function is named `football_uk` and there are different types of usages. 
It is possible to import a several types of data with the function: `football_uk`. You can import all the data availables, using country = "all" and division = "all" and specifying just the range of years. 
The function takes 3 main arguments: 

- `country`: a character containing the name of the country of interest, it is possible to import all the data availables for all the countries specifying `country = "all"`. 

- `division`: the division of interest, it is possible to import all the data availables for all the divisions specifying `division = "all"`. 

- `year`: the year of interest, it can be a numeric vector that contains as the first element the first year and as second element the last year. In that case the function will import all the data between the two years included. 

### Specific Country and Division for 10 years (2010-2020)


```r
> football_uk(country = "england", division = "div1", year = c(start = 2010, end = 2020), verbose = TRUE)    

# A tibble: 5,920 × 34
   country division season    year date                home_…¹ away_…² home_…³ home_…⁴ away_…⁵ away_…⁶ resul…⁷ resul…⁸ home_…⁹ home_…˟ home_…˟ home_…˟ home_…˟ away_…˟ away_…˟ away_…˟ away_…˟ away_…˟ home_…˟ drow_…˟ away_…˟ under…˟
   <chr>   <chr>    <chr>    <int> <dttm>              <chr>   <chr>     <dbl>   <dbl>   <dbl>   <dbl> <chr>   <chr>     <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <int>   <dbl>   <dbl>   <dbl>   <dbl>
 1 england div1     2019-20…  2020 2020-03-10 01:00:00 Blackp… Tranme…       0       1       2       2 A       A            16       6       8       2       0       9       2       6       1       0    1.65    3.9     5.25       0
 2 england div1     2019-20…  2020 2020-03-10 01:00:00 Bristo… Sunder…       1       2       0       0 H       H             8       3       5       3       0       6       2       2       3       0    5.5     3.6     1.7        0
 3 england div1     2019-20…  2020 2020-03-10 01:00:00 Burton  Bolton        1       2       2       2 A       D            16       2       7       1       0      11       4       9       1       0    1.5     4.33    6.5        0
 4 england div1     2019-20…  2020 2020-03-10 01:00:00 Portsm… Fleetw…       1       2       1       2 D       D             9       2       5       2       0       9       6      10       4       0    2       3.5     3.75       0
 5 england div1     2019-20…  2020 2020-03-07 01:00:00 Accrin… Tranme…       0       1       1       2 A       A            14       2       5       1       1       9       2       5       3       0    1.83    3.6     4.33       0
 6 england div1     2019-20…  2020 2020-03-07 01:00:00 AFC Wi… Bolton        0       0       0       0 D       D            15       1      12       0       0      10       0       5       0       0    2.05    3.6     3.4        1
 7 england div1     2019-20…  2020 2020-03-07 01:00:00 Fleetw… Blackp…       0       0       0       0 D       D             8       1       3       0       0       8       1       5       2       0    1.83    3.6     4.33       1
 8 england div1     2019-20…  2020 2020-03-07 01:00:00 Ipswich Covent…       0       0       1       1 A       A             6       2       5       3       0       8       2       3       3       0    2.62    3.2     2.75       0
 9 england div1     2019-20…  2020 2020-03-07 01:00:00 Lincoln Burton        2       3       2       2 D       H             8       3       2       1       0      12       7       5       2       0    2.4     3.3     3          0
10 england div1     2019-20…  2020 2020-03-07 01:00:00 Milton… Doncas…       0       0       0       1 D       A            12       3       4       1       0      12       3       5       3       0    2.6     3.4     2.7        0
# … with 5,910 more rows, 7 more variables: under1.5 <dbl>, under2.5 <dbl>, under3.5 <dbl>, under4.5 <dbl>, under5.5 <dbl>, goal1T <dbl>, goal2T <dbl>, and abbreviated variable names ¹​home_team, ²​away_team, ³​home_goal_1T,
#   ⁴​home_goal_2T, ⁵​away_goal_1T, ⁶​away_goal_2T, ⁷​result_1T, ⁸​result_2T, ⁹​home_shots, ˟​home_target_shots, ˟​home_corners, ˟​home_yellow, ˟​home_red, ˟​away_shots, ˟​away_target_shots, ˟​away_corners, ˟​away_yellow, ˟​away_red, ˟​home_quote, ˟​drow_quote, ˟​away_quote, ˟​under0.5
```

### All the data available in the period 2005-2023

```r
> football_uk(country = "all", division = "all", year = c(start = 2005, end = 2023), verbose = TRUE)    

A tibble: 133,177 × 34
   country division season    year date                home_…¹ away_…² home_…³ home_…⁴ away_…⁵ away_…⁶ resul…⁷ resul…⁸ home_…⁹ home_…˟ home_…˟ home_…˟ home_…˟ away_…˟ away_…˟ away_…˟ away_…˟ away_…˟ home_…˟ drow_…˟ away_…˟ under…˟
   <chr>   <chr>    <chr>    <int> <dttm>              <chr>   <chr>     <dbl>   <dbl>   <dbl>   <dbl> <chr>   <chr>     <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <int>   <dbl>   <dbl>   <dbl>   <dbl>
 1 england premier  2022-20…  2023 2023-01-12 01:00:00 Fulham  Chelsea       1       2       0       1 H       H             8       3       5       4       0      20      10       7       3       1    3.3     3.5     2.15       0
 2 france  div1     2022-20…  2023 2023-01-11 01:00:00 Ajaccio Reims         0       0       1       1 A       A            11       1       2       3       0       9       3       2       3       0    3.1     3.1     2.5        0
 3 france  div1     2022-20…  2023 2023-01-11 01:00:00 Auxerre Toulou…       0       0       3       5 A       A            19       4       7       3       0       9       7       4       1       0    2.75    3.3     2.6        0
 4 france  div1     2022-20…  2023 2023-01-11 01:00:00 Brest   Lille         0       0       0       0 D       D             5       0       0       0       0      11       4       8       1       0    4       3.6     1.91       1
 5 france  div1     2022-20…  2023 2023-01-11 01:00:00 Clermo… Rennes        1       2       0       1 H       H            11       5       4       0       0       9       2       1       2       2    4.2     3.5     1.91       0
 6 france  div1     2022-20…  2023 2023-01-11 01:00:00 Nantes  Lyon          0       0       0       0 D       D            13       5       6       2       0      10       6       1       3       0    3.3     3.4     2.2        1
 7 france  div1     2022-20…  2023 2023-01-11 01:00:00 Lorient Monaco        0       2       0       2 D       D             8       6       3       1       0      16       4       4       1       0    3.8     3.75    1.91       0
 8 france  div1     2022-20…  2023 2023-01-11 01:00:00 Nice    Montpe…       2       6       0       1 H       H            16      10       3       1       0       4       2       4       1       0    1.8     3.6     4.5        0
 9 france  div1     2022-20…  2023 2023-01-11 01:00:00 Paris … Angers        1       2       0       0 H       H             9       6       5       1       0       6       0       1       2       0    1.11   10      19          0
10 france  div1     2022-20…  2023 2023-01-11 01:00:00 Strasb… Lens          2       2       2       2 D       D             9       6       3       1       0      15       8       4       1       0    3.8     3.5     1.95       0
# … with 133,167 more rows, 7 more variables: under1.5 <dbl>, under2.5 <dbl>, under3.5 <dbl>, under4.5 <dbl>, under5.5 <dbl>, goal1T <dbl>, goal2T <dbl>, and abbreviated variable names ¹​home_team, ²​away_team, ³​home_goal_1T,
#   ⁴​home_goal_2T, ⁵​away_goal_1T, ⁶​away_goal_2T, ⁷​result_1T, ⁸​result_2T, ⁹​home_shots, ˟​home_target_shots, ˟​home_corners, ˟​home_yellow, ˟​home_red, ˟​away_shots, ˟​away_target_shots, ˟​away_corners, ˟​away_yellow, ˟​away_red, ˟​home_quote, ˟​drow_quote, ˟​away_quote, ˟​under0.5
```

#### Have a question?

       
### The variables names

The output of the function `football_uk` is obtained from the original data in the website, but the names of the variables were changed to have a more interpretable dataset. 

#### Notes: difference between the season and the year 

For example, selecting the `year = 2018`, you will obtain all the matches in the years 2017 and 2018, that is the **season** "2017-2018". 

#### Match variables: general data

- **time**: starting time of the match.
- **date**: date of the match. 
- **home_team**: name of the home team. 
- **away_team**: name of the away team.
- **home_goal_1T**: number of goal of the home team at the end of the first half of the match .
- **home_goal_2T**: number of goal of the home team at the end of the second half.
- **away_goal_1T**: number of goal of the away team at the end of the first half.
- **away_goal_2T**: number of goal of the away team at the end of the second half.
- **result_1T**: result at the end of first half (A = away, D = draw, H = home).
- **result_2T**: result at the end of second half (A = away, D = draw, H = home).

#### Match variables: home data 

- **home_shots**: number of shots for the home team in the match.
- **home_target_shots**: number of shots near the football goal for the home team in the match.
- **home_corners**: number of corners for the home team in the match.
- **home_yellow**: number of yellow card for the home team in the match.
- **home_red**: number of red card for the home team in the match.

#### Match variables: away data 

- **away_shots**: number of shots for the away team in the match.
- **away_target_shots**: number of shots near the football goal for the away team in the match.
- **away_corners**: number of corners for the away team in the match.
- **away_yellow**: number of yellow card for the away team in the match.
- **away_red**: number of red card for the away team in the match.

#### Quotes variables 

- **home_quote**: reference home quote from Bet365 (is the only available for all country and all years)
- **draw_quote**: reference draw quote from Bet365 (is the only available for all country and all years)
- **away_quote**: reference away quote from Bet365 (is the only available for all country and all years)

#### Boolean variables: under

- **under0.5**: is 1 if the sum of the goal is strictly less than 1, otherwise is 0. 
- **under1.5**: is 1 if the sum of the goal is strictly less than 2, otherwise is 0.
- **under2.5**: is 1 if the sum of the goal is strictly less than 3, otherwise is 0.
- **under3.5**: is 1 if the sum of the goal is strictly less than 4, otherwise is 0.
- **under4.5**: is 1 if the sum of the goal is strictly less than 5, otherwise is 0.
- **under5.5**: is 1 if the sum of the goal is strictly less than 6, otherwise is 0.

#### Boolean variables: goal/no goal

- **Goal_1T**: is 1 if the sum of the goal in the first time is different from zero, otherwise is 0. 
- **Goal_2T**: is 1 if the sum of the goal in the second time (home_goal_2T + away_goal_2T) is different from zero, otherwise is 0. 

### Author

Beniamino Sartini



