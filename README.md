# FootballR: a wrapper for football historical result 
### The data were provided from football-data.co.uk



### About 
[footballR](https://github.com/beniamino98/football) is an [R](https://www.r-project.org)
package that provide useful functions for importing football-data, for 10 states: 

- england 
- scotland 
- germany
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

It is possible to import data from a variety of data with the function: `football`

```r
> football(country = "england", div = "div1",  raw = FALSE )   

> football(country = "england", div = "div1",  raw = FALSE )   

# A tibble: 9,019 x 26
   division date  year  home_team away_team home_goal_2T away_goal_2T result_2T home_goal_1T away_goal_1T result_1T home_shots
   <chr>    <chr> <chr> <chr>     <chr>            <dbl>        <dbl> <chr>            <dbl>        <dbl> <chr>          <dbl>
 1 E2       2003… 2003  Barnsley  Colchest…            1            0 H                    0            0 D                  5
 2 E2       2003… 2003  Bristol … Notts Co…            5            0 H                    2            0 H                 17
 3 E2       2003… 2003  Luton     Rushden …            3            1 H                    0            1 A                  7
 4 E2       2003… 2003  Oldham    Brighton             1            3 A                    0            2 A                 10
 5 E2       2003… 2003  Peterboro Hartlepo…            3            4 A                    2            1 H                  9
# … with 9,009 more rows, and 14 more variables: away_shots <dbl>, home_target_shots <dbl>, away_target_shots <dbl>,
#   home_corners <dbl>, away_corners <dbl>, home_yellow <dbl>, away_yellow <dbl>, home_red <dbl>, away_red <dbl>,
#   home_quote <dbl>, drow_quote <dbl>, away_quote <dbl>, quote_over2.5 <dbl>, quote_under2.5 <dbl>

.... 

> df <- football( country = "italy", div = "div1", from = 2005, to = 2008)
> df
# A tibble: 1,520 x 24
   division date  year  home_team away_team home_goal_2T away_goal_2T result_2T home_goal_1T away_goal_1T result_1T home_shots away_shots
   <chr>    <chr> <chr> <chr>     <chr>            <dbl>        <dbl> <chr>            <dbl>        <dbl> <chr>          <dbl>      <dbl>
 1 I1       2005… 2005  Fiorenti… Sampdoria            2            1 H                    2            0 H                 15          9
 2 I1       2005… 2005  Livorno   Lecce                2            1 H                    1            1 D                 17          6
 3 I1       2005… 2005  Ascoli    Milan                1            1 D                    0            0 D                  8         16
 4 I1       2005… 2005  Inter     Treviso              3            0 H                    1            0 H                 16          7
 5 I1       2005… 2005  Juventus  Chievo               1            0 H                    1            0 H                 16          2
# … with 1,510 more rows, and 11 more variables: home_target_shots <dbl>, away_target_shots <dbl>, home_corners <dbl>, away_corners <dbl>,
#   home_yellow <dbl>, away_yellow <dbl>, home_red <dbl>, away_red <dbl>, home_quote <dbl>, drow_quote <dbl>, away_quote <dbl>

```
You can import non-recoded values in the raw form with raw = TRUE

```r
>  football(country = "england", div = "div1",  raw = TRUE )   

# A tibble: 9,019 x 151
   Div   Date  HomeTeam AwayTeam  FTHG  FTAG FTR    HTHG  HTAG HTR   Referee    HS    AS   HST   AST    HF    AF    HC    AC    HY
   <chr> <chr> <chr>    <chr>    <dbl> <dbl> <chr> <dbl> <dbl> <chr> <chr>   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
 1 E2    09/0… Barnsley Colches…     1     0 H         0     0 D     Colin …     5    10     5     5    16    13     7     1     1
 2 E2    09/0… Bristol… Notts C…     5     0 H         2     0 H     Joe Ro…    17    12    13     5    11    13     7     0     0
 3 E2    09/0… Luton    Rushden…     3     1 H         0     1 A     Iain W…     7    12     5     5    22    11     7     6     3
 4 E2    09/0… Oldham   Brighton     1     3 A         0     2 A     Eddie …    10     8     4     4    17    14     3     5     2
 
# … with 9,009 more rows, and 131 more variables: AY <dbl>, HR <dbl>, AR <dbl>, B365H <dbl>, B365D <dbl>, B365A <dbl>, GBH <dbl>,
#   GBD <dbl>, GBA <dbl>, IWH <dbl>, IWD <dbl>, IWA <dbl>, LBH <dbl>, LBD <dbl>, LBA <dbl>, SOH <dbl>, SOD <dbl>, SOA <dbl>,
#   SBH <dbl>, SBD <dbl>, SBA <dbl>, WHH <dbl>, WHD <dbl>, WHA <dbl>, `GB>2.5` <dbl>, `GB<2.5` <dbl>, GBAHH <dbl>, GBAHA <dbl>,
#   GBAH <dbl>, B365AHH <dbl>, B365AHA <dbl>, B365AH <dbl>, BWH <dbl>, BWD <dbl>, BWA <dbl>, LBAHH <dbl>, LBAHA <dbl>,
#   LBAH <dbl>, SJH <dbl>, SJD <dbl>, SJA <dbl>, VCH <dbl>, VCD <dbl>, VCA <dbl>, Bb1X2 <dbl>, BbMxH <dbl>, BbAvH <dbl>,
#   BbMxD <dbl>, BbAvD <dbl>, BbMxA <dbl>, BbAvA <dbl>, BbOU <dbl>, `BbMx>2.5` <dbl>, `BbAv>2.5` <dbl>, `BbMx<2.5` <dbl>,
#   `BbAv<2.5` <dbl>, BbAH <dbl>, BbAHh <dbl>, BbMxAHH <dbl>, BbAvAHH <dbl>, BbMxAHA <dbl>, BbAvAHA <dbl>, BSH <dbl>, BSD <dbl>,
#   BSA <dbl>, PSH <dbl>, PSD <dbl>, PSA <dbl>, PSCH <dbl>, PSCD <dbl>, PSCA <dbl>, Time <time>, MaxH <dbl>, MaxD <dbl>,
#   MaxA <dbl>, AvgH <dbl>, AvgD <dbl>, AvgA <dbl>, `B365>2.5` <dbl>, `B365<2.5` <dbl>, `P>2.5` <dbl>, `P<2.5` <dbl>,
#   `Max>2.5` <dbl>, `Max<2.5` <dbl>, `Avg>2.5` <dbl>, `Avg<2.5` <dbl>, AHh <dbl>, PAHH <dbl>, PAHA <dbl>, MaxAHH <dbl>,
#   MaxAHA <dbl>, AvgAHH <dbl>, AvgAHA <dbl>, B365CH <dbl>, B365CD <dbl>, B365CA <dbl>, BWCH <dbl>, BWCD <dbl>, BWCA <dbl>,
#   IWCH <dbl>, …
```


#### Team method for a cleaning extraction with the function `Team` 

params: 
  - .data: the dataframe of matches not raw 
  - team: character , the reference team 
  - home: logical FALSE, if TRUE only home match of the team 
  - away: logical FALSE, if TRUE only away match of the team 
  - vs: versus teams 


```r
df <- football( country = "italy", div = "div1", from = 2005, to = 2008)

# extract all match by a team 
 > Team(df, "Inter")
# A tibble: 152 x 24
   division date  year  home_team away_team home_goal_2T away_goal_2T result_2T home_goal_1T away_goal_1T result_1T home_shots away_shots
   <chr>    <chr> <chr> <chr>     <chr>            <dbl>        <dbl> <chr>            <dbl>        <dbl> <chr>          <dbl>      <dbl>
 1 I1       2005… 2005  Inter     Treviso              3            0 H                    1            0 H                 16          7
 2 I1       2005… 2005  Palermo   Inter                3            2 H                    1            0 H                 24         15
 
 
 

# extract all match by a team versus other teams 
 > Team(df, "Inter", vs = c("Juventus", "Napoli"))
 # A tibble: 10 x 24
   division date  year  home_team away_team home_goal_2T away_goal_2T result_2T home_goal_1T away_goal_1T result_1T home_shots away_shots
   <chr>    <chr> <chr> <chr>     <chr>            <dbl>        <dbl> <chr>            <dbl>        <dbl> <chr>          <dbl>      <dbl>
 1 I1       2005… 2005  Juventus  Inter                2            0 H                    2            0 H                  8         11
 2 I1       2006… 2006  Inter     Juventus             1            2 A                    0            0 D                 12          7
 3 I1       2007… 2007  Inter     Napoli               2            1 H                    2            0 H                 14         10
 


# extract all match by a team when play away 
 > Team(df, team = "Inter", away = TRUE )
 # A tibble: 76 x 13
 division date     year  home_team away_team away_goal_2T away_goal_1T away_shots away_target_sho… away_corners away_yellow away_red away_quote
   <chr>    <chr>    <chr> <chr>     <chr>            <dbl>        <dbl>      <dbl>            <dbl>        <dbl>       <dbl>    <dbl>      <dbl>
 1 I1       2005-09… 2005  Palermo   Inter                2            0         15                6            6           1        0       2   
 2 I1       2005-09… 2005  Chievo    Inter                1            0         17               10            7           2        0       1.72
 
 
 
# extract all match by a team when play home 
 > Team(df, team = "Inter", home = TRUE )
 # A tibble: 76 x 13
   division date       year  home_team away_team  home_goal_2T home_goal_1T home_shots home_target_shots home_corners home_yellow home_red home_quote
   <chr>    <chr>      <chr> <chr>     <chr>             <dbl>        <dbl>      <dbl>             <dbl>        <dbl>       <dbl>    <dbl>      <dbl>
 1 I1       2005-08-28 2005  Inter     Treviso               3            1         16                 9            6           1        0       1.16
 2 I1       2005-09-17 2005  Inter     Lecce                 3            2         12                 8            5           1        0       1.22



# extract all match by a team  when play home versus teams 
 > Team(df, team = "Inter", home = TRUE, vs = c("Juventus", "Napoli") )
 A tibble: 5 x 13
  division date       year  home_team away_team home_goal_2T home_goal_1T home_shots home_target_shots home_corners home_yellow home_red home_quote
  <chr>    <chr>      <chr> <chr>     <chr>            <dbl>        <dbl>      <dbl>             <dbl>        <dbl>       <dbl>    <dbl>      <dbl>
1 I1       2006-02-12 2006  Inter     Juventus             1            0         12                 7           10           2        0       2.5 
2 I1       2007-10-06 2007  Inter     Napoli               2            2         14                 4            3           3        0       1.25



# extract all match by a team  when play away versus teams
Team(df, team = "Inter", away = TRUE, vs = c("Juventus", "Napoli") )
# A tibble: 5 x 13
  division date       year  home_team away_team away_goal_2T away_goal_1T away_shots away_target_shots away_corners away_yellow away_red away_quote
  <chr>    <chr>      <chr> <chr>     <chr>            <dbl>        <dbl>      <dbl>             <dbl>        <dbl>       <dbl>    <dbl>      <dbl>
1 I1       2005-10-02 2005  Juventus  Inter                0            0         11                 6            9           3        0       3.6 
2 I1       2007-11-04 2007  Juventus  Inter                1            1          8                 5            7           2        0       2.7 

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
