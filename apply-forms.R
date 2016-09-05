# various about *apply family 
# http://stackoverflow.com/questions/3505701/r-grouping-functions-sapply-vs-lapply-vs-apply-vs-tapply-vs-by-vs-aggrega
section1 <- c(57.3, 70.6, 73.9, 61.4, 63.0, 66.6, 74.8, 71.8, 63.2, 
              72.3, 61.9, 70.0)
section2 <- c(74.6, 74.5, 75.9, 77.4, 79.6, 70.2, 67.5, 75.5, 68.2, 
              81.0, 69.6, 75.6,  69.5, 72.4, 77.1)
section3 <- c(80.5, 79.2, 83.6, 74.9, 81.9, 80.3, 79.5, 77.3, 92.7, 
              76.4, 82.0, 68.9, 77.6, 74.6)
allSections <- list(section1,section2,section3)
section_means <- sapply(allSections, mean)

# when *apply to data frame, it will coerce to a matrix first
# Usage: apply(X, MARGIN, FUN, ...): X: array/matrix
attach(trees)
apply(trees, 1, mean) # row-wise:1  (column-wise 2)
apply(trees, 2, max) # column

# apply: input: array, output: vector, array, list
M <- matrix(rnorm(1000^2), 1000,1000)
apply(M, 1, sd) # row by row
apply(M, 2, sd)
# highly optimized row[Means, Sums], colMeans

## apply(M, index, fun)
## index : row/1, col/2, row+col/c(1,2)
## the first arg of fun: indexed ojbect
apply(M, 1, '+') # get the transpose
apply(M, 2, '+') # return M b/c R uses column-first

# another example of apply: three approaches for the 
# task:  add 1 to lst col, and compute mean by row
# approach 1. define a fun
x <- cbind(x1 = 3, x2 = c(4:1, 2:5)); x
myFUN<- function(x, c1, c2) { c(sum(x[c1],1), mean(x[c2])) }
# note the first arg: row(x), c1, c2 passed by ' '
apply(x,1,myFUN,c1='x1',c2=c('x1','x2'))

# approach 2: using internal structure of R
df <- data.frame(x1= x[,1]+1, x2 = rowMeans(x))

# approach 3: with an explicit loop
df<-data.frame()
 for(i in 1:nrow(x)){
     row<-x[i,]           # get each row value
     df<-rbind(df,rbind(c(sum(row[1],1), mean(row))))
     # compute and assign the value.
   }

#  compare three approaches above: 3> 1> 2
# 清空环境变量
> rm(list=ls())

# 封装fun1
fun1<-function(x){
   myFUN<- function(x, c1, c2) {c(sum(x[c1],1), mean(x[c2])) }
   apply(x,1,myFUN,c1='x1',c2=c('x1','x2'))
}

# 封装fun2
fun2<-function(x){
     df<-data.frame()
     for(i in 1:nrow(x)){
         row<-x[i,]
         df<-rbind(df,rbind(c(sum(row[1],1), mean(row))))
       }
   }

# 封装fun3
 fun3<-function(x){   data.frame(x1=x[,1]+1,x2=rowMeans(x))}

# 生成数据集
 x <- cbind(x1=3, x2 = c(400:1, 2:500))

# 分别统计3种方法的CPU耗时。
 system.time(fun1(x))
 system.time(fun2(x))
system.time(fun3(x))


# lapply: apply a fun to list/vector, return a list
lapply(M[1:4,1:10], FUN = mean)

# lapply can loop over a list or data frame by column, 
# but does not work on matrix or vector. Note a matrix is strored
# internally as a vector.

# as lapply, but return a vector
sapply(1:3, function(x) x^2 )

# vapply: is similar to sapply, but has a pre-specified type 
# of return value, so it can be safer (and sometimes faster) 
# to use.
x<- list(a =1, b=1:3, c=10:10000)
vapply(x, FUN = sum, FUN.VALUE = numeric(1))

# mapply: applies FUN to the first elements of each ... argument, 
# the second elements, the third elements, and so on. 
mapply(rep, times = 1:4, MoreArgs = list(x = 42))

mapply(function(x, y) seq_len(x) + y,
       c(a =  1, b = 2, c = 3),  # names from first
       c(A = 10, B = 0, C = -10))

# tapply: input:list, output:list
n <- 17; fac <- factor(rep(1:3, length = n), levels = 1:5)
table(fac)
tapply(1:n, fac, sum)
tapply(1:n, fac, sum, simplify = FALSE)
tapply(1:n, fac, range)
tapply(1:n, fac, quantile)

# aggregate: a generic function for data frames and time series.
aggregate(x=1:17, by = list(sample(1:3, 17, replace = T)), sum)->ag
# return a data frame