#decision trees
iris
str (iris)
#Classification task
#70-30 rule for testing and training respectively
set.seed(1234)
ind <- sample (2, nrow(iris), replace = TRUE, prob= c(0.7,0.3))
ind
#now we use 70% for training
traindata <- iris [ind == 1,]
#30% for testing
testdata <- iris [ind ==2,]
library(party)
?ctree
myFormula <-  Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
iris_ctree <- ctree(myFormula, data = traindata)
#check the prediction table
table (predict(iris_ctree), traindata$Species)

iris_ctree
plot(iris_ctree)

#convert to a simpler plot
plot(iris_ctree, type = 'simple')

test_pred <- predict(iris_ctree, newdata = testdata)
table(test_pred, testdata$Species)

#




