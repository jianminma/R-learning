# cluster analysis

data(attitude)
str(attitude)
help(attitude)
summary(attitude)

# perform CA on two variables, maybe PCA late
dat <-attitude[,c(3,4)]
plot(dat, main="% of favorable responses to Learning and Privilege",
     pch =20, cex =2)
pairs(attitude)

# perform k-means with 2 clusters
set.seed(7)
km1 <- kmeans(dat, 2, nstart = 100)
summary(km1)
plot(dat, col=km1$cluster, main='k means with 2 clusters',pch=20, cex=3)

# find how many clusters
mydata <-dat
wss <- (nrow(mydata)-1)*sum(apply(mydata, 2, FUN=var))
for (i in 2:15) wss[i]<-sum(kmeans(mydata, centers = i)$withinss)
plot(1:15, wss, type = 'b',xlab="# of clusters",
     ylab="within group ss", main ='assesssing opt # of clusters',
     pch=20, cex=2)
# 6 clusters
set.seed(7)
km2 <-kmeans(dat, 6, nstart = 50); km2
plot(dat, col=1+km2$cluster, main='k means with 6 clusters',pch=20, cex=3)

# perform CA with more variables
km3 <-kmeans(attitude, 5, nstart=100)
km3 # bt_SS/tot_SS = 64.5%

data<-attitude
data.ms <- colMeans(data); data.ms
data.var <-apply(data, 2, var); data.var
data.sc <- scale(data, center =T)
# data.sc$scaled:{center, scale}: meaans, sd
km4 <-kmeans(data.sc, 5, nstart=100); km4
# rescale becomes less efficient

dm <- dist(as.matrix(data.sc)); dm
hc <-hclust(dm)
plot(hc)
groups <- cutree(hc, 5)
rect.hclust(hc, 5, border = 'red');

# read community data from data directory
place <- read.csv("places.txt", head=T , sep='')
place.scale <-scale(place[,-1], center = T)

place.pca <-princomp(place[,-1], cor = T, scores =T); 

print(place.pca)
plot(place.pca, type="l") # elbow graph
summary(place.pca)

place.km <- kmeans(place.scale, 5, nstart = 100); 
