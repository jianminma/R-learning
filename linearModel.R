# linear mode
x <- c(37, 45, 43, 50, 65, 72, 61, 57, 48, 77)
y <- c(32, 36, 27, 34, 45, 49, 42, 38, 30, 47)
plot(x,y)
mean(x); mean(y)
var(x); var(y)
sd(x); sd(y)
cor(x,y)
fit <- lm(y~x)
fit
attributes(fit)
fit$coefficients # regression coeff
fit$residuals
fit$effects
fit$model # input data
fit$terms
fit$call  
fit$fitted.values # predicted values
summary(fit)
plot(fit)

