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

# section: residuals = difference of  the observed  and predict values 
   dn$residuals

# section: coefficients
# to extract coef from the summary
  coef(summary(dn)) # coefficents 
# std. Error of ceof of (x)
  res.sd/sqrt(var(c(data[,1]))*(nrow(data)-1)) ->StdErr.b
# t value
  dn$coefficients[2]/StdErr.b -> t.value1
 c(StdErr.b, t.value1)
 
 # section: analysis of variance (multiple R^2 and adjusted R^2)
 tss <- var(data$lnWeight) * (nrow(data)-1 ) 
 sse <- sum(dn$residuals^2)
 regSS  <- tss - sse

# Residual standard error: 0.1229 on 13 degrees of freedom
res.sd = sqrt(sse / (nrow(data)-2))
res.sd

# multiple R^2 
r.squared = regSS / tss # proportion of the var in Y that is explained by 
                        # linear regression
# the adjusted R^2: follows
# 1 - (1- R^2)(n-1)/(n-1-k), where k = number of predictors
# 1 -R^2 = sse/tss
r.sq.adj = 1 - sse *(nrow(data[1])-1)/tss/(nrow(data[1])-2)

#section: F-statistic: and   p-value: 
#  F = (r^2/k)/ ( (1-R^2)/(n-1-k)) test the significance of R^2
# p-value is the prob for F with df1=k, df2 = n-1-k
#
F.stat = r.squared/((1-r.squared)/(nrow(data)-2))
F.pvalue = pf(F.stat, df1 =1, df2 = (nrow(data)-2), lower.tail = F)

