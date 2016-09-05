# url: https://www.r-bloggers.com/simple-linear-regression-2/

#  dataframe for simple regression
alligator <- data.frame(
  lnLength = c(3.87, 3.61, 4.33, 3.43, 3.81, 3.83, 3.46, 3.76,
    3.50, 3.58, 4.19, 3.78, 3.71, 3.73, 3.78),
  lnWeight = c(4.87, 3.93, 6.46, 3.33, 4.38, 4.70, 3.50, 4.50,
    3.58, 3.64, 5.90, 4.43, 4.38, 4.42, 4.25)
)  -> data

# visualize
plot(alligator)

# linear mode: dn for short name
alli.mod1 = lm(lnWeight ~ lnLength, data = alligator) -> dn
summary(dn)
# ------- out of summary 
## Call:
#    lm(formula = lnWeight ~ lnLength, data = alligator)

## Residuals:
##   Min       1Q   Median       3Q      Max 
## -0.24348 -0.03186  0.03740  0.07727  0.12669 

## Coefficients:
##   Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  -8.4761     0.5007  -16.93 3.08e-10 ***
##   lnLength      3.4311     0.1330   25.80 1.49e-12 ***
##   ---
##   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

## Residual standard error: 0.1229 on 13 degrees of freedom
## Multiple R-squared:  0.9808,	Adjusted R-squared:  0.9794 
## F-statistic: 665.8 on 1 and 13 DF,  p-value: 1.495e-12
# -------- end of summary ---

# section: residuals = difference of  the observed  and predict values 
   dn$residuals

# section: coefficients
# to extract coef from the summary
  coef(summary(dn)) # coefficents 
# std. Error of ceof of (x) 
# as std err of residuals / std deviation of X  
  res.sd/sqrt(var(c(data[,1]))*(nrow(data)-1)) ->StdErr.b
# t value = coef(x)/stdErr.d
  dn$coefficients[2]/StdErr.b -> t.value1
 c(StdErr.b, t.value1)
 # Pr(>|t|)
 pt(t.value1, df=13, lower.tail = F) *2
 
 # section: analysis of variance (multiple R^2 and adjusted R^2)
 tss <- var(data$lnWeight) * (nrow(data)-1 ) 
 sse <- sum(dn$residuals^2)
 regSS  <- tss - sse

# Residual standard error: 0.1229 on 13 degrees of freedom
res.sd = sqrt(sse / (nrow(data)-2))
res.sd

# multiple R^2 
r.squared = regSS / tss # proportion of the var in Y that is explained by 
r.squared                        # linear regression
# the adjusted R^2: follows
# 1 - (1- R^2)(n-1)/(n-1-k), where k = number of predictors
# 1 -R^2 = sse/tss
r.sq.adj = 1 - sse *(nrow(data[1])-1)/tss/(nrow(data[1])-2)

# alternative formula for r
cov(d1,d2)/sqrt(cov(d1,d1)*cov(d2,d2)) ->r.val
c(r.val^2, r.squared)

#section: F-statistic: and   p-value: 
#  F = (r^2/k)/ ( (1-R^2)/(n-1-k)) test the significance of R^2
# p-value is the prob for F with df1=k, df2 = n-1-k
#
F.stat = r.squared/((1-r.squared)/(nrow(data)-2))
F.pvalue = pf(F.stat, df1 =1, df2 = (nrow(data)-2), lower.tail = F)

# now make a prediction with 95% CI
predict(dn, data.frame(lnLength = 90), interval="confidence")

# Section: Example
# multiple linear regression from
# http://scc.stat.ucla.edu/page_attachments/0000/0140/reg_2.pdf

Url <- paste("http://archive.ics.uci.edu/ml/",
    "machine-learning-databases/",
    "pima-indians-diabetes/pima-indians-diabetes.data", sep ="")
pima <- read.table(Url, header=F, sep=",")
summary(pima)

colnames(pima) <- c("npreg", "glucose", "bp", "triceps", "insulin", "bmi", 
                    "diabetes", "age", "class")

# treating missing data
pima$glucose[pima$glucose==0] <- NA
pima$bp[pima$bp==0] <- NA
pima$triceps[pima$triceps==0] <- NA
pima$insulin[pima$insulin==0] <- NA
pima$bmi[pima$bmi==0] <- NA

#Coding Categorical Variables
pima$class <- factor (pima$class)
levels(pima$class) <- c("neg", "pos")




# Section: multiple linear regression: example by Felipe Rego
# Multiple Regression Analysis in R - First Steps

library(car)
library(corrplot) # We'll use corrplot later on in this example too.
library(visreg) # This library will allow us to show multivariate graphs.
library(rgl)
library(knitr)
library(scatterplot3d)

help("Prestige")
# Inspect and summarize the data.
  head(Prestige,5)
# Let's subset the data to capture income, education, women and prestige.
  newdata = Prestige[,c(1:4)]
  summary(newdata)
  # Plot matrix of all variables. pch = plot char
  plot(newdata, pch=19, col="blue", main="Matrix Scatterplot of Income, 
       Education, Women and Prestige")
  
  
set.seed(1)
  
# Center predictors.
education.c = scale(newdata$education, center=TRUE, scale=FALSE)
prestige.c = scale(newdata$prestige, center=TRUE, scale=FALSE)
women.c = scale(newdata$women, center=TRUE, scale=FALSE)
  
# bind these new variables into newdata and display a summary.
new.c.vars = cbind(education.c, prestige.c, women.c)
newdata = cbind(newdata, new.c.vars)
names(newdata)[5:7] = c("education.c", "prestige.c", "women.c" )
summary(newdata)  
# build the model
mod1 = lm(income ~ education.c + prestige.c + women.c, data=newdata)
  summary(mod1)  

  # Plot a correlation graph
  newdatacor = cor(newdata[1:4])
  corrplot(newdatacor, method = "number")

# note education and prestige are highly correlation, 
# and pr( >|t|) for education is in-significant, exclude edu   
# fit a linear model excluding the variable education
  mod2 = lm(income ~ prestige.c + women.c, data=newdata)
  summary(mod2)  
  
  # Plot model residuals.
  plot(mod2, pch=16, which=1)

  
  
  
  # categorical predictors
  hsb2 <- read.csv("http://www.ats.ucla.edu/stat/data/hsb2.csv")
  hsb2$race.f <- factor(hsb2$race)
  is.factor(hsb2$race.f)
   fit <- lm(write ~ race.f, data = hsb2)
   summary(fit)
   
   factor(hsb2$race.f)
   
# Section: Multiple linear regressions   
   