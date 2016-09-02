
djx = read.csv("DJX83015-16.csv", sep=",", header = TRUE)
spx = read.csv("SPX83015-16.csv", sep=",", header=T)
nsq = read.csv("NSQ83015-16.csv", sep=",", header=T)
fast = read.csv("FAST83015-16.csv", sep=",", header=T)
csco = read.csv("CSCO83015-16.csv", sep=",", header=T)

# fast does not have  cor with nasdaq < spx < djx
for (x in list(djx, spx, nsq)) print(cor(x$Close, fast$Close ))

#csco have col with spx > djx > nasdaq
for (x in list(djx, spx, nsq)) print(cor(x$Close, csco$Close ))

csco.djx = lm(csco$Close~djx$Close)
summary(csco.djx)
csco.spx = lm(csco$Close~spx$Close)
summary(csco.spx)


