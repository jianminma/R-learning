data(attitude);  str(attitude)
help(attitude); summary(attitude)

# perform CA on two variables, maybe PCA late
dat <-attitude[,c(3,4)]
plot(dat, main="% of favorable responses to Learning and Privilege",
     pch =20, cex =2)
pairs(attitude)

# linear regression
fit <- lm(rating~complaints+privileges+learning+raises+critical+advance-1,
          data=attitude)
summary(fit)

#pca
mat.cov <- cov(attitude); mat.cov
rbind(apply(attitude, 2, var), apply(attitude, 2, sd))

# eigenvalue/vectors of cov matrix
eigen(mat.cov)
att.pca <-prcomp(attitude); att.pca

## explain where sdev is from
apply( as.matrix(attitude) %*% att.pca$rotation, 2, sd)
att.pca$sdev 
## where center is from
apply(attitude,2, mean)
att.pca$center

## the x field: rotated data along PC's: obtained by attitue * eigenvectors
(as.matrix(attitude)- matrix(rep(att.pca$center, each =nrow(attitude)), 
                             nrow=nrow(attitude)))->centered.att
(centered.att %*% att.pca$rotation)[1,] - att.pca$x[1,]
# x: cov are 0
round(cov(att.pca$x),2)

## how many PC's should be keep:
## 1. 8-90% variance
## 2. Kaiser's rule: retain as many PC's whose var > mean of var
plot(att.pca, type='l') # 1. PC1-4

sum(apply(attitude, 2, var))
(eigen(mat.cov)$values) ->eig.values
mean(eig.values) # 2. PC1-3

# plot PC1-2
plot(att.pca$x[,1], att.pca$x[,2])
