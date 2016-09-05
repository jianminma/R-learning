# comments on R Reference card 2.0 bt Matt Baggott

# difference of & and &&
z <- c(TRUE, FALSE, 0, 6)
x <- c(TRUE, TRUE, FALSE, FALSE)
z & x # result: pairwise and

z && x # only the first element
z && (!x)

z| x
z||x

#index list
lst <- list(x=1:3, y = LETTERS[1:3], z= 3, 4)

# x[n] return a list; x[[n]] return n-th element
lst[1]
str(lst[1]) 
attributes(lst[1])

lst[[1]] ; 
str(lst[[1]]); 
attributes(lst[[1]])

lst[3]; lst[[3]]

# lst has attributes x, y, z
lst$x; lst$y; lst$z; lst$``

# internal structure of a matrix
m <- matrix(1:6, c(2,3))
m
attributes(m)
dimnames(m)
rownames(m) <- c('a','b')
colnames(m) <-LETTERS[1:3]
attributes(m)

# difference: in, %in%

