# FootballR: a wrapper for football historical result 
### The data were provided from football-data.co.uk



### About 
[footballR](https://github.com/beniamino98/football) is an [R](https://www.r-project.org)
package that provide useful functions for importing football-data, for 11 states: 

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

- div1: is the first division 
- div2: is the second division
- div3: is the third division

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

Specifying a country it will returna vector of availables division for that country. 
```r

info_divisions("england")
       england        england        england        england 
     "premier" "championship"         "div1"         "div2"  

```


### Importing Data 

It is possible to import a several types of data with the function: `football_uk`. You can import all the data availables, using country = "all" and division = "all" and specifying just the range of years. 

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

#### *** 
####  VARIABLE NOTES 

#####  match information
Div = League Division

Date = Match Date (dd/mm/yy)

Time = Time of match kick off

HomeTeam = Home Team

AwayTeam = Away Team

FTHG and HG = Full Time Home Team Goals

FTAG and AG = Full Time Away Team Goals

FTR and Res = Full Time Result (H=Home Win, D=Draw, A=Away Win)

HTHG = Half Time Home Team Goals


HTAG = Half Time Away Team Goals

HTR = Half Time Result (H=Home Win, D=Draw, A=Away Win)



##### Match Statistics (where available)

Attendance = Crowd Attendance 

Referee = Match Referee

HS = Home Team Shots

AS = Away Team Shots

HST = Home Team Shots on Target

AST = Away Team Shots on Target

HHW = Home Team Hit Woodwork

AHW = Away Team Hit Woodwork

HC = Home Team Corners

AC = Away Team Corners

HF = Home Team Fouls Committed

AF = Away Team Fouls Committed

HFKC = Home Team Free Kicks Conceded

AFKC = Away Team Free Kicks Conceded

HO = Home Team Offsides

AO = Away Team Offsides

HY = Home Team Yellow Cards

AY = Away Team Yellow Cards

HR = Home Team Red Cards

AR = Away Team Red Cards

HBP = Home Team Bookings Points (10 = yellow, 25 = red)

ABP = Away Team Bookings Points (10 = yellow, 25 = red)

####### Note that Free Kicks Conceeded includes fouls, offsides and any other offense commmitted and will always be equal to or higher than the number of fouls. Fouls make up the vast majority of Free Kicks Conceded. Free Kicks Conceded are shown when specific data on Fouls are not available (France 2nd, Belgium 1st and Greece 1st divisions).

####### Note also that English and Scottish yellow cards do not include the initial yellow card when a second is shown to a player converting it into a red, but this is included as a yellow (plus red) for European games.


#### Key to 1X2 (match) betting odds data:
  
B365H = Bet365 home win odds

B365D = Bet365 draw odds

B365A = Bet365 away win odds

BSH = Blue Square home win odds

BSD = Blue Square draw odds

BSA = Blue Square away win odds

BWH = Bet&Win home win odds

BWD = Bet&Win draw odds

BWA = Bet&Win away win odds

GBH = Gamebookers home win odds

GBD = Gamebookers draw odds

GBA = Gamebookers away win odds

IWH = Interwetten home win odds

IWD = Interwetten draw odds

IWA = Interwetten away win odds

LBH = Ladbrokes home win odds

LBD = Ladbrokes draw odds

LBA = Ladbrokes away win odds

PSH and PH = Pinnacle home win odds

PSD and PD = Pinnacle draw odds

PSA and PA = Pinnacle away win odds

SOH = Sporting Odds home win odds

SOD = Sporting Odds draw odds

SOA = Sporting Odds away win odds

SBH = Sportingbet home win odds

SBD = Sportingbet draw odds

SBA = Sportingbet away win odds

SJH = Stan James home win odds

SJD = Stan James draw odds

SJA = Stan James away win odds

SYH = Stanleybet home win odds

SYD = Stanleybet draw odds

SYA = Stanleybet away win odds

VCH = VC Bet home win odds

VCD = VC Bet draw odds

VCA = VC Bet away win odds

WHH = William Hill home win odds

WHD = William Hill draw odds

WHA = William Hill away win odds

Bb1X2 = Number of BetBrain bookmakers used to calculate match odds averages and maximums

BbMxH = Betbrain maximum home win odds

BbAvH = Betbrain average home win odds

BbMxD = Betbrain maximum draw odds

BbAvD = Betbrain average draw win odds

BbMxA = Betbrain maximum away win odds

BbAvA = Betbrain average away win odds

MaxH = Market maximum home win odds

MaxD = Market maximum draw win odds

MaxA = Market maximum away win odds

AvgH = Market average home win odds

AvgD = Market average draw win odds

AvgA = Market average away win odds




#### Key to total goals betting odds:
  
BbOU = Number of BetBrain bookmakers used to calculate over/under 2.5 goals (total goals) averages and maximums

BbMx>2.5 = Betbrain maximum over 2.5 goals

BbAv>2.5 = Betbrain average over 2.5 goals

BbMx<2.5 = Betbrain maximum under 2.5 goals

BbAv<2.5 = Betbrain average under 2.5 goals

GB>2.5 = Gamebookers over 2.5 goals

GB<2.5 = Gamebookers under 2.5 goals

B365>2.5 = Bet365 over 2.5 goals

B365<2.5 = Bet365 under 2.5 goals

P>2.5 = Pinnacle over 2.5 goals

P<2.5 = Pinnacle under 2.5 goals

Max>2.5 = Market maximum over 2.5 goals

Max<2.5 = Market maximum under 2.5 goals

Avg>2.5 = Market average over 2.5 goals

Avg<2.5 = Market average under 2.5 goals





#### Key to Asian handicap betting odds:
  
BbAH = Number of BetBrain bookmakers used to Asian handicap averages and maximums

BbAHh = Betbrain size of handicap (home team)

AHh = Market size of handicap (home team) (since 2019/2020)

BbMxAHH = Betbrain maximum Asian handicap home team odds

BbAvAHH = Betbrain average Asian handicap home team odds

BbMxAHA = Betbrain maximum Asian handicap away team odds

BbAvAHA = Betbrain average Asian handicap away team odds

GBAHH = Gamebookers Asian handicap home team odds

GBAHA = Gamebookers Asian handicap away team odds

GBAH = Gamebookers size of handicap (home team)

LBAHH = Ladbrokes Asian handicap home team odds

LBAHA = Ladbrokes Asian handicap away team odds

LBAH = Ladbrokes size of handicap (home team)

B365AHH = Bet365 Asian handicap home team odds

B365AHA = Bet365 Asian handicap away team odds

B365AH = Bet365 size of handicap (home team)

PAHH = Pinnacle Asian handicap home team odds

PAHA = Pinnacle Asian handicap away team odds

MaxAHH = Market maximum Asian handicap home team odds

MaxAHA = Market maximum Asian handicap away team odds	

AvgAHH = Market average Asian handicap home team odds

AvgAHA = Market average Asian handicap away team odds
