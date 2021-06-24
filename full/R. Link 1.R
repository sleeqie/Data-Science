#https://r4ds.had.co.nz/index.html
library(tidyverse)
library(ggplot2)
ggplot2::mpg
library(magrittr)

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
#coord_flip() switches the x and y axes. This is useful (for example), if you want horizontal boxplots. It’s also useful for long labels: it’s hard to get them to fit without overlapping on the x-axis.
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()







