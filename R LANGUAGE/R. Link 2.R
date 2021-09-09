#https://bookdown.org/ndphillips/YaRrr/exploring-data.html
?pirates
install.packages('pirates')
#piarte not available so we use iris
iris
head(iris)
tail(iris)
names(iris)
view(iris)
#descriptive statistics
# What is the mean?
mean(iris$Sepal.Length)

# What was the longest value?
min(iris$Petal.Width)

# How many species are there of iris?
table(iris$Species)

#Now, let’s calculate statistics for different groups of iris. For example, the following code will use the aggregate() function to calculate the mean age of pirates, separately for each sex.
SS<- aggregate(formula = Sepal.Length ~ Petal.Width,
          data = iris,
          FUN = mean)

# Create scatterplot
plot(x = iris$Sepal.Length,        # X coordinates
     y = iris$Sepal.Width)        # y-coordinates

# Create scatterplot
pp<- plot(x = iris$Sepal.Length,        # X coordinates
     y = iris$Sepal.Width,        # y-coordinates
     main = 'My first scatterplot of pirate data!',
     xlab = 'Height (in cm)',   # x-axis label
     ylab = 'Weight (in kg)',   # y-axis label
     pch = 16,                  # Filled circles
     col = grey(.0, .1)) +  # Transparent gray
           
# Create a linear regression model
model <- lm(formula = Sepal.Length ~ Sepal.Width, 
            data = iris)
model


abline(model, col = 'blue')      # Add regression to plot

#cont vs discrete
library(ggplot2)
View(mpg)
mm <- ggplot(mpg, aes(class,hwy))
mm + geom_bar(stat = 'identity')

mm <- ggplot(mpg, aes(class,hwy))
mm + geom_boxplot()

mm <- ggplot(iris, aes(Species,Petal.Length))
mm + geom_violin (color= 'red', fill = 'blue')

#Hypothesis tests
#Now, let’s do some basic hypothesis tests. First, let’s conduct a two-sample t-test to see if there is a significant difference between the ages of pirates who do wear a headband, and those who do not:
# Age by headband t-test
# Age by headband t-test
t.test(formula = age ~ headband,
       data = pirates,
       alternative = 'two.sided')
t.test(formula = Sepal.Length ~ Sepal.Width,
       data = iris,
       alternative = 'two.sided')

#With a p-value of 0.7259, we don’t have sufficient evidence say there is a difference in the men age of pirates who wear headbands and those that do not.



#Next, let’s test if there a significant correlation between a pirate’s height and weight using the cor.test() function:
cor.test(formula = ~ height + weight,
         data = pirates)
#We got a p-value of p < 2.2e-16, that’s scientific notation for p < .00000000000000016 – which is pretty much 0. Thus, we’d conclude that there is a significant (positive) relationship between a pirate’s height and weight.


iris
cor.test(formula = ~ Sepal.Length + Sepal.Width,
         data = iris)

#Now, let’s do an ANOVA testing if there is a difference between the number of tattoos pirates have based on their favorite sword
# Create tattoos model
tat.sword.lm <- lm(formula = tattoos ~ sword.type,
                   data = pirates)
# Get ANOVA table
anova(tat.sword.lm)

#for iris
irispp <- lm(formula = Sepal.Length ~ Species,
             data = iris)
anova(irispp)
#Sure enough, we see another very small p-value of p < 2.2e-16, suggesting that the number of tattoos pirate’s have are different based on their favorite sword.

#Regression analysis
#Finally, let’s run a regression analysis to see if a pirate’s age, weight, and number of tattoos (s)he has predicts how many treasure chests he/she’s found:
# Create a linear regression model: DV = tchests, IV = age, weight, tattoos
tchests.model <- lm(formula = tchests ~ age + weight + tattoos,
                    data = pirates)

# Show summary statistics
summary(tchests.model)
#It looks like the only significant predictor of the number of treasure chests that a pirate has found is his/her age. There does not seem to be significant effect of weight or tattoos.

## Install and load the BayesFactor package
install.packages('BayesFactor')
library(BayesFactor)
# Bayesian t-test comparing the age of pirates with and without headbands
ttestBF(formula = age ~ headband,
        data = pirates)
#It looks like we got a Bayes factor of 0.12 which is strong evidence for the null hypothesis (that the mean age does not differ between pirates with and without headbands)

#vector functions

# 10 students from two different classes took two exams.
#  Here are three vectors showing the data
midterm <- c(62, 68, 75, 79, 55, 62, 89, 76, 45, 67)
final <- c(78, 72, 97, 82, 60, 83, 92, 73, 50, 88)

# How many students are there?
length(midterm)
## [1] 10

# Add 5 to each midterm score (extra credit!)
midterm <- midterm + 5
midterm
##  [1] 67 73 80 84 60 67 94 81 50 72

# Difference between final and midterm scores
final - midterm
##  [1] 11 -1 17 -2  0 16 -2 -8  0 16

# Each student's average score
(midterm + final)/2
mean(midterm + final)
##  [1] 72 72 88 83 60 75 93 77 50 80

# Mean midterm grade
mean(midterm)
## [1] 73

# Standard deviation of midterm grades
sd(midterm)
## [1] 13

# Highest final grade
max(final)
## [1] 97

# z-scores
midterm.z <- (midterm - mean(midterm)) / sd(midterm)
final.z <- (final - mean(final)) / sd(final)

#summary statistic
tattoos <- c(4, 50, 2, 39, 4, 20, 4, 8, 10, 100)
min(tattoos)
## [1] 2
mean(tattoos)
## [1] 24
sd(tattoos)
## [1] 31

#length function
a <- 1:10
length(a)  # How many elements are in a?
## [1] 10

b <- seq(from = 1, to = 100, length.out = 20)
length(b)  # How many elements are in b?
## [1] 20

length(c("This", "character", "vector", "has", "six", "elements."))
## [1] 6
length("This character scalar has just one element.")
## [1] 1

#Sample statistics from random samples
#Now that you know how to calculate summary statistics, let’s take a closer look at how R draws random samples using the rnorm() and runif() functions. In the next code chunk, I’ll calculate some summary statistics from a vector of 5 values from a Normal distribution with a mean of 10 and a standard deviation of 5. I’ll then calculate summary statistics from this sample using mean() and sd():

# 5 samples from a Normal dist with mean = 10 and sd = 5
x <- rnorm(n = 5, mean = 10, sd = 5)

# What are the mean and standard deviation of the sample?
mean(x)
## [1] 11
sd(x)
## [1] 2.5

# 100,000 samples from a Normal dist with mean = 10, sd = 5
y <- rnorm(n = 100000, mean = 10, sd = 5)

mean(y)
## [1] 10
sd(y)
## [1] 5

#counting statsistics
vec <- c(1, 1, 1, 5, 1, 1, 10, 10, 10)
gender <- c("M", "M", "F", "F", "F", "M", "F", "M", "F")
#The function unique(x) will tell you all the unique values in the vector, but won’t tell you anything about how often each value occurs.
unique(vec)
## [1]  1  5 10
unique(gender)
## [1] "M" "F"
table(vec)
## vec
##  1  5 10 
##  5  1  3
table(gender)
## gender
## F M 
## 5 4

#If you want to get a table of percentages instead of counts, you can just divide the result of the table() function by the sum of the result:
table(vec) / sum(table(vec))
## vec
##    1    5   10 
## 0.56 0.11 0.33
table(gender) / sum(table(gender))
## gender
##    F    M 
## 0.56 0.44

#missing values
a <- c(1, 5, NA, 2, 10)
mean(a)
## [1] NA
#na.rm explicitly tells it to ignore the missing values
mean(a, na.rm = TRUE)

#Z score
#Standardization (z-score)
#A common task in statistics is to standardize variables – also known as calculating z-scores. The purpose of standardizing a vector is to put it on a common scale which allows you to compare it to other (standardized) variables. To standardize a vector, you simply subtract the vector by its mean, and then divide the result by the vector’s standard deviation.
#If the concept of z-scores is new to you – don’t worry. In the next worked example, you’ll see how it can help you compare two sets of data. But for now, let’s see how easy it is to standardize a vector using basic arithmetic.
#Let’s say you have a vector a containing some data. We’ll assign the vector to a new object called a then calculate the mean and standard deviation with the mean() and sd() functions:

a <- c(5, 3, 7, 5, 5, 3, 4)
mean(a)
## [1] 4.6
sd(a)
## [1] 1.4
#Ok. Now we’ll create a new vector called a.z which is a standardized version of a. To do this, we’ll simply subtract the mean of the vector, then divide by the standard deviation.

a.z <- (a - mean(a)) / sd(a)
a.z
## [1]  0.31 -1.12  1.74  0.31  0.31 -1.12 -0.41

mean(a.z)
## [1] 2e-16
sd(a.z)
## [1] 1

#evaluating competition
grogg <- c(12, 8, 1, 6, 2)
climbing <- c(100, 520, 430, 200, 700)
#Now you’ve got the data, but there’s a problem: the scales of the numbers are very different. While the grogg numbers range from 1 to 12, the climbing numbers have a much larger range from 100 to 700. This makes it difficult to compare the two sets of numbers directly.
#To solve this problem, we’ll use standardization. Let’s create new standardized vectors called grogg.z and climbing.z
grogg.z <- (grogg - mean(grogg)) / sd(grogg)
climbing.z <- (climbing - mean(climbing)) / sd(climbing)
#It looks like there were two outstanding performances in particular. In the grogg drinking competition, the first pirate (Heidi) had a z-score of 1.4. We can interpret this by saying that Heidi drank 1.4 more standard deviations of mugs of grogg than the average pirate. In the climbing competition, the fifth pirate (David) had a z-score of 1.3. Here, we would conclude that David climbed 1.3 standard deviations more than the average pirate.

#But which pirate was the best on average across both events? To answer this, let’s create a combined z-score for each pirate which calculates the average z-scores for each pirate across the two events. We’ll do this by adding two performances and dividing by two. This will tell us, how good, on average, each pirate did relative to her fellow pirates.
average.z <- (grogg.z + (climbing.z)) / 2
round(average.z, 1)
#The highest average z-score belongs to the second pirate (Andrew) who had an average z-score value of 0.5. The first and last pirates, who did well in one event, seemed to have done poorly in the other event.

#Moral of the story: promote the pirate who can drink and climb.

#indexing vectors
#Indexing Vectors with [ ]

# Boat sale. Creating the data vectors
boat.names <- c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j")
boat.colors <- c("black", "green", "pink", "blue", "blue", 
                 "green", "green", "yellow", "black", "black")
boat.ages <- c(143, 53, 356, 23, 647, 24, 532, 43, 66, 86)
boat.prices <- c(53, 87, 54, 66, 264, 32, 532, 58, 99, 132)
boat.costs <- c(52, 80, 20, 100, 189, 12, 520, 68, 80, 100)

# What was the price of the first boat?
boat.prices[1]
## [1] 53

# What were the ages of the first 5 boats?
boat.ages[1:5]
## [1] 143  53 356  23 647

# What were the names of the black boats?
boat.names[boat.colors == "black"]
## [1] "a" "i" "j"

# What were the prices of either green or yellow boats?
boat.prices[boat.colors == "green" | boat.colors == "yellow"]
## [1]  87  32 532  58

# Change the price of boat "s" to 100
boat.prices[boat.names == "s"] <- 100

# What was the median price of black boats less than 100 years old?
median(boat.prices[boat.colors == "black" & boat.ages < 100])
## [1] 116

# How many pink boats were there?
sum(boat.colors == "pink")
## [1] 1

# What percent of boats were older than 100 years old?
mean(boat.ages < 100)
## [1] 0.6

#Numerical Indexing
#With numerical indexing, you enter a vector of integers corresponding to the values in the vector you want to access in the form a[index], where a is the vector, and index is a vector of index values. For example, let’s use numerical indexing to get values from our boat vectors.

# What is the first boat name?
boat.names[1]
## [1] "a"

# What are the first five boat colors?
boat.colors[1:5]
## [1] "black" "green" "pink"  "blue"  "blue"

# What is every second boat age?
boat.ages
boat.ages[seq(1, 5, by = 2)]
## [1] 143 356 647

#You can use any indexing vector as long as it contains integers. You can even access the same elements multiple times:

# What is the first boat age (3 times)
boat.ages[c(1, 1, 1)]

## [1] 143 143 143
#If it makes your code clearer, you can define an indexing object before doing your actual indexing. For example, let’s define an object called my.index and use this object to index our data vector:
  
my.index <- 1:4
boat.names[my.index]
boat.ages[my.index]
## [1] "c" "d" "e"


#logical vectors
2>3
3<2
3>2
3*2==5

# Which ages are > 100?
boat.ages > 100
##  [1]  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE

# Which ages are equal to 23?
boat.ages == 23
##  [1] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE

# Which boat names are equal to c?
boat.names == "c"
##  [1] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE

# Which boats had a higher price than cost?
boat.prices > boat.costs
##  [1]  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE

# Which boats had a lower price than cost?
boat.prices < boat.costs
##  [1] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE



# What were the prices of boats older than 100?
boat.prices[boat.ages > 100]
## [1]  53  54 264 532

#In addition to using single comparison operators, you can combine multiple logical vectors using the OR (which looks like | and AND & commands. The OR | operation will return TRUE if any of the logical vectors is TRUE, while the AND & operation will only return TRUE if all of the values in the logical vectors is TRUE. This is especially powerful when you want to create a logical vector based on criteria from multiple vectors.
#For example, let’s create a logical vector indicating which boats had a price greater than 200 OR less than 100, and then use that vector to see what the names of these boats were:
# Which boats had prices greater than 200 OR less than 100?
boat.prices > 200 | boat.prices < 100
##  [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE

# What were the NAMES of these boats
boat.names[boat.prices > 200 | boat.prices < 100]
## [1] "a" "b" "c" "d" "e" "f" "g" "h" "i"

#You can combine as many logical vectors as you want (as long as they all have the same length!):
  
  # Boat names of boats with a color of black OR with a price > 100
boat.names[boat.colors == "black" | boat.prices > 100]
## [1] "a" "e" "g" "i" "j"
# Names of blue boats with a price greater than 200
boat.names[boat.colors == "blue" & boat.prices > 200]

#You can combine as many logical vectors as you want to create increasingly complex selection criteria. For example, the following logical vector returns TRUE for cases where the boat colors are black OR brown, AND where the price was less than 100:

# Which boats were either black or brown, AND had a price less than 100?
(boat.colors == "black" | boat.colors == "brown") & boat.prices < 100
##  [1]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE

# What were the names of these boats?
boat.names[(boat.colors == "black" | boat.colors == "brown") & boat.prices < 100]
## [1] "a" "i"



# Counts and percentages from logical vectors

x <- c(1, 2, 3, -5, -5, -5, -5, -5)
x > 0
#data frame
bsale <- data.frame(name = c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j"),
                    color = c("black", "green", "pink", "blue", "blue", 
                              "green", "green", "yellow", "black", "black"),
                    age = c(143, 53, 356, 23, 647, 24, 532, 43, 66, 86),
                    price = c(53, 87, 54, 66, 264, 32, 532, 58, 99, 132),
                    cost = c(52, 80, 20, 100, 189, 12, 520, 68, 80, 100),
                    stringsAsFactors = FALSE)   # Don't convert strings to factors!

# Explore the bsale dataset:
head(bsale)     # Show me the first few rows
str(bsale)      # Show me the structure of the data
View(bsale)     # Open the data in a new window
names(bsale)    # What are the names of the columns?
nrow(bsale)     # How many rows are there in the data?

# Calculating statistics from column vectors
mean(bsale$age)       # What was the mean age?
table(bsale$color)    # How many boats were there of each color?
max(bsale$price)      # What was the maximum price?

# Adding new columns
bsale$id <- 1:nrow(bsale)
bsale$age.decades <- bsale$age / 10
bsale$profit <- bsale$price - bsale$cost

# What was the mean price of green boats?
with(bsale, mean(price[color == "green"]))

# What were the names of boats older than 100 years?
with(bsale, name[age > 100])

# What percent of black boats had a positive profit?
with(subset(bsale, color == "black"), mean(profit > 0))

# Save only the price and cost columns in a new dataframe
bsale.2 <- bsale[c("price", "cost")]

# Change the names of the columns to "p" and "c"
names(bsale.2) <- c("p", "c")

# Create a dataframe called old.black.bsale containing only data from black boats older than 50 years
old.black.bsale <- subset(bsale, color == "black" & age > 50)

#MARIX

# Create a matrix of the integers 1:10,
#  with 5 rows and 2 columns

matrix(data = 1:10,
       nrow = 5,
       ncol = 2)
##      [,1] [,2]
## [1,]    1    6
## [2,]    2    7
## [3,]    3    8
## [4,]    4    9
## [5,]    5   10

# Now with 2 rows and 5 columns
matrix(data = 1:10,
       nrow = 2,
       ncol = 5)
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    3    5    7    9
## [2,]    2    4    6    8   10

# Now with 2 rows and 5 columns, but fill by row instead of columns
matrix(data = 1:10,
       nrow = 2,
       ncol = 5,
       byrow = TRUE)
#Advanced dataframe manipulation

# Exam data
(exam <- data.frame(
  id = 1:5,
  q1 = c(1, 5, 2, 3, 2),
  q2 = c(8, 10, 9, 8, 7),
  q3 = c(3, 7, 4, 6, 4)))

# Demographic data
(demographics <- data.frame(
  id = 1:5,
  sex = c("f", "m", "f", "f", "m"),
  age = c(25, 22, 24, 19, 23)))

# Combine exam and demographics
(combined <- merge(x = exam, 
                  y = demographics, 
                  by = "id"))

# Mean q1 score for each sex
aggregate(formula = q1 ~ sex, 
          data = combined, 
          FUN = mean)
##   sex  q1
## 1   f 2.0
## 2   m 3.5

# Median q3 score for each sex, but only for those
#   older than 20
aggregate(formula = q3 ~ sex, 
          data = combined,
          subset = age > 20,
          FUN = mean)
##   sex  q3
## 1   f 3.5
## 2   m 5.5

# Many summary statistics by sex using dplyr!
library(dplyr)
combined %>% group_by(sex) %>%
  summarise(
    q1.mean = mean(q1),
    q2.mean = mean(q2),
    q3.mean = mean(q3),
    age.mean = mean(age),
    N = n())
## # A tibble: 2 x 6
##      sex q1.mean q2.mean q3.mean age.mean     N
##   <fctr>   <dbl>   <dbl>   <dbl>    <dbl> <int>
## 1      f     2.0     8.3     4.3       23     3
## 2      m     3.5     8.5     5.5       22     2

#sorting data
exam
# Sort the pirates dataframe by height
pirates <- pirates[order(pirates$height),]

# Look at the first few rows and columns of the result
pirates[1:5, 1:4]
##      id    sex age height
## 39   39 female  25    130
## 854 854 female  25    130
## 30   30 female  26    135
## 223 223 female  28    135
## 351 351 female  36    137
# Sort the pirates dataframe by height in decreasing order
pirates <- pirates[order(pirates$height, decreasing = TRUE),]

# Look at the first few rows and columns of the result
pirates[1:5, 1:4]
##      id  sex age height
## 2     2 male  31    209
## 793 793 male  25    209
## 430 430 male  26    201
## 292 292 male  29    201
## 895 895 male  27    201

# Sort the pirates dataframe by sex and then height
pirates <- pirates[order(pirates$sex, pirates$height),]
#By default, the order() function will sort values in ascending (increasing) order. If you want to order the values in descending (decreasing) order, just add the argument decreasing = TRUE to the order() function:
  
  # Sort the pirates dataframe by height in decreasing order
  pirates <- pirates[order(pirates$height, decreasing = TRUE),]
  
#Merge
#Results from a risk survey
risk.survey <- data.frame(
    "participant" = c(1, 2, 3, 4, 5),
    "risk.score" = c(3, 4, 5, 3, 1))
  
happiness.survey <- data.frame(
  "participant" = c(4, 2, 5, 1, 3),
  "happiness.score" = c(20, 40, 50, 90, 53))
# Combine the risk and happiness surveys by matching participant.id
combined.survey <- merge(x = risk.survey,
                         y = happiness.survey,
                         by = "participant",
                         all = TRUE)

# Print the result
combined.survey  

#Aggregate
#formula A formula in the form y ~ x1 + x2 + ... where y is the dependent variable, and x1, x2… are the independent variables. For example, salary ~ sex + age will aggregate a salary column at every unique combination of sex and age
  
# General structure of aggregate()
aggregate(formula = dv ~ iv, # dv is the data, iv is the group 
          FUN = fun, # The function you want to apply
          data = df) # The dataframe object containing dv and iv
#dplyr
#the package that uses pipes

# Template for using dplyr
my.df %>%                  # Specify original dataframe
  filter(iv3 > 30) %>%     # Filter condition
  group_by(iv1, iv2) %>%   # Grouping variable(s)
  summarise(
    a = mean(col.a),       # calculate mean of column col.a in my.df
    b = sd(col.b),         # calculate sd of column col.b in my.df
    c = max(col.c))        # calculate max on column col.c in my.df, ...

#When you use dplyr, you write code that sounds like: “The original dataframe is XXX, now filter the dataframe to only include rows that satisfy the conditions YYY, now group the data at each level of the variable(s) ZZZ, now summarize the data and calculate summary functions XXX…”

pirates.agg <- pirates %>%                   # Start with the pirates dataframe
  filter(headband == "yes") %>% # Only pirates that wear hb
  group_by(sex, college) %>%    # Group by these variables
  summarise( 
    age.mean = mean(age),      # Define first summary...
    tat.med = median(tattoos), # you get the idea...
    n = n()                    # How many are in each group?
  ) # End



movies
movies %>% # From the movies dataframe...
  filter(genre != "Horror" & time > 50) %>% # Select only these rows
  group_by(rating, sequel) %>% # Group by rating and sequel
  summarise( #
    frequency = n(), # How many movies in each group?
    budget.mean = mean(budget, na.rm = T),  # Mean budget?
    revenue.mean = mean(revenue.all), # Mean revenue?
    billion.p = mean(revenue.all > 1000)) # Percent of movies with revenue > 1000?






  
  
  
  
