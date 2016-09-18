## Predictive learning
## https://dzone.com/refcardz/machine-learning-predictive
# datasets : iris, prestige

data(iris)
# set up training and test data
testidx <- sample(1:nrow(iris), nrow(iris)*0.4)
iristrain <- iris[-testidx,]
iristest <- iris[testidx,]

library(car); data(Prestige)
testidx <- sample(1:nrow(Prestige), nrow(Prestige)*0.3)
prestige_train <- Prestige[-testidx,]
prestige_test <- Prestige[testidx,]

#linear regression
model <- lm(prestige~., data=prestige_train)
# Use the model to predict the output of test data
prediction <- predict(model, newdata=prestige_test)
# Check for the correlation with actual result
cor(prediction, prestige_test$prestige)
plot(prediction, prestige_test$prestige)


#logstic regression
newcol = data.frame(isSetosa=(iristrain$Species == 'setosa'))
traindata <- cbind(iristrain, newcol)
head(traindata)
formula <- isSetosa ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
logisticModel <- glm(formula, data=traindata, family="binomial")
summary(logisticModel)
prob <- predict(logisticModel, newdata=iristest, type='response')
round(prob, 2) 
# prediect result
idx <- which(prob>0.7); idx
iristest$Species[idx] # overfitting

# k-nn 
# step: know your data
summary(iris)

plot(Sepal.Length ~ Petal.Length,
     xlab = "Petal Length (cm)",
     ylab = "Sepal Length (cm)",
     pch = c(16, 17, 18)[as.numeric(Species)],  # different 'pch' types 
     main = "Iris Dataset",
     col = c("red", "green","blue")[as.numeric(Species)],
     data = iris)

pairs(iris[,-5])

inames <- names(iris)
i <- 1; j<- 3
        plot(iris[,i], iris[,j],
     xlab = inames[i],
     ylab = inames[j],
     pch = c(16, 17, 18)[as.numeric(iris$Species)],  # different 'pch' types 
     main = "Iris Dataset",
     col = c("red", "green","blue")[as.numeric(iris$Species)])
        
# prepare data
normalize <- function(x) { return ((x - min(x))/(max(x) - min(x)))}
iris.n <- as.data.frame(lapply(iris[,-5],  normalize))
summary(iris.n)

# seperate train and test
set.seed(1234)
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33)) 

iris.training <- iris[ind==1, 1:4] 
iris.test <- iris[ind==2, 1:4] 
iris.trainLabels <- iris[ind==1, 5] 
iris.testLabels <- iris[ind==2, 5] 
library(class)
iris_pred <- knn(train = iris.training, test = iris.test, 
                 cl = iris.trainLabels, k=5,prob=TRUE)
iris_pred
# note there is a difference for k = 3 and 5
table(iris_pred, iris.testLabels)

