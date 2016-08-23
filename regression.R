x = c(18,23,25,35,65,54,34,56,72,19,23,42,18,39,37)
y = c(202,186,187,180,156,169,174,172,153,199,193,174,198,183,178)
plot(x,y) # make a plot
abline(lm(y ~ x)) # plot the regression line
lm.result = lm(y~x)
summary(lm.result)

lm.result$coefficients
lm.result$residuals
lm.result$call
lm.result$model
coef(lm.result)
predict(lm.result,data.frame(x= c(50,60)),
level=.9, interval="confidence")

# Section: how to interprete the result of linear regression

  # Using dataset: cars
attach(cars)
plot(cars, col='blue', pch=20, cex=2, main="Relationship between 
     Speed and Stopping Distance for 50 Cars", xlab="Speed in mph", 
     ylab="Stopping Distance in feet")

set.seed(122)
speed.c = scale(cars$speed, center=TRUE, scale=FALSE)
mod1 = lm(formula = dist ~ speed.c, data = cars)
summary(mod1)

# 
mod2 = lm(formula = dist ~ speed, data = cars)
summary(mod2)
# Call:
#  lm(formula = dist ~ speed, data = cars)

# Residuals:
#  Min      1Q  Median      3Q     Max 
# -29.069  -9.525  -2.272   9.215  43.201 

# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -17.5791     6.7584  -2.601   0.0123 *  
#  speed         3.9324     0.4155   9.464 1.49e-12 ***
---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
  
# Residual standard error: 15.38 on 48 degrees of freedom
# (SS)  Multiple R-squared:  0.6511,	Adjusted R-squared:  0.6438 
# F-statistic: 89.57 on 1 and 48 DF,  p-value: 1.49e-12
  
ss.total <-var(dist) * (length(dist)-1)
ss.total
# fitted.value
fv <-mod2$fitted.values - mean(dist)
ss.reg <- sum(fv^2)
ss.res <- sum(mod2$residuals^2)
# the above line explains (SS) in the summary
# Multiple R-squared:  0.6511,	Adjusted R-squared:  0.6438

c(ss.reg, ss.res)/ss.total ->r.square
# out> 0.6510794 0.3489206

# F-statistic: r2 = r.square, m=degree of freedom
r.square[1] * (length(dist)-2)/(1-r.square[1])
#out> 89.56711