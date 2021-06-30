#https://r4ds.had.co.nz/index.html
library(tidyverse)
library(ggplot2)
ggplot2::mpg
library(magrittr)

#EXPLORE

#Among the variables in mpg are:
#displ, a car’s engine size, in litres.
#hwy, a car’s fuel efficiency on the highway, in miles per gallon (mpg). 
#A car with a low fuel efficiency consumes more fuel than a car with a 
#high fuel efficiency 
#when they travel the same distance.
mpg%>% ggplot(aes(x = displ, y = hwy)) + geom_point() #PIPELINE CODE
#OR
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) #NORMAL CODE
#The plot shows a negative relationship between engine size (displ) and 
#fuel efficiency (hwy). In other words, cars with big engines use more fuel. 
#Does this confirm or refute your hypothesis about fuel efficiency and engine size?

#Let’s turn this code into a reusable template for making graphs with ggplot2. To make a graph, replace the bracketed sections in the code below with a dataset, a geom function, or a collection of mappings.
#ggplot(data = <DATA>) + 
 # <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))


mpg%>% ggplot(aes(x = displ, y = hwy, color= class)) + geom_point() #PIPELINE CODE

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) #for color #NORMAL CODE

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class)) #size

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class)) #alpha

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue") #manual color picking

#problematic codes and why
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue")) #theres two brackets instead of 1, its not blue

ggplot(data = mpg) 
+ geom_point(mapping = aes(x = displ, y = hwy)) #putting the + sign at the beginning of a line instead of the end


#FACETS
#To facet your plot by a single variable, use facet_wrap(). 
#The first argument of facet_wrap() should be a formula, which you create with ~ followed by a variable name (here “formula” is the name of a data structure in R, 
#not a synonym for “equation”). The variable that you pass to facet_wrap() should be discrete.

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) + 
  facet_wrap(~ class, nrow = 2)

#To facet your plot on the combination of two variables, add facet_grid() to your plot call. 
#The first argument of facet_grid() is also a formula. This time the formula should contain two variable names separated by a ~.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

#If you prefer to not facet in the rows or columns dimension, use a . instead of a variable name, e.g. + facet_grid(. ~ cyl).

#GEOM POINTS
# left
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# right
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

#line type setting
#Here geom_smooth() separates the cars into three lines based on their drv value, which describes a car’s drivetrain. One line describes all of the points with a 4 value, one line describes all of the points with an f value, and one line describes all of the points with an r value. Here, 4 stands for four-wheel drive, f for front-wheel drive, and r for rear-wheel drive.
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color= drv))

#
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )

#To display multiple geoms in the same plot, add multiple geom functions to ggplot():
mpg%>% ggplot(aes(x = displ, y = hwy)) + geom_point() + geom_smooth() #PC
              
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy)) #NC

#to make it easier
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

#you can add aes for each geom personally
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()

#You can use the same idea to specify different data for each layer. Here, our smooth line displays just a subset of the mpg dataset, the subcompact cars. The local data argument in geom_smooth() overrides the global data argument in ggplot() for that layer only.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

#Statistical transformations
diamonds%>% ggplot(aes(x= cut)) + geom_bar()

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

#The algorithm used to calculate new values for a graph is called a stat, short for statistical transformation. The figure below describes how this process works with geom_bar().
#You can generally use geoms and stats interchangeably. For example, you can recreate the previous plot using stat_count() instead of geom_bar():
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))

#There are three reasons you might need to use a stat explicitly:

# 1. You might want to override the default stat. In the code below, I change the stat of geom_bar() from count (the default) to identity. This lets me map the height of the bars to the raw values of a 
#y variable. Unfortunately when people talk about bar charts casually, they might be referring to this type of bar chart, where the height of the bar is already present in the data, or the previous bar chart where the height of the bar is generated by counting rows.

demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

# 2. You might want to override the default mapping from transformed variables to aesthetics. For example, you might want to display a bar chart of proportion, rather than count:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))

# 3. You might want to draw greater attention to the statistical transformation in your code. For example, you might use stat_summary(), which summarises the y values for each unique x value, to draw attention to the summary that you’re computing:
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )
#position adjustments
#There’s one more piece of magic associated with bar charts. You can colour a bar chart using either the colour aesthetic, or, more usefully, fill:

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))
#Note what happens if you map the fill aesthetic to another variable, like clarity: the bars are automatically stacked. Each colored rectangle represents a combination of cut and clarity.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))
#The stacking is performed automatically by the position adjustment specified by the position argument. If you don’t want a stacked bar chart, you can use one of three other options: "identity", "dodge" or "fill".

# 1. position = "identity" will place each object exactly where it falls in the context of the graph. This is not very useful for bars, because it overlaps them. To see that overlapping we either need to make the bars slightly transparent by setting alpha to a small value, or completely transparent by setting fill = NA.
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")

# 2. position = "fill" works like stacking, but makes each set of stacked bars the same height. This makes it easier to compare proportions across groups.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

#3. position = "dodge" places overlapping objects directly beside one another. This makes it easier to compare individual values.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

#The values of hwy and displ are rounded so the points appear on a grid and many points overlap each other. This problem is known as overplotting. This arrangement makes it hard to see where the mass of the data is. Are the data points spread equally throughout the graph, or is there one special combination of hwy and displ that contains 109 values?
#You can avoid this gridding by setting the position adjustment to “jitter”. position = "jitter" adds a small amount of random noise to each point. This spreads the points out because no two points are likely to receive the same amount of random noise.

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
#add jitter
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

#Coordinate systems
# 1. coord_flip() switches the x and y axes. This is useful (for example), if you want horizontal boxplots. It’s also useful for long labels: it’s hard to get them to fit without overlapping on the x-axis.
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()
# 2. coord_quickmap() sets the aspect ratio correctly for maps. This is very important if you’re plotting spatial data with ggplot2 (which unfortunately we don’t have the space to cover in this book).
nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

#3. coord_polar() uses polar coordinates. Polar coordinates reveal an interesting connection between a bar chart and a Coxcomb chart.
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + geom_abline() + coord_fixed()
  
#general format
#ggplot(data = <DATA>) + 
#  <GEOM_FUNCTION>(
#    mapping = aes(<MAPPINGS>),
 #   stat = <STAT>, 
  #  position = <POSITION>
 # ) +
 # <COORDINATE_FUNCTION> +
  #<FACET_FUNCTION>

#WORKFLOW BASICS
#callling functions
function_name(arg1 = val1, arg2 = val2, ...)
seq(1, 10)
#>  [1]  1  2  3  4  5  6  7  8  9 10

x <- "hello world"

y <- seq(1, 10, length.out = 5)
y
#> [1]  1.00  3.25  5.50  7.75 10.00

(y <- seq(1, 10, length.out = 5))
#> [1]  1.00  3.25  5.50  7.75 10.00

library(tidyverse)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
filter(mpg, cyl = 8)
filter(diamond, carat > 3)

#Data transformation
library(tidyverse)
library(dplyr)
library(nycflights13)
nycflights13::flights
view(flights)
flights
#Filter rows with filter()
#filter() allows you to subset observations based on their values. The first argument is the name of the data frame. The second and subsequent arguments are the expressions that filter the data frame. For example, we can select all flights on January 1st with:
filter(flights, month == 1, day == 1)

(jan1 <- filter(flights, month == 1, day == 1))


(dec25 <- filter(flights, month == 12, day == 25))

#its better to use near to than == for mathematical approximations
filter(flights, month == 1)
sqrt(2) ^ 2 == 2
#> [1] FALSE
1 / 49 * 49 == 1
#> [1] FALSE

near(sqrt(2) ^ 2,  2)
#> [1] TRUE
near(1 / 49 * 49, 1)


#The following code finds all flights that departed in November or December:
filter(flights, month == 11 | month == 12)
#A useful short-hand for this problem is x %in% y. This will select every row where x is one of the values in y. We could use it to rewrite the code above:
nov_dec <- filter(flights, month %in% c(11, 12))
#Sometimes you can simplify complicated subsetting by remembering De Morgan’s law: !(x & y) is the same as !x | !y, and !(x | y) is the same as !x & !y. For example, if you wanted to find flights that weren’t delayed (on arrival or departure) by more than two hours, you could use either of the following two filters:
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)
#If you want to determine if a value is missing, use is.na():
is.na(x)

#filter() only includes rows where the condition is TRUE; it excludes both FALSE and NA values. If you want to preserve missing values, ask for them explicitly:
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)

filter(df, is.na(x) | x > 1)

#Arrange rows with arrange()
#arrange() works similarly to filter() except that instead of selecting rows, it changes their order. It takes a data frame and a set of column names (or more complicated expressions) to order by. If you provide more than one column name, each additional column will be used to break ties in the values of preceding columns:
arrange(flights, year, month, day)
        
#descending order
arrange(flights, desc(dep_delay))
#missing values
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))

#Select columns with select()
#it’s not uncommon to get datasets with hundreds or even thousands of variables. In this case, the first challenge is often narrowing in on the variables you’re actually interested in. select() allows you to rapidly zoom in on a useful subset using operations based on the names of the variables.
#select() is not terribly useful with the flights data because we only have 19 variables, but you can still get the general idea:

select(flights, year, month, day)
# Select all columns between year and day (inclusive)
select(flights, year:day)
# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))
#There are a number of helper functions you can use within select():
#starts_with("abc"): matches names that begin with “abc”.
#ends_with("xyz"): matches names that end with “xyz”.
#contains("ijk"): matches names that contain “ijk”.
#matches("(.)\\1"): selects variables that match a regular expression. This one matches any variables that contain repeated characters. You’ll learn more about regular expressions in strings.
#num_range("x", 1:3): matches x1, x2 and x3.

#select() can be used to rename variables, but it’s rarely useful because it drops all of the variables not explicitly mentioned. Instead, use rename(), which is a variant of select() that keeps all the variables that aren’t explicitly mentioned:
rename(flights, tail_num = tailnum)
#Another option is to use select() in conjunction with the everything() helper. This is useful if you have a handful of variables you’d like to move to the start of the data frame.
select(flights, time_hour, air_time, everything())



#Add new variables with mutate()
#Besides selecting sets of existing columns, it’s often useful to add new columns that are functions of existing columns. That’s the job of mutate().
#mutate() always adds new columns at the end of your dataset so we’ll start by creating a narrower dataset so we can see the new variables. Remember that when you’re in RStudio, the easiest way to see all the columns is View().

(flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
))

mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60)

#Note that you can refer to columns that you’ve just created:
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours)
#If you only want to keep the new variables, use transmute():
transmute(flights_sml,
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)
#Modular arithmetic: %/% (integer division) and %% (remainder), where x == y * (x %/% y) + (x %% y). Modular arithmetic is a handy tool because it allows you to break integers up into pieces. For example, in the flights dataset, you can compute hour and minute from dep_time with:
transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100
)
#Logs: log(), log2(), log10(). Logarithms are an incredibly useful transformation for dealing with data that ranges across multiple orders of magnitude. They also convert multiplicative relationships to additive, a feature we’ll come back to in modelling.

#All else being equal, I recommend using log2() because it’s easy to interpret: a difference of 1 on the log scale corresponds to doubling on the original scale and a difference of -1 corresponds to halving.

#Offsets: lead() and lag() allow you to refer to leading or lagging values. This allows you to compute running differences (e.g. x - lag(x)) or find when values change (x != lag(x)). They are most useful in conjunction with group_by(), which you’ll learn about shortly.

(x <- 1:10)
lag(x)
lead(x)
#Cumulative and rolling aggregates: R provides functions for running sums, products, mins and maxes: cumsum(), cumprod(), cummin(), cummax(); and dplyr provides cummean() for cumulative means. If you need rolling aggregates (i.e. a sum computed over a rolling window), try the RcppRoll package.
x
cumsum(x)
cummean(x)

#Ranking: there are a number of ranking functions, but you should start with min_rank(). It does the most usual type of ranking (e.g. 1st, 2nd, 2nd, 4th). The default gives smallest values the small ranks; use desc(x) to give the largest values the smallest ranks.
y <- c(1, 2, 2, NA, 3, 4)
min_rank(y)
min_rank(desc(y))

#Grouped summaries with summarise()
#The last key verb is summarise(). It collapses a data frame to a single row:
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

#summarise() is not terribly useful unless we pair it with group_by(). This changes the unit of analysis from the complete dataset to individual groups. Then, when you use the dplyr verbs on a grouped data frame they’ll be automatically applied “by group”. For example, if we applied exactly the same code to a data frame grouped by date, we get the average delay per date:
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

#Imagine that we want to explore the relationship between the distance and average delay for each location. Using what you know about dplyr, you might write code like this:
(by_dest <- group_by(flights, dest))
view(by_dest)

delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
)
#> `summarise()` ungrouping output (override with `.groups` argument)
delay <- filter(delay, count > 20, dest != "HNL")

# It looks like delays increase with distance up to ~750 miles 
# and then decrease. Maybe as flights get longer there's more 
# ability to make up delays in the air?
ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)
#> `geom_smooth()` using method = 'loess' and formula 'y ~ x'
#There are three steps to prepare this data:
#Group flights by destination.
#Summarise to compute distance, average delay, and number of flights.
#Filter to remove noisy points and Honolulu airport, which is almost twice as far away as the next closest airport.

#There’s another way to tackle the same problem with the pipe, %>%:
delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")
#> `summarise()` ungrouping output (override with `.groups` argument)

#You may have wondered about the na.rm argument we used above. What happens if we don’t set it?
flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay, na.rm = TRUE))
#In this case, where missing values represent cancelled flights, we could also tackle the problem by first removing the cancelled flights. We’ll save this dataset so we can reuse it in the next few examples.
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))
#Counts
#Whenever you do any aggregation, it’s always a good idea to include either a count (n()), or a count of non-missing values (sum(!is.na(x))). That way you can check that you’re not drawing conclusions based on very small amounts of data. For example, let’s look at the planes (identified by their tail number) that have the highest average delays:
delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay)
  )
#> `summarise()` ungrouping output (override with `.groups` argument)

ggplot(data = delays, mapping = aes(x = delay)) + 
  geom_freqpoly(binwidth = 10)

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )
#> `summarise()` ungrouping output (override with `.groups` argument)

ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

#When looking at this sort of plot, it’s often useful to filter out the groups with the smallest numbers of observations, so you can see more of the pattern and less of the extreme variation in the smallest groups. This is what the following code does, as well as showing you a handy pattern for integrating ggplot2 into dplyr flows. It’s a bit painful that you have to switch from %>% to +, but once you get the hang of it, it’s quite convenient.

delays %>% 
  filter(n > 25) %>% 
  ggplot(mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

# Convert to a tibble so it prints nicely
install.packages("Lahman")
batting <- as_tibble(Lahman::Batting)

batters <- batting %>% 
  group_by(playerID) %>% 
  summarise(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )
#> `summarise()` ungrouping output (override with `.groups` argument)


batters %>% 
  filter(ab > 100) %>% 
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point() + 
  geom_smooth(se = FALSE)
#> `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

#Useful summary functions
#Just using means, counts, and sum can get you a long way, but R provides many other useful summary functions:
#1. Measures of location: we’ve used mean(x), but median(x) is also useful. The mean is the sum divided by the length; the median is a value where 50% of x is above it, and 50% is below it.
#It’s sometimes useful to combine aggregation with logical subsetting. We haven’t talked about this sort of subsetting yet, but you’ll learn more about it in subsetting.
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0]) # the average positive delay
  )

#2. Measures of spread: sd(x), IQR(x), mad(x). The root mean squared deviation, or standard deviation sd(x), is the standard measure of spread. The interquartile range IQR(x) and median absolute deviation mad(x) are robust equivalents that may be more useful if you have outliers.

# Why is distance to some destinations more variable than to othe
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))

#3. Measures of rank: min(x), quantile(x, 0.25), max(x). Quantiles are a generalisation of the median. For example, quantile(x, 0.25) will find a value of x that is greater than 25% of the values, and less than the remaining 75%.
# When do the first and last flights leave each day?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )

#Measures of position: first(x), nth(x, 2), last(x). These work similarly to x[1], x[2], and x[length(x)] but let you set a default value if that position does not exist (i.e. you’re trying to get the 3rd element from a group that only has two elements). For example, we can find the first and last departure for each day:
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first_dep = first(dep_time), 
    last_dep = last(dep_time)
  )
#These functions are complementary to filtering on ranks. Filtering gives you all variables, with each observation in a separate row:
not_cancelled %>% 
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time))) %>% 
  filter(r %in% range(r))

#Counts: You’ve seen n(), which takes no arguments, and returns the size of the current group. To count the number of non-missing values, use sum(!is.na(x)). To count the number of distinct (unique) values, use n_distinct(x).
# Which destinations have the most carriers?
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(carriers = n_distinct(carrier)) %>% 
  arrange(desc(carriers))

#Counts are so useful that dplyr provides a simple helper if all you want is a count:
  not_cancelled %>% 
  count(dest)


#You can optionally provide a weight variable. For example, you could use this to “count” (sum) the total number of miles a plane flew:
    
    not_cancelled %>% 
    count(tailnum, wt = distance)

#Counts and proportions of logical values: sum(x > 10), mean(y == 0). When used with numeric functions, TRUE is converted to 1 and FALSE to 0. This makes sum() and mean() very useful: sum(x) gives the number of TRUEs in x, and mean(x) gives the proportion.
# How many flights left before 5am? (these usually indicate delayed
# flights from the previous day)
    not_cancelled %>% 
      group_by(year, month, day) %>% 
      summarise(n_early = sum(dep_time < 500))

# What proportion of flights are delayed by more than an hour?
 not_cancelled %>% 
      group_by(year, month, day) %>% 
      summarise(hour_prop = mean(arr_delay > 60))

 #Grouping by multiple variables
# When you group by multiple variables, each summary peels off one level of the grouping. That makes it easy to progressively roll up a dataset:
   
   daily <- group_by(flights, year, month, day)
 (per_day   <- summarise(daily, flights = n()))
   (per_month <- summarise(per_day, flights = sum(flights)))
   (per_year  <- summarise(per_month, flights = sum(flights)))
   
   #ungrouping
  # If you need to remove grouping, and return to operations on ungrouped data, use ungroup().
   
   daily %>% 
     ungroup() %>%             # no longer grouped by date
     summarise(flights = n())  # all flights
   
#Grouped mutates (and filters)
# Grouping is most useful in conjunction with summarise(), but you can also do convenient operations with mutate() and filter():
# Find the worst members of each group:
     
flights_sml %>% 
 group_by(year, month, day) %>%
 filter(rank(desc(arr_delay)) < 10)
   
#Find all groups bigger than a threshold:
  
  popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365)
popular_dests
   
#Standardise to compute per group metrics:
  
  popular_dests %>% 
  filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay)
   
   
   
#Exploratory data analysis
#discrete
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

diamonds %>% 
  count(cut)
#continous
ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)
diamonds %>% 
  count(cut_width(carat, 0.5))
#You can set the width of the intervals in a histogram with the binwidth argument, which is measured in the units of the x variable.

smaller <- diamonds %>% 
  filter(carat < 3)

ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.1)
#If you wish to overlay multiple histograms in the same plot, I recommend using geom_freqpoly() instead of geom_histogram(). geom_freqpoly() performs the same calculation as geom_histogram(), but instead of displaying the counts with bars, uses lines instead. It’s much easier to understand overlapping lines than bars.

ggplot(data = smaller, mapping = aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = 0.1)

#Questions you can ask from your visualizations
Which values are the most common? Why?
  
  Which values are rare? Why? Does that match your expectations?
  
  Can you see any unusual patterns? What might explain them?
  
  As an example, the histogram below suggests several interesting questions:
  
  Why are there more diamonds at whole carats and common fractions of carats?
  
  Why are there more diamonds slightly to the right of each peak than there are slightly to the left of each peak?
  
  Why are there no diamonds bigger than 3 carats?
  
  ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.01)

Clusters of similar values suggest that subgroups exist in your data. To understand the subgroups, ask:
  
  How are the observations within each cluster similar to each other?
  
  How are the observations in separate clusters different from each other?
  
  How can you explain or describe the clusters?
  
  Why might the appearance of clusters be misleading?
  
  #The histogram below shows the length (in minutes) of 272 eruptions of the Old Faithful Geyser in Yellowstone National Park. Eruption times appear to be clustered into two groups: there are short eruptions (of around 2 minutes) and long eruptions (4-5 minutes), but little in between.
  ggplot(data = faithful, mapping = aes(x = eruptions)) + 
  geom_histogram(binwidth = 0.25)

#outliers
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5)

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))  
#(coord_cartesian() also has an xlim() argument for when you need to zoom into the x-axis. ggplot2 also has xlim() and ylim() functions that work slightly differently: they throw away the data outside the limits.)  


#This allows us to see that there are three unusual values: 0, ~30, and ~60. We pluck them out with dplyr:
unusual <- diamonds %>% 
  filter(y < 3 | y > 20) %>% 
  select(price, x, y, z) %>%
  arrange(y)
unusual


#missing values
diamonds2 <- diamonds %>% 
  filter(between(y, 3, 20))

#use this instead:
diamonds2 <- diamonds %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y))
#ifelse() has three arguments. The first argument test should be a logical vector. The result will contain the value of the second argument, yes, when test is TRUE, and the value of the third argument, no, when it is false. Alternatively to ifelse, use dplyr::case_when(). case_when() is particularly useful inside mutate when you want to create a new variable that relies on a complex combination of existing variables.

ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + 
  geom_point()
#> Warning: Removed 9 rows containing missing values (geom_point).
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + 
  geom_point(na.rm = TRUE)




#Covariation
# 1. A categorical and continuous variable
#boxplot
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot()

#reorder function
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()
#To make the trend easier to see, we can reorder class based on the median value of hwy:
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))
#If you have long variable names, geom_boxplot() will work better if you flip it 90°. You can do that with coord_flip().
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) +
  coord_flip()


#2. Two categorical variables
#To visualise the covariation between categorical variables, you’ll need to count the number of observations for each combination. One way to do that is to rely on the built-in geom_count():
#geom count
ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color))
#The size of each circle in the plot displays how many observations occurred at each combination of values. Covariation will appear as a strong correlation between specific x values and specific y values.

#Another approach is to compute the count with dplyr:
diamonds %>% 
  count(color, cut)
#geom tile
diamonds %>% 
  count(color, cut) %>%  
  ggplot(mapping = aes(x = color, y = cut)) +
  geom_tile(mapping = aes(fill = n))

#3. Two continuous variables

ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price))

ggplot(data = diamonds) + 
  geom_point(mapping = aes(x = carat, y = price), alpha = 1 / 100)
#Apha is for transparency. But using transparency can be challenging for very large datasets. Another solution is to use bin. Previously you used geom_histogram() and geom_freqpoly() to bin in one dimension. Now you’ll learn how to use geom_bin2d() and geom_hex() to bin in two dimensions.

#geom_bin2d() and geom_hex() divide the coordinate plane into 2d bins and then use a fill color to display how many points fall into each bin. geom_bin2d() creates rectangular bins. geom_hex() creates hexagonal bins. You will need to install the hexbin package to use geom_hex().
ggplot(data = smaller) +
  geom_bin2d(mapping = aes(x = carat, y = price))

install.packages("hexbin")
ggplot(data = smaller) +
  geom_hex(mapping = aes(x = carat, y = price))

#Another option is to bin one continuous variable so it acts like a categorical variable. Then you can use one of the techniques for visualising the combination of a categorical and a continuous variable that you learned about. For example, you could bin carat and then for each group, display a boxplot:
ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))
#Another approach is to display approximately the same number of points in each bin. That’s the job of cut_number():
ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_number(carat, 20)))
#Patterns and models
#Patterns in your data provide clues about relationships. If a systematic relationship exists between two variables it will appear as a pattern in the data. If you spot a pattern, ask yourself:
#A scatterplot of Old Faithful eruption lengths versus the wait time between eruptions shows a pattern: longer wait times are associated with longer eruptions. The scatterplot also displays the two clusters that we noticed above.

ggplot(data = faithful) + 
  geom_point(mapping = aes(x = eruptions, y = waiting))

#Models are a tool for extracting patterns out of data. For example, consider the diamonds data. It’s hard to understand the relationship between cut and price, because cut and carat, and carat and price are tightly related. It’s possible to use a model to remove the very strong relationship between price and carat so we can explore the subtleties that remain. The following code fits a model that predicts price from carat and then computes the residuals (the difference between the predicted value and the actual value). The residuals give us a view of the price of the diamond, once the effect of carat has been removed.
library(modelr)

mod <- lm(log(price) ~ log(carat), data = diamonds)

diamonds2 <- diamonds %>% 
  add_residuals(mod) %>% 
  mutate(resid = exp(resid))

ggplot(data = diamonds2) + 
  geom_point(mapping = aes(x = carat, y = resid))

ggplot(data = diamonds2) + 
  geom_boxplot(mapping = aes(x = cut, y = resid))

# ggplot2 calls
ggplot(data = faithful, mapping = aes(x = eruptions)) + 
  geom_freqpoly(binwidth = 0.25)
#becomes:
ggplot(faithful, aes(eruptions)) + 
  geom_freqpoly(binwidth = 0.25)

#Sometimes we’ll turn the end of a pipeline of data transformation into a plot. Watch for the transition from %>% to +. I wish this transition wasn’t necessary but unfortunately ggplot2 was created before the pipe was discovered.
diamonds %>% 
  count(cut, clarity) %>% 
  ggplot(aes(clarity, cut, fill = n)) + 
  geom_tile()

#WRANGLE
#Creating tibbles
#Almost all of the functions that you’ll use in this book produce tibbles, as tibbles are one of the unifying features of the tidyverse. Most other R packages use regular data frames, so you might want to coerce a data frame to a tibble. You can do that with as_tibble():
as_tibble(iris)
#You can create a new tibble from individual vectors with tibble(). tibble() will automatically recycle inputs of length 1, and allows you to refer to variables that you just created, as shown below.
tibble(
  x = 1:5, 
  y = 1, 
  z = x ^ 2 + y
)
data.frame(x <-  1:5, 
           y <-  1, 
           z <- x ^ 2 + y)
#It’s possible for a tibble to have column names that are not valid R variable names, aka non-syntactic names. For example, they might not start with a letter, or they might contain unusual characters like a space. To refer to these variables, you need to surround them with backticks, `:
tb <- tibble(
  `:)` = "smile", 
  ` ` = "space",
  `2000` = "number")
tb
#Another way to create a tibble is with tribble(), short for transposed tibble. tribble() is customised for data entry in code: column headings are defined by formulas (i.e. they start with ~), and entries are separated by commas. This makes it possible to lay out small amounts of data in easy to read form.
tribble(
  ~x, ~y, ~z,
  #--|--|----
  "a", 2, 3.6,
  "b", 1, 8.5
)

#Tibbles have a refined print method that shows only the first 10 rows, and all the columns that fit on screen. This makes it much easier to work with large data. In addition to its name, each column reports its type, a nice feature borrowed from str():
A<- tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)
A
#Tibbles are designed so that you don’t accidentally overwhelm your console when you print large data frames. But sometimes you need more output than the default display. There are a few options that can help.
#First, you can explicitly print() the data frame and control the number of rows (n) and the width of the display. width = Inf will display all columns:
A %>% 
  print(n = 10, width = Inf)
#A final option is to use RStudio’s built-in data viewer to get a scrollable view of the complete dataset. This is also often useful at the end of a long chain of manipulations.
A %>% 
  View()

#subsetting
df <- tibble(
  x = runif(5),
  y = rnorm(5)
)
df
# Extract by name
df$x

df[["x"]]

# Extract by position
df[[1]]

#To use these in a pipe, you’ll need to use the special placeholder .:
df %>% .$x

df %>% .[["x"]]

#Some older functions don’t work with tibbles. If you encounter one of these functions, use as.data.frame() to turn a tibble back to a data.frame:
class(as.data.frame(tb))
#read_csv() reads comma delimited files, read_csv2() reads semicolon separated files (common in countries where , is used as the decimal place), read_tsv() reads tab delimited files, and read_delim() reads in files with any delimiter.
#read_fwf() reads fixed width files. You can specify fields either by their widths with fwf_widths() or their position with fwf_positions(). read_table() reads a common variation of fixed width files where columns are separated by white space.
#read_log() reads Apache style log files. (But also check out webreadr which is built on top of read_log() and provides many more helpful tools.)

read_csv("a,b,c
1,2,3
4,5,6")
#In both cases read_csv() uses the first line of the data for the column names, which is a very common convention. There are two cases where you might want to tweak this behaviour:


read_csv("The first line of metadata
  The second line of metadata
  x,y,z
  1,2,3", skip = 2)

read_csv("# A comment I want to skip
  x,y,z
  1,2,3", comment = "#")
#The data might not have column names. You can use col_names = FALSE to tell read_csv() not to treat the first row as headings, and instead label them sequentially from X1 to Xn:
read_csv("1,2,3\n4,5,6", col_names = FALSE)
#Alternatively you can pass col_names a character vector which will be used as the column names:
read_csv("1,2,3\n4,5,6", col_names = c("x", "y", "z"))

#Another option that commonly needs tweaking is na: this specifies the value (or values) that are used to represent missing values in your file:
read_csv("a,b,c\n1,2,.", na = ".")



#Parsing a vector
#Before we get into the details of how readr reads files from disk, we need to take a little detour to talk about the parse_*() functions. These functions take a character vector and return a more specialised vector like a logical, integer, or date:


str(parse_logical(c("TRUE", "FALSE", "NA")))
#>  logi [1:3] TRUE FALSE NA
str(parse_integer(c("1", "2", "3")))
#>  int [1:3] 1 2 3
str(parse_date(c("2010-01-01", "1979-10-14")))
#>  Date[1:2], format: "2010-01-01" "1979-10-14"

parse_integer(c("1", "231", ".", "456"), na = ".")

#parse_logical() and parse_integer() parse logicals and integers respectively. There’s basically nothing that can go wrong with these parsers so I won’t describe them here further.

#parse_double() is a strict numeric parser, and parse_number() is a flexible numeric parser. These are more complicated than you might expect because different parts of the world write numbers in different ways.

#parse_character() seems so simple that it shouldn’t be necessary. But one complication makes it quite important: character encodings.

#parse_factor() create factors, the data structure that R uses to represent categorical variables with fixed and known values.

#parse_datetime(), parse_date(), and parse_time() allow you to parse various date & time specifications. These are the most complicated because there are so many different ways of writing dates.


parse_double("1.23")
#> [1] 1.23
parse_double("1,23", locale = locale(decimal_mark = ","))
#> [1] 1.23
#parse_number() addresses the second problem: it ignores non-numeric characters before and after the number. This is particularly useful for currencies and percentages, but also works to extract numbers embedded in text.
parse_number("$100")
#> [1] 100
parse_number("20%")
#> [1] 20
parse_number("It cost $123.45")
#> [1] 123.45

#The final problem is addressed by the combination of parse_number() and the locale as parse_number() will ignore the “grouping mark”:
# Used in America
parse_number("$123,456,789")

# Used in many parts of Europe
parse_number("123.456.789", locale = locale(grouping_mark = "."))

# Used in Switzerland
parse_number("123'456'789", locale = locale(grouping_mark = "'"))

#It seems like parse_character() should be really simple — it could just return its input. Unfortunately life isn’t so simple, as there are multiple ways to represent the same string. To understand what’s going on, we need to dive into the details of how computers represent strings. In R, we can get at the underlying representation of a string using charToRaw():
charToRaw("Hadley")  

challenge <- read_csv(readr_example("challenge.csv"))
problems(challenge)
tail(challenge)

challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_double(),
    y = col_logical()
  )
)
challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)
tail(challenge)

#Tidy data
# Compute rate per 10,000
table1 %>% 
  mutate(rate = cases / population * 10000)
# Compute cases per year
table1 %>% 
  count(year, wt= cases)
# Visualise changes over time
library(ggplot2)
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))
#pivoting
#This means for most real analyses, you’ll need to do some tidying. The first step is always to figure out what the variables and observations are. Sometimes this is easy; other times you’ll need to consult with the people who originally generated the data. The second step is to resolve one of two common problems:
#One variable might be spread across multiple columns.
#One observation might be scattered across multiple rows.
#Typically a dataset will only suffer from one of these problems; it’ll only suffer from both if you’re really unlucky! To fix these problems, you’ll need the two most important functions in tidyr: pivot_longer() and pivot_wider().
#To fix these problems, you’ll need the two most important functions in tidyr: pivot_longer() and pivot_wider().

table4a
#pivot longer
table4a %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")

table4b %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "population")

#To combine the tidied versions of table4a and table4b into a single tibble, we need to use dplyr::left_join(), which you’ll learn about in relational data.
tidy4a <- table4a %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")
tidy4b <- table4b %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "population")
left_join(tidy4a, tidy4b)

#Wider
#pivot_wider() is the opposite of pivot_longer(). You use it when an observation is scattered across multiple rows. For example, take table2: an observation is a country in a year, but each observation is spread across two rows.
table2
#To tidy this up, we first analyse the representation in similar way to pivot_longer(). This time, however, we only need two parameters:
#The column to take variable names from. Here, it’s type.
#The column to take values from. Here it’s count.
#Once we’ve figured that out, we can use pivot_wider(), as shown programmatically below, and visually 
table2 %>%
  pivot_wider(names_from = type, values_from = count)

table3
table3 %>% 
  separate(rate, into = c("cases", "population"))












































