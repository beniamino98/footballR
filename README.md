# FootballR: a wrapper for football historical result 


### Data Source 

The data were provided from [football-data.co.uk](https://www.football-data.co.uk). 


### About 
[footballR](https://github.com/beniamino98/football) is an [R](https://www.r-project.org)
package that provide useful tools for importing and analyize football-data, for 10 states:
"england", "scotland" , "germany", "italy", "spain", "france", "netherlands", "belgium"    
"portugal" and  "turkey". 

For every state there is one or more competition to analyize and the data were provided from
2003 in a standard way, but you can take even more. 


### Installation


To install the development version, you need to clone the repository and build
from source, or run one of:

```r
# lightweight
remotes::install_github("beniamino98/footballR")
# or
devtools::install_github("beniamino98/footballR")

```


### Getting Started

It is possible to import data from a variety of data with the function: `football()`

```r
> football(country = "england")   
$premier
# A tibble: 6,161 x 14
   div   date  year  resultT1 resultT2 home  away  home1T_goal home2T_goal away1T_goal away2T_goal home_quote drow_quote
   <chr> <chr> <chr> <chr>    <chr>    <chr> <chr>       <dbl>       <dbl>       <dbl>       <dbl>      <dbl>      <dbl>
 1 E0    2003… 2003  H        H        Arse… Ever…           1           2           0           1       1.4        3.8 
 2 E0    2003… 2003  H        H        Birm… Tott…           1           1           0           0       2.38       3.25
 
 
 $championship
# A tibble: 8,965 x 14
   div   date  year  resultT1 resultT2 home  away  home1T_goal home2T_goal away1T_goal away2T_goal home_quote drow_quote
   <chr> <chr> <chr> <chr>    <chr>    <chr> <chr>       <dbl>       <dbl>       <dbl>       <dbl>      <dbl>      <dbl>
 1 E1    2003… 2003  A        D        Brad… Norw…           0           2           1           2       2.38       3.2 
 2 E1    2003… 2003  D        A        Burn… Crys…           2           2           2           3       2.25       3.25
 
 $div1
# A tibble: 8,968 x 14
   div   date  year  resultT1 resultT2 home  away  home1T_goal home2T_goal away1T_goal away2T_goal home_quote drow_quote
   <chr> <chr> <chr> <chr>    <chr>    <chr> <chr>       <dbl>       <dbl>       <dbl>       <dbl>      <dbl>      <dbl>
 1 E2    2003… 2003  D        H        Barn… Colc…           0           1           0           0       1.91       3.25
 2 E2    2003… 2003  H        H        Bris… Nott…           2           5           0           0       1.57       3.4 
 
 $div2
# A tibble: 8,990 x 14
   div   date  year  resultT1 resultT2 home  away  home1T_goal home2T_goal away1T_goal away2T_goal home_quote drow_quote
   <chr> <chr> <chr> <chr>    <chr>    <chr> <chr>       <dbl>       <dbl>       <dbl>       <dbl>      <dbl>      <dbl>
 1 E3    2003… 2003  A        A        Carl… York            1           1           2           2       2.1        3.25
 2 E3    2003… 2003  D        D        Hudd… Camb…           1           2           1           2       1.73       3.5 
 

.... 

```

If you want to be more selective you can import just the years you want with the function `football_years()`
```
> football_years(country = "italy", div = "div1", start_year = 2005, end_year = 2008)
# A tibble: 1,520 x 14
   div   date  year  resultT1 resultT2 home  away  home1T_goal home2T_goal away1T_goal away2T_goal home_quote drow_quote
   <chr> <chr> <chr> <chr>    <chr>    <chr> <chr>       <dbl>       <dbl>       <dbl>       <dbl>      <dbl>      <dbl>
 1 I1    2005… 2005  H        H        Fior… Samp…           2           2           0           1       2.2        2.87
 2 I1    2005… 2005  D        H        Livo… Lecce           1           2           1           1       1.9        2.9 
 3 I1    2005… 2005  D        D        Asco… Milan           0           1           0           1       7.5        3.75
 4 I1    2005… 2005  H        H        Inter Trev…           1           3           0           0       1.16       5.5 

```



###### Have a question?



### Author

Beniamino Sartini

