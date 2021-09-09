#hypothesis testsd
install.packages("yarrr")
library(yarrr) # Load yarrr to get the pirates data
pirates
# Look at the first few rows of the data
head(pirates)
# What are the names of the columns?
names(pirates)
# View the entire dataset in a new window
View(pirates)
# What is the mean age?
mean(pirates$age)
# What was the tallest pirate?
max(pirates$height)
# How many pirates are there of each sex?
table(pirates$sex)

#Now, let’s calculate statistics for different groups of pirates. For example, the following code will use the aggregate() function to calculate the mean age of pirates, separately for each sex.
# Calculate the mean age, separately for each sex
aggregate(formula = age ~ sex,
          data = pirates,
          FUN = mean)

# Create scatterplot
plot(x = pirates$height,        # X coordinates
     y = pirates$weight)        # y-coordinates

# Create scatterplot
plot(x = pirates$height,        # X coordinates
     y = pirates$weight,        # y-coordinates
     main = 'My first scatterplot of pirate data!',
     xlab = 'Height (in cm)',   # x-axis label
     ylab = 'Weight (in kg)',   # y-axis label
     pch = 16,                  # Filled circles
     col = gray(.0, .1))        # Transparent gray

grid()        # Add gridlines

# Create a linear regression model
model <- lm(formula = weight ~ height, 
            data = pirates)

abline(model, col = 'blue')      # Add regression to plot

#OR USE GGPLOT STRAIGHT
library(ggplot2)
ggplot(pirates,aes(height, weight)) + geom_point() + geom_smooth(aes(mapping = 'lm'))

#Scatterplots are great for showing the relationship between two continuous variables, but what if your independent variable is not continuous? In this case, pirateplots are a good option. Let’s create a pirateplot using the pirateplot() function to show the distribution of pirate’s age based on their favorite sword:
pirateplot(formula = age ~ sword.type, 
           data = pirates,
           main = "Pirateplot of ages by favorite sword")
#OR USE GGPLOT
ggplot(pirates, aes(x= sword.type, y=age)) + geom_boxplot()
#Now let’s make another pirateplot showing the relationship between sex and height using a different plotting theme and the "pony" color palette:
pirateplot(formula = height ~ sex,               # Plot weight as a function of sex
           data = pirates,                       
           main = "Pirateplot of height by sex",
           pal = "pony",                         # Use the info color palette
           theme = 3)                            # Use theme 3


#The "pony" palette is contained in the piratepal() function. Let’s see where the "pony" palette comes from…

# Show me the pony palette!
piratepal(palette = "pony",
          plot.result = TRUE,   # Plot the result
          trans = .1)           # Slightly transparent

#hypothesis tests
#Now, let’s do some basic hypothesis tests. First, let’s conduct a two-sample t-test to see if there is a significant difference between the ages of pirates who do wear a headband, and those who do not:
# Age by headband t-test
t.test(formula = age ~ headband,
       data = pirates,
       alternative = 'two.sided')
#With a p-value of 0.7259, we don’t have sufficient evidence say there is a difference in the men age of pirates who wear headbands and those that do not.

#Next, let’s test if there a significant correlation between a pirate’s height and weight using the cor.test() function:

cor.test(formula = ~ height + weight,
         data = pirates)

#We got a p-value of p < 2.2e-16, that’s scientific notation for p < .00000000000000016 – which is pretty much 0. Thus, we’d conclude that there is a significant (positive) relationship between a pirate’s height and weight.

#Now, let’s do an ANOVA testing if there is a difference between the number of tattoos pirates have based on their favorite sword
# Create tattoos model
tat.sword.lm <- lm(formula = tattoos ~ sword.type,
                   data = pirates)

# Get ANOVA table
anova(tat.sword.lm)

#Sure enough, we see another very small p-value of p < 2.2e-16, suggesting that the number of tattoos pirate’s have are different based on their favorite sword.

#Regression analysis
#Finally, let’s run a regression analysis to see if a pirate’s age, weight, and number of tattoos (s)he has predicts how many treasure chests he/she’s found:
# Create a linear regression model: DV = tchests, IV = age, weight, tattoos
tchests.model <- lm(formula = tchests ~ age + weight + tattoos,
                    data = pirates)

# Show summary statistics
summary(tchests.model)

#It looks like the only significant predictor of the number of treasure chests that a pirate has found is his/her age. There does not seem to be significant effect of weight or tattoos.
  
#Bayesian Statistics
#Now, let’s repeat some of our previous analyses with Bayesian versions. First we’ll install and load the package which contains the Bayesian statistics functions we’ll use:
  
  # Install and load the BayesFactor package
  install.packages('BayesFactor')
library(BayesFactor)
#Now that the packages is installed and loaded, we’re good to go! Let’s do a Bayesian version of our earlier t-test asking if pirates who wear a headband are older or younger than those who do not.
  
# Bayesian t-test comparing the age of pirates with and without headbands
  ttestBF(formula = age ~ headband,
          data = pirates)
  
#It looks like we got a Bayes factor of 0.12 which is strong evidence for the null hypothesis (that the mean age does not differ between pirates with and without headbands)



#HYPOTHESIS TESTS
  #In this chapter we’ll cover 1 and 2 sample null hypothesis tests: like the t-test, correlation test, and chi-square test:
    
    library(yarrr) # Load yarrr to get the pirates data
  
  # 1 sample t-test
  # Are pirate ages different than 30 on average?
  t.test(x = pirates$age, 
         mu = 30) 
  
  # 2 sample t-test
  # Do females and males have different numbers oftattoos?
  sex.ttest <- t.test(formula = tattoos ~ sex,
                      data = pirates, 
                      subset = sex %in% c("male", "female"))
  sex.ttest # Print result
  
  ## Access specific values from test
  sex.ttest$statistic
  sex.ttest$p.value
  sex.ttest$conf.int
  
  # Correlation test
  # Is there a relationship between age and height?
  cor.test(formula = ~ age + height,
           data = pirates)
  
  # Chi-Square test
  # Is there a relationship between college and favorite pirate?
  chisq.test(x = pirates$college,
             y = pirates$favorite.pirate)
  
  #Do we get more treasure from chests buried in sand or at the bottom of the ocean? Is there a relationship between the number of scars a pirate has and how much grogg he can drink? Are pirates with body piercings more likely to wear bandannas than those without body piercings? Glad you asked, in this chapter, we’ll answer these questions using 1 and 2 sample frequentist hypothesis tests.
  #As this is a Pirate’s Guide to R, and not a Pirate’s Guide to Statistics, we won’t cover all the theoretical background behind frequentist null hypothesis tests (like t-tests) in much detail. However, it’s important to cover three main concepts: Descriptive statistics, Test statistics, and p-values. To do this, let’s talk about body piercings.
  
  
  #A short introduction to hypothesis tests
  #As you may know, pirates are quite fond of body piercings. Both as a fashion statement, and as a handy place to hang their laundry. Now, there is a stereotype that European pirates have more body piercings than American pirates. But is this true? To answer this, I conducted a survey where I asked 10 American and 10 European pirates how many body piercings they had. The results are below, and a Pirateplot of the data is in Figure :
    
  # Body piercing data
  american.bp <- c(3, 5, 2, 1, 4, 4, 6, 3, 5, 4)
  european.bp <- c(6, 5, 7, 7, 6, 3, 4, 6, 5, 4)
  
  # Store data in a dataframe
  bp.survey <- data.frame("bp" = c(american.bp, european.bp),
                          "group" = rep(c("American", "European"), each = 10),
                          stringsAsFactors = FALSE)
  yarrr::pirateplot(bp ~ group,
                    data = bp.survey,
                    main = "Body Piercing Survey",
                    ylab = "Number of Body Piercings",
                    xlab = "Group", 
                    theme = 2, point.o = .8, cap.beans = TRUE)  
  #Null v Alternative Hypothesis
  #In null hypothesis tests, you always start with a null hypothesis. The specific null hypothesis you choose will depend on the type of question you are asking, but in general, the null hypothesis states that nothing is going on and everything is the same. For example, in our body piercing study, our null hypothesis is that American and European pirates have the same number of body piercings on average.
  
  #The alternative hypothesis is the opposite of the null hypothesis. In this case, our alternative hypothesis is that American and European pirates do not have the same number of piercings on average. We can have different types of alternative hypotheses depending on how specific we want to be about our prediction. We can make a 1-sided (also called 1-tailed) hypothesis, by predicting the direction of the difference between American and European pirates. For example, our alternative hypothesis could be that European pirates have more piercings on average than American pirates.
  
 # Alternatively, we could make a 2-sided (also called 2-tailed) alternative hypothesis that American and European pirates simply differ in their average number of piercings, without stating which group has more piercings than the other.
  
  # Once we’ve stated our null and alternative hypotheses, we collect data and then calculate descriptive statistics.
  
  #Descriptive statistics
 # Descriptive statistics (also called sample statistics) describe samples of data. For example, a mean, median, or standard deviation of a dataset is a descriptive statistic of that dataset. Let’s calculate some descriptive statistics on our body piercing survey American and European pirates using the summary() function:
    
    
  # Pring descriptive statistics of the piercing data
  summary(american.bp)
  ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  ##     1.0     3.0     4.0     3.7     4.8     6.0
  summary(european.bp)
  ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  ##     3.0     4.2     5.5     5.3     6.0     7.0
  
  
  #Test Statistics
#A test statistic compares descriptive statistics, and determines how different they are. The formula you use to calculate a test statistics depends the type of test you are conducting, which depends on many factors, from the scale of the data (i.e.; is it nominal or interval?), to how it was collected (i.e.; was the data collected from the same person over time or were they all different people?), to how its distributed (i.e.; is it bell-shaped or highly skewed?).
# Conduct a two-sided t-test comparing the vectors american.bp and european.bp
  #  and save the results in an object called bp.test
  bp.test <- t.test(x = american.bp,
                    y = european.bp,
                    alternative = "two.sided")

  # Print the main results
  bp.test
#It looks like our test-statistic is -2.52. If there was really no difference between the groups of pirates, we would expect a test statistic close to 0. Because test-statistic is -2.52, this makes us think that there really is a difference. However, in order to make our decision, we need to get the p-value from the test.
  
#Hypothesis test objects: htest
 # R stores hypothesis tests in special object classes called htest. htest objects contain all the major results from a hypothesis test, from the test statistic (e.g.; a t-statistic for a t-test, or a correlation coefficient for a correlation test), to the p-value, to a confidence interval. To show you how this works, let’s create an htest object called height.htest containing the results from a two-sample t-test comparing the heights of male and female pirates:  
  # T-test comparing male and female heights
  #  stored in a new htest object called height.htest
  height.htest<- t.test(formula = height ~ sex,
                         data = pirates,
                         subset = sex %in% c("male", "female"))
height.htest

# Show me all the elements in the height.htest object
names(height.htest)
## [1] "statistic"   "parameter"   "p.value"     "conf.int"    "estimate"   
## [6] "null.value"  "alternative" "method"      "data.name"

#Now, if we want to access the test statistic or p-value directly, we can just use $:
  
  # Get the test statistic
  height.htest$statistic
##   t 
## -21

# Get the p-value
height.htest$p.value
## [1] 1.4e-78

# Get a confidence interval for the mean
height.htest$conf.int















