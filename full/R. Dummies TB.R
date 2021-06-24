#Performing multiple calculations with vectors
x <- 1:5
x
x+2
x+6:10
print("hello world!")
#Doing simple math
1+2+3+4+5
#To construct a vector
c(1,2,3,4,5)
#One very handy operator is called sequence, 
#and it looks like a colon (:).
1:5
#calculate the sum
sum(1:5)
#storing and calculating stored values
x <- 1:5
x
y <- 10
y
x + y
z<- x + y
z
h<- "hello"
h
print(h)
hw<- c ("hello", "world")
hw
#You can use the paste() 
#function to concatenate multiple text elements. 
paste("hello", "world")
#To ask the user questions, 
#you can use the readline() function.
h <- "Hello"
yourname <- readline ("What is your name?") 
#What is your name?Andrie
paste (h, yourname)

#sourcing a script
#function to run an entire script is source()
#when you source a script, output is printed only if you have an explicit print() function.

h <- "hello"
h
yourname <- readline("what is your name?")
yourname
print(paste(h, yourname))

# the ls() function to list the objects in the workspace.
ls()
#help function
?paste
#to removevariable from the workspace
rm(y)

#thats all for chapter 1-2
#After six games, you want to know how many baskets Granny has made so far this season. 
#You can put these numbers in a vector, like this:
baskets.of.Granny <- c (12,4,4,6,9,3)
baskets.of.Granny
sum(baskets.of.Granny)
#A less obvious example of a vectorized function is the paste() function. 
#If you make a vector with the first names of the members of your family, 
#paste() can add the last name to all of them with one command, as in the following example:
firstnames <- c ("toheeb", "nike", "kunle", "banke", "taofeeq", "damola")
lastname <- "yusuf"
paste(firstnames, lastname)
paste(lastname, firstnames)
#You also can give R two longer vectors, 
#and R will combine them element by element, like this:
Lovers <- c("Kelly", "Wilson", "Dami")
Surnames <- c("ereretevwe", "dammmy", "waters")
paste(Lovers, Surnames)

#Putting the argument in a function
#Arguments without default values:
print()
#Arguments with default values:
#You can specify an argument like this:
print( x= "isn't this fun?")

print(digits=6, x = 11/7)
#to get more help info:
?print()

#Making history
#Saving the history is done using the savehistory() function. 
#By default, R saves the history in a file called .Rhistory in your current working directory. 
#If you want to load a history file you saved earlier, you can use the loadhistory() function. 
#This will replace the history with the one saved in the .Rhistory file in the current working directory.

#Structuring a code
baskets.of.Geraldine <- c(5,3,2,2,12,9)
Intro <- "It is amazing! The All Star Grannies scored a total of"
Outro <- "baskets in the last six games"
Total.baskets <- baskets.of.Granny + baskets.of.Geraldine
Total.baskets
Text <- paste(Intro,
              sum(Total.baskets), Outro)
cat(Text)
#cat()removed the quote from text.
#It prints whatever you give it as an argument directly to the console. 
#It also interprets special characters like line breaks and tabs. 

#more examples of cat() function
cat ("If you doubt whether it works, just try it out.")

#Adding comments
# The All Star Grannies do it again! 
baskets.of.Granny <- c(12,4,4,6,9,3) 
# Granny rules 
sum(baskets.of.Granny) 
# total number of points

#Finding packages
#Several websites, called repositories, offer a collection of R packages. 
#The most important repository is the Comprehensive R Archive Network 
#(CRAN; http://cran.r-project.org), which you can access easily from within R.

#Installing packages
#You install a package in R with the function — wait for it — install.packages(). 
install.packages ("fortunes")

#Loading and unloading packages
#So, before you can use a package, 
#you have to load it into R by using the library() function.
#You load the fortunes package like this:

library(fortunes)
fortune("This is R")

fortune(161)

#You can use the fortune() function without arguments to 
#get a random selection of the fortunes available in the package. 
#It’s a nice read.

#To unload a package, use the detach() function
detach(package:fortunes)

#chapter 4
#R as a fancy calculator can be used for the following:
#Basic arithmetic operators, Mathematical functions, Vector operations, 
# and Matrix operations.

#Basic arithmetic operators:
2 + 3
2 ^ 5
7 %% 3
7 %/% 3 #x divided by y but rounded down (integer divide)

#examples on how to use minimized code on vectors
baskets.of.Granny <- c(12,4,4,6,9,3)
baskets.of.Geraldine <- c(5,3,2,2,12,9)
#Granny requested $120 per basket, and Geraldine asked for $145 per basket. 
#How do you calculate the total donations that they collected for each game?
Granny.Money <- baskets.of.Granny * 120
Geraldine.Money <- baskets.of.Geraldine * 145
Granny.Money
Geraldine.Money

#It can also be in one line like this:
baskets.of.Granny * 120 + baskets.of.Geraldine * 145

#To get the total money these ladies earned in each game, you simply do this:
Total.Money <- Granny.Money + Geraldine.Money
Total.Money
sum(Total.Money)
#Controlling the order of the operations
#1. Exponentiation
#2. Multiplication and division in the order in which the operators are presented
#3. Addition and subtraction in the order in which the operators are presented
#Everything that’s put between parentheses is carried out first.

#Using mathematical functions:

#abs(x) -Takes the absolute value of x
#log(x,base=y) -Takes the logarithm of x with base y; if base is not specified, returns the natural logarithm
#exp(x) -Returns the exponential of x
#sqrt(x)- Returns the square root of x
#factorial(x)- Returns the factorial of x (x!)
#choose(x,y) -Returns the number of possible combinations when drawing y elements at a time from x possibilities

abs(9)
log(10, base= 2)
exp(2)
sqrt(2)
factorial(2)
choose(10,2)

#Calculating logarithms and exponentials
log(1:3)
log(1:3, base = 6)

#For the logarithms with bases 2 and 10, 
#you can use the convenience functions log2() and log10().

#You carry out the inverse operation of log() by using exp(). 
#This last function raises e to the power mentioned between brackets, like this:

p <- log(1:3)
p
exp(p)

#scientific notations
1.33e4
4.12e-2
1.2e6 / 2e3

#Rounding numbers 
#To round a number to two digits after the decimal point, 
#for example, use the round() function as follows:
round(123.567, digits = 2)

#To multiples of 100,10 etc
#You also can use the round() function to round numbers to multiples of 10, 
#100, and so on. For that, you just add a negative number as the digits argument:
round(123.567, digits = -2)

#If you want to specify the number of significant digits to be retained, 
#regardless of the size of the number, you use the signif() function instead:
signif(123.456, digits = 4)

#Both round() and signif() round numbers to the nearest possibility. 
#So, if the first digit that’s dropped is smaller than 5, the number is rounded down. 
#If it’s bigger than 5, the number is rounded up.
#If the first digit that is dropped is exactly 5, 
#R uses a rule that’s common in programming languages: 
#Always round to the nearest even number. round(1.5) and round(2.5) both return 2, 
#for example, and round (-4.5) returns -4.

#floor(x) rounds to the nearest integer that’s smaller than x.
floor(123.45)
floor(-123.45)
#ceiling(x) rounds to the nearest integer that’s larger than x.
ceiling(123.45)
ceiling(-123.45)
#trunc(x) rounds to the nearest integer in the direction of 0.
trunc(123.45)
trunc(-123.45)

#Trigonometric functions
cos(120) #This is wrong because R calculates in radians not degrees.
#The correct form of calculation is:
#The correct way to calculate the cosine of an angle of 120 degrees, then, is this:
cos(120*pi/180)

#t helps to know, though, that operators can, in many cases, 
#be treated just like any other function if you put the operator between 
#backticks and add the arguments between parentheses, like this:

'+' (2,3)
#Using infinity
2/0
4- Inf
#To check whether a value is finite or infinite, use the functions 
is.finite(2)
is.infinite(2)

#R considers everything larger than the largest number a computer can hold
#to be infinity — on most machines, that’s approximately 1.8 × 10*308. 
#This definition of infinity can lead to unexpected results, as shown in the following example:
is.finite(10^(305:310))
is.infinite(10^(305:310))

#Dealing with undefined outcomes
#You can test whether a calculation results in NaN by using the is.nan() function.
Inf / Inf
is.nan(2)

#Dealing with missing values
#To deal with missing values, R uses the reserved keyword NA, which stands for Not Available.

#If you want to test whether a value is NA, you can use the is.na() function, as follows:
is.na(3)

#Note that the is.na() function also returns TRUE if the value is NaN. 
#The functions is.finite(), is.infinite(), and is.nan() return FALSE for NA values.

#Organizing data in vectors
str(baskets.of.Granny)
#to check the length
length(baskets.of.Granny)


#testing vectors
is.numeric(baskets.of.Granny)
is.integer(baskets.of.Granny)

#Creating vectors
#To make bigger or smaller steps in a sequence, 
#use the seq() function. This function’s by argument allows 
#you to specify the amount by which the numbers should increase or decrease.
seq (from = 4.5, to = 2.5, by = -0.5)

#Alternatively, you can specify the length of the sequence by using the 
#argument length.out. 

seq(from = -2.7, to = 1.3, length.out = 9)

#Repeating vectors
#If you want to repeat the complete vector, for example, you specify the argument times. 
#To repeat the vector c(0, 0, 7) three times, use this code:

rep(c(0, 0, 7), times = 3)
#You also can repeat every value by specifying the argument each, like this:
rep(c(0,2,7), each = 3)

#You can tell R for each value how often it has to be repeated. 
#To take advantage of that magic, tell R how often to repeat each 
#value in a vector by using the times argument:

rep(c(0, 7), times = c(4,2))

#And you can, like in seq, use the argument length.out to tell R how long you want it to be.
rep(1:3,length.out=7)


#Understanding indexing in R
numbers <- 30:1
numbers
#Extracting values from a vector
numbers [4]
numbers [c(4, 5, 6)]
#OR 
Indices<-c(4, 5, 6)
Indices
numbers [Indices]
#to drop values
numbers[-3]
numbers[(1:20)]
#expel the first 20 numbers
numbers[-(1:20)]

baskets.of.Granny <- c(12, 4, 8, 6, 9, 3)
baskets.of.Granny
baskets.of.Granny[3] <- 5
baskets.of.Granny

#Working with logical vectors
10==10
10!=10
10>9
10>=9
10<9
10<=9
10&9
!10
baskets.of.Granny < 5
baskets.of.Granny > 5
#For that purpose, R offers the delightful which() function. 
#To find out which games Granny scored more than five baskets in, you can use the following code:
which (baskets.of.Granny > 5)

baskets.of.Geraldine <- c(19, 24, 28, 0, 99, 8)
baskets.of.Geraldine
the.best <- baskets.of.Geraldine > baskets.of.Granny
the.best
which(the.best)
baskets.of.Granny[the.best]

#If you want to keep only the values larger than 2 in the vector x, 
#you could do that with the following code:
x <- c(3, 6, 1, NA, 2)
x[x > 2]

#Combining logical operators
#Create two logical vectors, as follows:
min.baskets <- baskets.of.Granny == min (baskets.of.Granny)
min.baskets
max.baskets <- baskets.of.Granny == max(baskets.of.Granny)
max.baskets

#Combine both vectors with the OR operator (|), as follows:
min.baskets | max.baskets

#The NOT operator (!) is another example of the great power of vectorization.
x[!is.na(x)]


#You can use the numerical translation of a logical vector for that purpose in the sum() function, as follows:
sum(the.best) #So, five times, Gearldine was better than granny. 
#figure out whether any value in a logical vector is TRUE.
#the function that performs that task is called any(). 
#To ask R whether Granny was better than Geraldine in any game, use this code:
any(the.best)

#To find out whether Granny was always better than Geraldine, use the following code:
all(the.best)

#Arithmetic vector operations
sum(1, 2, 3)
#Calculates the sum of all values in x
prod(1, 2, 3)
#Calculates the product of all values in x
min(1, 2, 3)
#Gives the minimum of all values in x
max(1, 2, 3)
#Gives the maximum of all values in x
cumsum (1)
#Gives the cumulative sum of all values in x
cumprod(1)
#Gives the cumulative product of all values in x
cummin(1)
#Gives the minimum for all values in x from the start of the vector until the position of that value
cummax(1)
#Gives the maximum for all values in x from the start of the vector until the position of that v alue
diff(1, 2, 3)
#Gives for every value the difference between that value and the next value in the vector

#Summarizing a vector
min(baskets.of.Granny)
max(baskets.of.Granny)
sum(baskets.of.Geraldine, baskets.of.Granny)

#discard the missing values by setting the argument na.rm to TRUE. 
x <- c(3, 6, 1, NA, 2)
x[x > 2]
sum(x)
sum(x, na.rm = TRUE)

#Cumulating operations
#After the second game, that’s the total of the first two games; 
#after the third game, it’s the total of the first three games; and so on. You can make this calculation easily by using the cumulative sum function, cumsum(), as in the following example:

cumsum(baskets.of.Granny)
cummax(baskets.of.Granny)
cumprod(baskets.of.Granny)
cummax(baskets.of.Geraldine)

#Calculating differences
#You can calculate the difference in the number of baskets between every two games Granny played by using the following code:
diff(baskets.of.Geraldine)
diff(baskets.of.Granny)

#Recycling arguments
#Suppose you split up the number of baskets Granny made into 
#two-pointers and three-pointers:
Granny.pointers <- c(10,2,4,0,4,1,4,2,7,2,1,2)
#You arrange the numbers in such a way that for every game, first the number of two-pointers is given, followed by the number of three-pointers.
#Now Granny wants to know how many points she’s actually scored this season. You can calculate that easily with the help of recycling:

points <- Granny.pointers * c(2,3)
points
sum(points)
#Now Granny wants to know how much she improved every game. 
#Being lazy, you have a cunning plan. With diff(), 
#you calculate how many more or fewer baskets Granny made than she made in the game before. 
#Then you use the vectorized division to divide these differences by the number of baskets in the game. 
#To top it off, you multiply by 100 and round the whole vector. All these calculations take one line of code:
round(diff(baskets.of.Granny) / baskets.of.Granny[1:5] * 100)

#SECTION 1
#TO INSTALL A PACKAGE
install.packages("car")  # install car package 
library(car)  # initialize the pkg 'car'
require(car)  # another way to initialize
library()  # see list of all installed packages
library(help=car)  # see info about 'car' pkg

#TO IMPORT AND EXPORT DATA
myData <- read.csv("c:/myInputData.csv", header=FALSE)  # import csv file
write.csv(rDataFrame, "c:/output.csv")  # export 

#REMOVE AND DELETE
a <- 10
b <- 20
ls()  # list objects in global env
rm(a)  # delete the object 'a'
rm(list = ls())  # caution: delete all objects in .GlobalEnv
gc()  # free system memory

#SECTION 2
#VECTORS
vec1 <- c(10, 20, 15, 40)  # numeric vector
vec2 <- c("a", "b", "c", NA)  # character vector
vec3 <- c(TRUE, FALSE, TRUE, TRUE)  # logical vector
vec4 <- gl(4, 1, 4, label = c("l1", "l2", "l3", "l4"))  # factor with 4 levels

#indexing vectors
length(vec1)  # 4
print(vec1[1])  # 10
print(vec1[1:3])  # 10, 20, 15

#Here is how to initialize a numeric vector:
numericVector <- numeric(100) # length 100 elements

#Manipulate vectors
#Subsetting
logic1 <- vec1 < 15  # create a logical vector, TRUE if value < 15
vec1[logic1]  # elements in TRUE positions will be included in subset
vec1[1:2]  # returns elements in 1 & 2 positions.
vec1[c(1,3)]  # returns elements in 1 & 3 positions
vec1[-1]  # returns all elements except in position 1.
#sorting 
sort(vec1)  # ascending sort
sort(vec1, decreasing = TRUE)  # Descending sort 
#Sorting can also be achieved using the order() function which returns the indices of elements in ascending order.
vec1[order(vec1)]  # ascending sort
vec1[rev(order(vec1))]  # descending sort
#Creating vector sequences and repetitions
#The seq() and rep() functions are used to create custom vector sequences. The rep() function can be used to repeat alphabets also.
seq(1, 10, by = 2)  # diff between adj elements is 2
seq(1, 10, length=25)  # length of the vector is 25
rep(1, 5)  # repeat 1, five times.
rep(1:3, 5)  # repeat 1:3, 5 times
rep(1:3, each=5)  # repeat 1 to 3, each 5 times.
#Remove missing values
#Missing values can be handles using the is.na() function which returns a logical vector with TRUE in positions where there is a missing value(NA)
vec2 <- c("a", "b", "c", NA)  # character vector
is.na(vec2)  # missing TRUE
!is.na(vec2)  # missing FALSE
vec2[!is.na(vec2)]  # return non missing values from vec2
#Sampling
set.seed(100)  # optional. set it to get same random samples.
sample(vec1)  # sample all elements randomly
sample(vec1, 3)  # sample 3 elem without replacement
sample(vec1, 10, replace=T)  # sample with replacement

#SECTION 3
#Dataframes
#Creating Data frame and accessing rows and columns
myDf1 <- data.frame(vec1, vec2)  # make data frame with 2 columns
myDf2 <- data.frame(vec1, vec3, vec4)
myDf3 <- data.frame(vec1, vec2, vec3)
myDf1
myDf2
myDf3
#Built-in Datasets and Basic Operations
library(datasets) # initialize
library(help=datasets) # display the datasets

#Using the airquality dataframe to show all the above discussed
class(airquality)  # get class
sapply(airquality, class)  # get class of all columns
str(airquality)  # structure
summary(airquality)  # summary of airquality
head(airquality)  # view the first 6 obs
fix(airquality)  # view spreadsheet like grid
rownames(airquality)  # row names
colnames(airquality)  # columns names
nrow(airquality)  # number of rows
ncol(airquality)  # number of columns
#Append data frames with cbind and rbind
#Lets append dataframes column wise cbind and row wise rbind.
cbind (myDf1, myDf2)  # columns append DFs with same no. rows
rbind(myDf1, myDf1)  # row append DFs with same no. columns

#Subset Data frame with number indices, subset() and which() methods
myDf1$vec1  # vec1 column
myDf1[, 1]  # df[row.num, col.num]
myDf1[, c(1,2)]  # columns 1 and 3
myDf1[c(1:5), c(2)]  # first 5 rows in column 2
#OR
#Subsetting rows and columns can also be done using subset() and with which() functions. 
subset(airquality, Day == 1, select = -Temp)  # select Day=1 and exclude 'Temp'
airquality[which(airquality$Day==1), -c(4)]  # same as above

print(airquality)
airquality[1,] #first columm of air quality
airquality[1]#first row of air quality
airquality[,1]

print(myDf1)
myDf1[1,] #first olumn of mydf1
myDf1[1] #first row of mydf1
myDf1[,1] #

#Sampling
#Sampling your data into training(data on which models are built) and test(known data on which models are tested) is a common activity.
set.seed(100)
trainIndex <- sample(c(1:nrow(airquality)), size=nrow(airquality)*0.7, replace=F)  # get test sample indices
airquality[trainIndex, ]  # training data
airquality[-trainIndex, ]  # test data

#merging dataframes
merge(myDf1, myDf2, by="vec1")  # merge by 'vec1'
merge(myDf1, myDf2)  # merge by 'vec1'
set.seed(100)
df1 = data.frame(StudentId = c(1:10), Subject = sample(c("Math", "Science", "Arts"), 10, replace=T))
df2 = data.frame(StudentNum = c(2, 4, 6, 12), Sport = sample(c("Football", "Tennis", "Chess"), 4, replace=T))
df1
df2
myd
#SECTION 4
#Paste function
paste("a", "b")  # "a b"
paste0("a", "b")  # concatenate without space, "ab"
paste("a", "b", sep="")  # same as paste0
paste(c(1:4), c(5:8), sep="")  # "15" "26" "37" "48"
paste(c(1:4), c(5:8), sep="", collapse="")  # "15263748"
paste0(c("var"), c(1:5))  # "var1" "var2" "var3" "var4" "var5"
paste0(c("var", "pred"), c(1:3))  # "var1" "pred2" "var3"
paste0(c("var", "pred"), rep(1:3, each=2))  # "var1" "pred1" "var2" "pred2" "var3" "pred3"

#Dealing with dates
dateString <- "15/06/2014"
myDate <- as.Date(dateString, format="%d/%m/%Y")
class(myDate)  # "Date"

#view contents
attributes(dateString)  # best
unclass(dateString)  # works!
names(dateString)  # doesn't work on a  object
unlist(dateString)  # works!
object.size(myDate)  

#contingency table
#Contingency tables gets you a count summary of a vector or 2 dimensional data. Let see how to get the count table for a vector.
table(df1)
table(airquality$Month[c(1:60)], airquality$Temp[c(1:60)]) # first 60/code>
table(df1[1,])
table(df1$StudentId)

#lists
myList <- list(vec1, vec2, vec3, vec4)
myList
#lists can have different levels within
myList[3] # level 1
myList[[3]]  # level 2: access the vec3 directly
myList[[3]][3]  # 3rd elem of vec3
lapply(myList, length)  # length of each element as a list
#Unlisting
unlist()  # flattens out into a one-level list.
unlist(myList)  # flattens out

#The apply family
#apply(): Apply FUN through a data frame or matrix by rows or columns.
myData <- matrix(seq(1,16), 4, 4)  # make a matrix
myData
apply(myData, 1, FUN=min) # apply 'min' by rows
#=> [1] 1 2 3 4

apply(myData, 2, FUN=min)  # apply 'min' by columns
#=> [1] 4 8 12 16

apply (data.frame(1:5), 1, FUN=function(x) {x^2})  # square of 1,2,3,4,5
#=> [1] 1 4 9 16 25

#lapply(): Apply FUN to each element in a list(or) to columns of a data frame and return the result as a list
lapply(myData, class)  # return classes of each column in 'mydata' in a list

#sapply(): Apply FUN to each element of a list(or) to columns of a data frame and return the result as a vector.
sapply(myData, class)

#vapply(): Similar to sapply() but faster. You need to supply an additional FUN.VALUE argument that is a sample value of the returned output. A sample value could be character(0) for a string, numeric(0) or 0L for a number, logical(0) for a boolean.. and so on.
x <- list(a = 1, b = 1:3, c = 10:100)  # make a list
x
vapply(x, FUN = length, FUN.VALUE = 2L)  # FUN.VALUE defines a sample format of output

#Error Handling
options(show.error.messages = F)
1 <- 1
options(show.error.messages = T)
1 <- 1
#To handle the error
for(i in c(1:10)) {
  1 <- 1 # trigger the error
}
print(i) # i equals 1. Never ran through full loop

#Without the error handling feature, the loop is broken as soon as an error is encountered and the rest of the iterations are abruptly stopped. However, there are scenarios where you will want the loop to continue even if an error is encountered. This can be easily done by passing the error-prone function into a try() function. In this case, the loop continues to iterate even after it encounters an error.
for(i in c(1:10)) {
  triedOut <- try(1 <- 1) # try an error prone statement.
}
print(i) # i equals 10. Runs through full loop
#to check if an error occurred
class(triedOut) # "try-error

try(p<- 2)
triedin<-try(p<- 2)
class(triedin)

#Error handling with tryCatch()
tryCatch({1 <- 1; print("Lets create an error")}, # First block
         error=function(err){print(err); print("Error Line")},  # Second Block(optional)
         finally = {print("finally print this")})# Third Block(optional)
#=> [1] "Lets create an error"
#=> <simpleError in 1 <- 1: invalid(do_set) left-hand side to assignment>
#=> [1] "Error Line"
#=> [1] "finally print this"



































































































