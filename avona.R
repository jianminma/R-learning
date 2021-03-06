# youtube: MarinStatsLectures

# difference of two samples can be tested by 
# t.test()



s <-c(15,10,12,8,21,7,13,3, 
      20, 13, 9, 22, 24, 25,18,12,
      10,24,29,12,27,21,25,14,
      30,22, 26,20,29, 28, 25,15)
f<-rep(1:4, each=8)
df <- data.frame(s, f)
# mean by factor
aggregate(s, by=list(f), mean) -> ave 
aggregate(s, by=list(f), var)

plot(s~factor(f), data=df)
# ANOVA
library(stats)
result <- aov(s~factor(f), data=df)
summary(result)
##              Df Sum Sq Mean Sq F value  Pr(>F)   
## factor(f)    3  738.6  246.20   6.818 0.00136 **
## Residuals   28 1011.1   36.11                   
## ---
##  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# plot the residuals for each factor
plot(result$residuals~(f))

# section: how to obtain the values in summary
ss.total = var(s) * (length(s)-1)
mean.factor <- rep(c(ave[,2]), each = 8)
# or 
mean.factor <- result$fitted.values

ss.within <-sum((s- mean.factor)^2)
ss.betw <- sum((mean.factor- mean(s))^2)
c(ss.betw, ss.within, ss.total)
MS.betw <-ss.betw/3
MS.within <- ss.within/28
f.value <- MS.betw/MS.within
pr <- 1 -pf(f.value, 3, 28)
c(MS.betw, MS.within, f.value)

mod2 <-lm(s~factor(f), data=df)
summary(mod2)


# Section: two-three factor -Anova
# http://www.math.wustl.edu/~victor/classes/ma322/r-eg-11.txt

## Example R programs and commands
## 11. Two- and Three-factor ANOVA; Mixed Models; Cochran's Test

# All lines preceded by the "#" character are my comments.
# All other left-justified lines are my input.
# All other indented lines are the R program output.
#
#
#
# Two-way ANOVA
# Tabulated data for input to R
# 
#    BELLY-BUTTON LINT MASS IN GREAT APES
#
##       Species 1   Species 2  Species 3
#       ---------   ---------  ---------
# Male
# 21.8        14.5      16.0
# 19.6        17.6      20.3
# 20.5        15.9      18.5
# 22.4        17.8      19.3
# Female         
# 14.5        12.1      14.4
# 15.4        11.4      14.7
# 13.0        12.7      13.8
# 16.8        14.5      12.0
#
# Put the data into convenient-length packages:
xm <- c(21.8,14.5,16.0, 19.6,17.6,20.3, 20.5,15.9,18.5, 22.4,17.8,19.3)
xf <- c(14.5,12.1,14.4, 15.4,11.4,14.7, 13.0,12.7,13.8, 16.8,14.5,12.0)
lintmass <- c(xm,xf)
# Prepare labels for the 2*3*4 pieces of data according to factor levels:
#   Species 1  Species 2 Species 3;   Species 1  Species 2 Species 3; ...
species <- gl(3,1,4*3*2, labels=c("Species 1","Species 2","Species 3") )
#   Male  Male ... Male;  Female  Female ... Female
gender <- gl(2,3*4,2*3*4, labels=c("Male", "Female") )

# Model I (fixed-effects) ANOVA for all effects and interactions:
anova( lm(lintmass ~ species*gender) )

# Analysis of Variance Table
# Response: lintmass
#                Df  Sum Sq Mean Sq F value    Pr(>F)
# species         2  47.396  23.698 10.8079 0.0008253 ***
# gender          1 144.550 144.550 65.9253 1.983e-07 ***
# species:gender  2   5.676   2.838  1.2943 0.2984104
# Residuals      18  39.468   2.193
---
# Signif. codes:  0 `***' 0.001 `**' 0.01 `*' 0.05 `.' 0.1 ` ' 1

# Model I (fixed-effects) ANOVA for just the single-factor effects:
anova( lm(lintmass ~ species+gender) )

# Analysis of Variance Table
# Response: lintmass
#           Df  Sum Sq Mean Sq F value    Pr(>F)
# species    2  47.396  23.698  10.499 0.0007633 ***
# gender     1 144.550 144.550  64.041  1.16e-07 ***
# Residuals 20  45.143   2.257
# ---
# Signif. codes:  0 `***' 0.001 `**' 0.01 `*' 0.05 `.' 0.1 ` ' 1

# Model I ANOVA for just the factor interactions:
anova( lm(lintmass ~ species:gender) )

# Analysis of Variance Table

# Response: lintmass
#                Df  Sum Sq Mean Sq F value    Pr(>F)
# species:gender  5 197.622  39.524  18.026 1.898e-06 ***
# Residuals      18  39.468   2.193
# ---
# Signif. codes:  0 `***' 0.001 `**' 0.01 `*' 0.05 `.' 0.1 ` ' 1

# Model II and Model III (mixed random and fixed effects models) are
#  handled differently, using the `nlme' package:
  library(nlme)               # load the extra package
ldata<-data.frame(lintmass,species,gender)    # make an ape lint database

# Model II (random effects) with species choice first
ldata1<-groupedData( lintmass ~ 1 | species/gender, data=ldata)
anova(lme(ldata1))
lme(ldata1)

Linear mixed-effects model fit by REML
Data: ldata1
Log-restricted-likelihood: -50.48286
Fixed: lintmass ~ 1
(Intercept)
16.22917

Random effects:
  Formula: ~1 | species
(Intercept)
StdDev: 0.0002757162

Formula: ~1 | gender %in% species
(Intercept) Residual
StdDev:    3.054987 1.480756

Number of Observations: 24
Number of Groups:
  species gender %in% species

3                   6

# Determine the p-value of the combined random effects
anova(lme(ldata1))
numDF denDF  F-value p-value
(Intercept)     1    18 159.9331  <.0001


# Model II (random effects) with gender choice first
ldata2<-groupedData( lintmass ~ 1 | gender/species, data=ldata)
lme(ldata2)

Linear mixed-effects model fit by REML
Data: ldata2
Log-restricted-likelihood: -48.94808
Fixed: lintmass ~ 1
(Intercept)
16.22917

Random effects:
  Formula: ~1 | gender
(Intercept)
StdDev:    3.307584

Formula: ~1 | species %in% gender
(Intercept) Residual
StdDev:    1.663978 1.480756

Number of Observations: 24
Number of Groups:
  gender species %in% gender
2                   6
anova(lme(ldata2))
numDF denDF  F-value p-value
(Intercept)     1    18 43.73083  <.0001



# Model III (mixed-effects model) with gender fixed, species random:
ldata3<-groupedData( lintmass ~ gender | species, data=ldata)
lme(ldata3)
Linear mixed-effects model fit by REML
Data: ldata3
Log-restricted-likelihood: -43.77833
Fixed: lintmass ~ gender
(Intercept) genderFemale
18.683333    -4.908333

Random effects:
  Formula: ~gender | species
Structure: General positive-definite
StdDev   Corr
(Intercept)  2.228741 (Intr)
genderFemale 1.145785 -1
Residual     1.404832

Number of Observations: 24
Number of Groups: 3

anova(lme(ldata3))
numDF denDF   F-value p-value
(Intercept)     1    20 312.68844  <.0001
gender          1    20  31.42948  <.0001


# Model III (mixed-effects model) with species fixed, gender random:
ldata4<-groupedData( lintmass ~ species | gender, data=ldata)
lme(ldata4)

Linear mixed-effects model fit by REML
Data: ldata4
Log-restricted-likelihood: -42.22040
Fixed: lintmass ~ species
(Intercept) speciesSpecies 2 speciesSpecies 3
18.0000          -3.4375          -1.8750

Random effects:
  Formula: ~species | gender
Structure: General positive-definite
StdDev    Corr
(Intercept)      4.3200580 (Intr) spcsS2
speciesSpecies 2 1.6683516 -1
speciesSpecies 3 0.9483107 -1      1
Residual         1.4047687

Number of Observations: 24
Number of Groups: 2

anova(lme(ldata4))
numDF denDF  F-value p-value
(Intercept)     1    20 74.02480  <.0001
species         2    20  3.13466  0.0654


# Dichotomous variables 2-way ANOVA
#
# Tabulated data for input to R
# 
#    CARNIVAL RIDE USE BY FIELD TRIPPERS
#
# F.T   Ride 1   Ride 2  Ride 3  Ride 4
# ===   ------   ------  ------  ------
#  1      0        0       1       1
#  2      0        0       1       1
#  3      0        0       1       0
#  4      0        0       0       1
#  5      0        0       1       1
#  6      0        1       1       1
#
#
# Put the data into a single list:
use <- c( 0,0,1,1, 0,0,1,1, 0,0,1,0, 0,0,0,1, 0,0,1,1, 0,1,1,1)
# Label the entries by factor level:
ride<-gl(4,1,4*6,labels=c("Ride 1", "Ride 2", "Ride 3", "Ride 4"))
fieldtripper<-gl(6,4,4*6)
# See what the labels look like:
>ride
[1] Ride 1 Ride 2 Ride 3 Ride 4 Ride 1 Ride 2 Ride 3 Ride 4 Ride 1 Ride 2
[11] Ride 3 Ride 4 Ride 1 Ride 2 Ride 3 Ride 4 Ride 1 Ride 2 Ride 3 Ride 4
[21] Ride 1 Ride 2 Ride 3 Ride 4
Levels: Ride 1 Ride 2 Ride 3 Ride 4
>fieldtripper
[1] 1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6
Levels: 1 2 3 4 5 6
# Perform the ANOVA checking only the individual factors:
anova( lm( use ~ ride + fieldtripper) )

Analysis of Variance Table

Response: use
Df Sum Sq Mean Sq F value    Pr(>F)
fieldtripper  5 0.7083  0.1417  1.1860 0.3617613
ride          3 3.4583  1.1528  9.6512 0.0008533 ***
  Residuals    15 1.7917  0.1194
---
  Signif. codes:  0 `***' 0.001 `**' 0.01 `*' 0.05 `.' 0.1 ` ' 1


# Cochran's test for a dichotomous variable
#
# Tabulated data for input to R
# 
#    CARNIVAL RIDE USE BY FIELD TRIPPERS
#
# F.T   Ride 1   Ride 2  Ride 3  Ride 4
# ===   ------   ------  ------  ------
#  1      0        0       1       1
#  2      0        0       1       1
#  3      0        0       1       0
#  4      0        0       0       1
#  5      0        0       1       1
#  6      0        1       1       1
#
# Input the array by cutting and pasting after "scan()"
> data <- scan()
1      0        0       1       1
2      0        0       1       1
3      0        0       1       0
4      0        0       0       1
5      0        0       1       1
6      0        1       1       1

> data <- t(array(data, c(5,6)))   # transpose! data[] is now 6x5
> data
[,1] [,2] [,3] [,4] [,5]
[1,]    1    0    0    1    1
[2,]    2    0    0    1    1
[3,]    3    0    0    1    0
[4,]    4    0    0    0    1
[5,]    5    0    0    1    1
[6,]    6    0    1    1    1
> table <- data[, 2:5]             # remove first column
> table
[,1] [,2] [,3] [,4]
[1,]    0    0    1    1
[2,]    0    0    1    1
[3,]    0    0    1    0
[4,]    0    0    0    1
[5,]    0    0    1    1
[6,]    0    1    1    1
> source{"cochran.R")              # defines cochranQ()
# ...alternatively, cut and paste "cochran.R" into the R session.
> cochranQ(table)

Cochran's Q
Q  =     5.666667               DF = 5          p = 0.3400161
Qt =     11.85714               DF = 3          p = 0.1290031






#
# Three-Factor ANOVA:
# 
# Read the data using scan():
#
#          a1               a2               a3               a4
#     -------------    -------------    -------------    -------------
#     b1   b2   b3     b1   b2   b3     b1   b2   b3     b1   b2   b3
#     ---  ---  ---    ---  ---  ---    ---  ---  ---    ---  ---  ---
#
# c1:
4.1  4.6  3.7    4.9  5.2  4.7    5.0  6.1  5.5    3.9  4.4  3.7
4.3  4.9  3.9    4.6  5.6  4.7    5.4  6.2  5.9    3.3  4.3  3.9
4.5  4.2  4.1    5.3  5.8  5.0    5.7  6.5  5.6    3.4  4.7  4.0
3.8  4.5  4.5    5.0  5.4  4.5    5.3  5.7  5.0    3.7  4.1  4.4
4.3  4.8  3.9    4.6  5.5  4.7    5.4  6.1  5.9    3.3  4.2  3.9
#
# c2:
4.8  5.6  5.0    4.9  5.9  5.0    6.0  6.0  6.1    4.1  4.9  4.3  
4.5  5.8  5.2    5.5  5.3  5.4    5.7  6.3  5.3    3.9  4.7  4.1
5.0  5.4  4.6    5.5  5.5  4.7    5.5  5.7  5.5    4.3  4.9  3.8
4.6  6.1  4.9    5.3  5.7  5.1    5.7  5.9  5.8    4.0  5.3  4.7
5.0  5.4  4.7    5.5  5.5  4.9    5.5  5.7  5.6    4.3  4.3  3.8
#
# NOTE: Cut and paste the numbers without the leading # or labels
#

> Y <- scan()
> A <- gl(4,3, 4*3*2*5, labels=c("a1","a2","a3","a4"));
> B <- gl(3,1, 4*3*2*5, labels=c("b1","b2","b3"));
> C <- gl(2,60, 4*3*2*5, labels=c("c1","c2"));
> anova(lm(Y~A*B*C))   # all effects and interactions
Analysis of Variance Table

Response: Y
Df Sum Sq Mean Sq  F value    Pr(>F)
A          3 40.322  13.441 182.4506 < 2.2e-16 ***
B          2  8.821   4.411  59.8722 < 2.2e-16 ***
C          1  4.760   4.760  64.6165 2.356e-12 ***
A:B        6  0.814   0.136   1.8420   0.09895 .
A:C        3  2.351   0.784  10.6376 4.216e-06 ***
B:C        2  0.126   0.063   0.8563   0.42793
A:B:C      6  0.944   0.157   2.1354   0.05616 .
Residuals 96  7.072   0.074
---
Signif. codes:  0 `***' 0.001 `**' 0.01 `*' 0.05 `.' 0.1 ` ' 1

> anova(lm(Y~A+B+C))   # only effects, no interactions
Analysis of Variance Table

Response: Y
Df Sum Sq Mean Sq F value    Pr(>F)
A           3 40.322  13.441 134.321 < 2.2e-16 ***
B           2  8.821   4.411  44.078 7.068e-15 ***
C           1  4.760   4.760  47.571 3.227e-10 ***
Residuals 113 11.307   0.100
---
Signif. codes:  0 `***' 0.001 `**' 0.01 `*' 0.05 `.' 0.1 ` ' 1

> anova(lm(Y~A:B+A:C+B:C))   # only two-way interactions
Analysis of Variance Table

Response: Y
Df Sum Sq Mean Sq F value    Pr(>F)
A:B        11 49.957   4.542 57.7902 < 2.2e-16 ***
A:C         4  7.111   1.778 22.6215 2.147e-13 ***
B:C         2  0.126   0.063  0.8027    0.4509
Residuals 102  8.016   0.079
---
Signif. codes:  0 `***' 0.001 `**' 0.01 `*' 0.05 `.' 0.1 ` ' 1
















