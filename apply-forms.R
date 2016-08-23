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
attach(trees)
apply(trees, 1, mean) # row-wise:1  (column-wise 2)
apply(trees, 2, max) # column

# 
M <- matrix(rnorm(1000^2), 1000,1000)
apply(M, 1, sd) # row by row
apply(M, 2, sd)
# highly optimized row[Means, Sums], colMeans

# lapply: apply a fun to list/vector, return a list
lapply(M[1:4,1:10], FUN = mean)

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

# rapply: apply recursive to a nested structure
n <- 17; fac <- factor(rep(1:3, length = n), levels = 1:5)
table(fac)
tapply(1:n, fac, sum)
tapply(1:n, fac, sum, simplify = FALSE)
tapply(1:n, fac, range)
tapply(1:n, fac, quantile)

