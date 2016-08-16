# describle, visualize uni-variate data
beer = sample(1:4, 100, replace = TRUE)

# simple plot
barplot(beer)
# frequence plot
barplot(table(beer))
# pie char
beer_cnt = table(beer)
names(beer_cnt) <- c("Bud", 'fat tires', 'Miller', "Coors")
pie(beer_cnt, col=c("purple","green2","cyan","white"))
# relatvie frequency plot
barplot(table(beer)/length(beer))
# note the difference of bar-graph (normial data) and 
#                        histgram (non-nomial data):
hist(beer, probability = T)
# boxplot 
boxplot(beer)

# stem plot
r <-rnorm(25) *10
stem(r, scale=4)

# cummulative frequency polygon
min(r); max(r)
breaks = seq(min(r), max(r), by =3)
r_cut <- cut(r, breaks, right = T)
r_feq <- table(r_cut)
cumsum(r_feq)
plot(breaks, c(0,cumsum(r_feq)))
line(breaks, c(0,cumsum(r_feq)))

# charts in R from statmethods.net
attach(mtcars)
plot(wt, mpg) # parameters (x,y)-coord
# add a regression lin
abline(lm(mpg~wt)) # add line to exist graphs, can't work alone
title('Regression of MPG on Weight')

# histogram and density plots
hist(mpg)
#add color and bins
hist(mpg, breaks = 12, col = 'red')
#add a normal curve
x <-mtcars$mpg
h<-hist(x, breaks = 10, col = 'red', xlab = 'Mile Per Gallen',
        main = "Histogram with normal curve")
xfit <-seq(min(x), max(x), length=40)     
yfit<- dnorm(xfit, mean = mean(x), sd=sd(x))
yfit<- yfit*diff(h$mids[1:2]) *length(x)
lines(xfit, yfit, col='blue',lwd=2)
# Simple Dotplot
dotchart(mtcars$mpg,labels=row.names(mtcars),cex=.7,
         main="Gas Milage for Car Models",
         xlab="Miles Per Gallon")
# Dotplot: Grouped Sorted and Colored
# Sort by mpg, group and color by cylinder
x <- mtcars[order(mtcars$mpg),] # sort by mpg
x$cyl <- factor(x$cyl) # it must be a factor
x$color[x$cyl==4] <- "red"
x$color[x$cyl==6] <- "blue"
x$color[x$cyl==8] <- "darkgreen"
dotchart(x$mpg,labels=row.names(x),cex=.7, groups= x$cyl,
         main="Gas Milage for Car Models\ngrouped by cylinder",
         xlab="Miles Per Gallon", gcolor="black", color=x$color) 

# histogram and frequency polygon:  
# The idea is to use the data from histogram to plot ogive curve
s = sample(1:800, 100, replace = T)
h = hist(s, xlim = c(0, max(s)+10), breaks = 12,
         col = "Steelblue3", right = F)
#Now we will create our x,y coordinates from the counts and 
# mids variables.
mp = c(min(h$mids) - (h$mids[2] - h$mids[1]), h$mids, 
       max(h$mids) +  (h$mids[2] - h$mids[1]))
mp

freq = c(0, h$counts, 0)
# now create the histogram and frequency polygon
h = hist(s, xlim = c(0, max(s)+10), breaks = 12,
         col = "Steelblue3", right = F)
lines(mp, freq, type = "b", pch = 20, col = "red", lwd = 3)
# now create the ogive curve
ucl = seq(from = min(h$breaks), to = max(h$breaks), 
          by = h$breaks[2] - h$breaks[1])
ucl = c(min(h$breaks)-5, ucl[-1])
ucl
cf = c(0, cumsum(h$counts))
cf
# Now Plot the Ogive
par(bg = "gray90") # plot next
# type sets different style: 
# "p" for points
# "l" for lines,
# "b" for both,
# "c" for the lines part alone of "b",
# "o" for both ‘overplotted’,
# "h" for ‘histogram’ like (or ‘high-density’) vertical lines,
# "s" for stair steps,
# "S" for other steps, see ‘Details’ below,
# "n" for no plotting.

plot(ucl, cf, type = "b", col = "blue", pch = 20)
