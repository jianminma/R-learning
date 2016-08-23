# generate regular expressions
a <- 1:20
b <- c(1:20)
c <- seq(from= 50, to = 100, by = 4)
d <- seq(length=20, from = 20, by=-0.2)
r1 <- rep(1:3, each=3)
r2 <- rep(1:3, time=3)
s1 <- sample(1:100, 30,replace = T)
s2 <- sample(1:10)
s3 <- sample(c(0,1), 40, replace = T, prob = c(0.6,0.4))
s5 <- sample.int(5000, 20, replace = F)

# general ways to get information about object: 
# mode(), type(), class(), attributes()