# FootballR: historical football data with R 

### About 
FootballR is an [R](https://www.r-project.org)package that provide a framework for importing the data provided in the website [football-data.uk](https://www.football-data.co.uk) in form of csv files. The data are availables for 11 countries: 

- england 
- scotland 
- germany
- italy 
- spain
- france 
- netherlands
- belgium
- portugal 
- turkey 
- greece

For each country there are more than one division availables. 

 - div1: is the first division.
 - div2: is the second division.
 - div3: is the third division.

For England premier, championship, div1 and div2 are availables,while for Scotland premier, div1, div2 and div3. 
For the states: germany, italy, spain, france are availables the first and the second divisions.
For the other states is available only the first division. 


### Installation

To install the development version, you need to clone the repository and build
from source, or run one of:

```r
# lightweight
remotes::install_github("beniamino98/footballR")
# or
devtools::install_github("beniamino98/footballR")

library(footballR)

```

### Getting Started

You can look at the availables countries and their names using the function `info_countries`. 

```r
info_countries()

 [1] "england"     "scotland"    "germany"     "italy"       "spain"       "france"      "netherlands" "belgium"     "portugal"    "turkey"      "greece"     

```

You can look at the availables divisions and their names using the function `info_divisions`, without specifying any parameter (default = "all")
it will return a list with all countries and all the names of the availables divisions. 

```r
info_divisions(country = "all")
$england
[1] "premier"      "championship" "div1"         "div2"        

$scotland
[1] "premier" "div1"    "div2"    "div3"   

$germany
[1] "div1" "div2"

$italy
[1] "div1" "div2"

$spain
[1] "div1" "div2"

$france
[1] "div1" "div2"

$netherlands
[1] "div1"

$belgium
[1] "div1"

$portugal
[1] "div1"

$turkey
[1] "div1"

$greece
[1] "div1" 

```

Specifying a country it will return a vector of availables division for that country. 

```r

info_divisions("england")
       england        england        england        england 
     "premier" "championship"         "div1"         "div2"  

```


### Download Data 

You can import all the data available, specifying the argument "all" in both: country and division parameters. The years go from 2000 up today, but before 2010, they are not always consistent. An example: 
 
```r
> football_uk(country = "england", division = "div1", year = c(start = 2010, end = 2020), quiet = FALSE)    

# A tibble: 5,501 x 43
   country division season year  time       date       home_team away_team home_goal_1T home_goal_2T away_goal_1T away_goal_2T result_1T result_2T home_shots
   <chr>   <chr>    <chr>  <chr> <Period>   <date>     <chr>     <chr>            <int>        <int>        <int>        <int> <fct>     <fct>          <int>
 1 england div1     2020   2020  19H 0M 0S  2020-11-17 Oxford    Crewe                0            0            1            2 A         A                  5
 2 england div1     2020   2020  19H 0M 0S  2020-11-17 Swindon   Accringt…            0            0            3            3 A         A                 13
 3 england div1     2020   2020  19H 45M 0S 2020-11-16 Plymouth  Portsmou…            1            2            0            2 H         D                 14
 4 england div1     2020   2020  15H 0M 0S  2020-11-14 Bristol … Fleetwoo…            0            1            2            4 A         A                  8
 5 england div1     2020   2020  15H 0M 0S  2020-11-14 Crewe     Peterboro            2            2            0            0 H         H                 10
 6 england div1     2020   2020  15H 0M 0S  2020-11-14 Hull      Burton               0            2            0            0 D         H                 17
 7 england div1     2020   2020  15H 0M 0S  2020-11-14 Northamp… Accringt…            0            0            1            1 A         A                  7
 8 england div1     2020   2020  15H 0M 0S  2020-11-14 Shrewsbu… Swindon              2            3            1            3 H         D                 10
 9 england div1     2020   2020  15H 0M 0S  2020-11-14 Sunderla… Milton K…            1            1            1            2 D         A                 11
10 england div1     2020   2020  18H 0M 0S  2020-11-03 Shrewsbu… Burton               0            1            0            1 D         D                 15
  … with 5,491 more rows, and 28 more variables: home_target_shots <int>, home_corners <int>, home_yellow <int>, home_red <int>, away_shots <int>, away_target_shots <int>, away_corners <int>, away_yellow <int>, away_red <int>, home_quote <dbl>, drow_quote <dbl>, away_quote <dbl>, over0.5 <dbl>, over1.5<dbl>, over2.5 <dbl>, over3.5 <dbl>, over4.5 <dbl>, over5.5 <dbl>, under0.5 <dbl>, under1.5 <dbl>, under2.5 <dbl>, under3.5 <dbl>, under4.5 <dbl>, under5.5 <dbl>,
winHome <dbl>, winAway <dbl>, isGoal_1T <dbl>, isGoal_2T <dbl>
```


###### Have a question?

### Author

Beniamino Sartini


####  VARIABLE NOTES 

The output variables are recoded from the original data and they assume the following meaning: 

##### General variables 

- <strong>country</strong> : the reference country 
- division: the reference division
- season: the reference season
- year: the reference year

Note: difference between season and year ( example for year = 2018)
Under the year 2018 there are the match between 2018 and 2019. The season argument in this case will be "2018-2019" while year = "2018".

##### Match variables 

##### Match variables: general data
- time: starting time of the match.
- date: date of the match. 
- home_team 
- away_team
- home_goal_1T: number of goal of the home team at the end of the first time.
- home_goal_2T: number of goal of the home team at the end of the second time.
- away_goal_1T: number of goal of the away team at the end of the first time.
- away_goal_2T: number of goal of the away team at the end of the second time.
- result_1T: result at the end of first time (A = away, D = drow, H = home).
- result_2T: result at the end of second time (A = away, D = drow, H = home).

##### Match variables: home data 
- home_shots 
- home_target_shots 
- home_corners
- home_yellow 
- home_red

##### Match variables: away data 
- away_shots 
- away_target_shots 
- away_corners
- away_yellow 
- away_red

##### Quotes variables 
- home_quote: reference home quote from Bet365 (is the only available for all country and all years)
- drow_quote: reference drow quote from Bet365 (is the only available for all country and all years)
- away_quote: reference away quote from Bet365 (is the only available for all country and all years)

##### Boolean variables: over  
- over0.5: is 1 if the sum of the goal is greater or equal than 1, otherwise is 0. 
- over1.5: is 1 if the sum of the goal is greater or equal than 2, otherwise is 0. 
- over2.5: is 1 if the sum of the goal is greater or equal than 3, otherwise is 0. 
- over3.5: is 1 if the sum of the goal is greater or equal than 4, otherwise is 0. 
- over4.5: is 1 if the sum of the goal is greater or equal than 5, otherwise is 0. 
- over5.5: is 1 if the sum of the goal is greater or equal than 6, otherwise is 0. 

##### Boolean variables: under 
- under0.5: is 1 if the sum of the goal is strictly less than 1, otherwise is 0. 
- under1.5: is 1 if the sum of the goal is strictly less than 2, otherwise is 0.
- under2.5: is 1 if the sum of the goal is strictly less than 3, otherwise is 0.
- under3.5: is 1 if the sum of the goal is strictly less than 4, otherwise is 0.
- under4.5: is 1 if the sum of the goal is strictly less than 5, otherwise is 0.
- under5.5: is 1 if the sum of the goal is strictly less than 6, otherwise is 0.

##### Boolean variables: win / goal 
- winHome: is 1 the home team win the match (result_2T = H), otherwise is 0.
- winAway: is 1 the away team win the match (result_2T = A), otherwise is 0.
- isGoal_1T: is 1 if the sum of the goal in the first time is different from zero, otherwise is 0. 
- isGoal_2T: is 1 if the sum of the goal in the second time (home_goal_2T + away_goal_2T) is different from zero, otherwise is 0. 




