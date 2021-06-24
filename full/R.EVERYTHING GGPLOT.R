#How to make any plot in ggplot2?
#ggplot2 is the most elegant and aesthetically pleasing graphics framework available in R. 
#It has a nicely planned structure to it. This tutorial focusses on exposing this underlying structure you can use to make any ggplot. 
#But, the way you make plots in ggplot2 is very different from base graphics making the learning curve steep. 
#So leave what you know about base graphics behind and follow along. 

#To read data from folder in csv format
flowers <- read.csv("plot.csv")
flowers
head(flowers)
summary(flowers)

#Installing package
library('ggplot2')
#Scattered Plots
library('readr')

ggplot(data=flowers,aes(x=SepalWidthCm, y=SepalLengthCm)) + geom_point() + theme_minimal()
ggplot(data=flowers,aes(x=SepalWidthCm, y=SepalLengthCm,color=Species)) + geom_point() + theme_minimal()


#Creating histograms
hist(flowers$SepalWidthCm, freq=NULL, density=NULL, breaks=12, xlab="Sepal Width", ylab="Frequency", main="Histogram of Sepal Width")

#Adding ggplot2 aesthetics into an histogram
histogram_gg_flowers <- ggplot(data=flowers, aes(x=SepalWidthCm))
histogram_gg_flowers + geom_histogram(binwidth=0.2, color="black", aes(fill=Species)) + xlab("Sepal Width") + ylab("Frequency") + ggtitle("Histogram of Sepal Width")

library(ggplot2)
#Density Plots
ggplot(iris) +
  geom_density(aes(x = Petal.Width, fill = Species), alpha=0.25)

#assignment usage and everything on ggplots and use it to demonstrate the data.

library(ggplot2)
#Density Plots
ggplot(flowers) +
  geom_density(aes(x = Petal.Width, fill = Species), alpha=0.25)



#Understanding the Ggplot Syntax
#A step by step process of building up a ggplot
# Setup
options(scipen=999)  # turn off scientific notation like 1e+06
library(ggplot2)
data("midwest", package = "ggplot2")  # load the data
# midwest <- read.csv("http://goo.gl/G1K41K") # alt source 
# Init Ggplot
ggplot(midwest, aes(x=area, y=poptotal))  # area and poptotal are columns in 'midwest'

#How to Make a Simple Scatterplot
#Let’s make a scatterplot on top of the blank ggplot by adding points using a geom layer called geom_point.
library(ggplot2)
ggplot(midwest, aes(x=area, y=poptotal)) + geom_point()

#For now, let’s just add a smoothing layer using geom_smooth(method='lm'). Since the method is set as lm (short for linear model), it draws the line of best fit.
library(ggplot2)
g <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands
plot(g)

#Adjusting the X and Y axis limits
#Method 1: By deleting the points outside the range
library(ggplot2)
g <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands
# Delete the points outside the limits
g + xlim(c(0, 0.1)) + ylim(c(0, 1000000))   # deletes points
# g + xlim(0, 0.1) + ylim(0, 1000000)   # deletes points
#Method 2: Zooming In
#The other method is to change the X and Y axis limits by zooming in to the region of interest without deleting the points. This is done using coord_cartesian().
#Let’s store this plot as g1.
library(ggplot2)
g <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands
# Zoom in without deleting the points outside the limits. 
# As a result, the line of best fit is the same as the original plot.
g1 <- g + coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000))  # zooms in
plot(g1)
#How to Change the Title and Axis Labels
library(ggplot2)
g <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands
g1 <- g + coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000))  # zooms in
# Add Title and Labels
g1 + labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")
# or
g1 + ggtitle("Area Vs Population", subtitle="From midwest dataset") + xlab("Area") + ylab("Population")

#FULL CALL PLOT SO FAR
# Full Plot call
library(ggplot2)
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point() + 
  geom_smooth(method="lm") + 
  coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

#How to change the colour and size of point and line
library(ggplot2)
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(col="pink", size=0.5) +   # Set static color and size for points
  geom_smooth(method="lm", col="yellow") +  # change the color of line
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

library(ggplot2)
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state), size=1) +  # Set color to vary based on state categories.
  geom_smooth(method="lm", col="firebrick", size=1) + 
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")
plot(gg)

#Now each point is colored based on the state it belongs because of aes(col=state). Not just color, but size, shape, stroke (thickness of boundary) and fill (fill color) can be used to discriminate groupings.
#As an added benefit, the legend is added automatically. If needed, it can be removed by setting the legend.position to None from within a theme() functio

gg + theme(legend.position="None")  # remove legend
#Also, You can change the color palette entirely.
gg + scale_colour_brewer(palette = "Set3")  # change color palette
#More of such palettes can be found in the RColorBrewer package
library(RColorBrewer)
head(brewer.pal.info, 10)  # show 10 palettes

#How to Change the X Axis Texts and Location
#Step 1: Set the breaks
#The breaks should be of the same scale as the X axis variable. Note that I am using scale_x_continuous because, the X axis variable is a continuous variable. Had it been a date variable, scale_x_date could be used. Like scale_x_continuous() an equivalent scale_y_continuous() is available for Y axis.
# Change breaks
gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01))
#change label
gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01), labels = letters[1:11])

# Reverse X Axis Scale
gg + scale_x_reverse()

#How to Write Customized Texts for Axis Labels, by Formatting the Original Values?
#Let’s set the breaks for Y axis text as well and format the X and Y axis labels. 
#I have used 2 methods for formatting labels: 
#* Method 1: Using sprintf(). (Have formatted it as % in below example) 
#* Method 2: Using a custom user defined function. (Formatted 1000’s to 1K scale)
# Change Axis Texts
gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01), labels = sprintf("%1.2f%%", seq(0, 0.1, 0.01))) + 
  scale_y_continuous(breaks=seq(0, 1000000, 200000), labels = function(x){paste0(x/1000, 'K')})

#How to select themes
theme_gray()
theme_bw()
theme_linedraw()
theme_light()
theme_minimal()
theme_classic()
theme_void()
# method 1: Using theme_set()
theme_set(theme_classic())  # not run
gg
# method 2: Adding theme Layer itself.
gg + theme_bw() + labs(subtitle="BW Theme")
gg + theme_classic() + labs(subtitle="Classic Theme")
gg + theme_void()
gg + theme_minimal()

#The Setup
#First, you need to tell ggplot what dataset to use. This is done using the ggplot(df) function, where df is a dataframe that contains all features needed to make the plot.
library(ggplot2)
ggplot(diamonds) # if only the dataset is known.
ggplot(diamonds, aes(x=carat))  # if only X-axis is known. The Y-axis can be specified in respective geoms.
ggplot(diamonds, aes(x=carat, y=price))  # if both X and Y axes are fixed for all layers.
ggplot(diamonds, aes(x=carat, color=cut))  # Each category of the 'cut' variable will now have a distinct  color, once a geom is added.
ggplot(diamonds, aes(x=carat, y=price), color="steelblue")

#The layers
#The layers in ggplot2 are also called ‘geoms’. Once the base setup is done, you can append the geoms one on top of the other. 
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() # Adding scatterplot geom (layer1) and smoothing geom (layer2).
ggplot(diamonds) + geom_point(aes(x=carat, y=price, color=cut)) + geom_smooth(aes(x=carat, y=price, color=cut)) # Same as above but specifying the aesthetics inside the geoms.
#To make it simpler
ggplot(diamonds) + geom_point(aes(x=carat, y=price, color=cut)) + geom_smooth(aes(x=carat, y=price)) # Remove color from geom_smooth
ggplot(diamonds, aes(x=carat, y=price)) + geom_point(aes(color=cut)) + geom_smooth()  # same but simpler
#make the shape of the points vary with color feature?
ggplot(diamonds, aes(x=carat, y=price, color=cut, shape=color)) + geom_point()

#The labels
#You might want to add the plot’s main title and perhaps change the X and Y axis titles. This can be accomplished using the labs layer, meant for specifying the labels. However, manipulating the size, color of the labels is the job of the ‘Theme’.
gg <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + labs(title="Scatterplot", x="Carat", y="Price")  # add axis lables and plot title.
print(gg)
#Note: If you are showing a ggplot inside a function, you need to explicitly save it and then print using the print(gg), like we just did above.

#The Theme
#Adjusting the size of labels can be done using the theme() function by setting the plot.title, axis.text.x and axis.text.y. They need to be specified inside the element_text(). If you want to remove any of them, set it to element_blank() and it will vanish entirely.
#Adjusting the legend title is a bit tricky. If your legend is that of a color attribute and it varies based in a factor, you need to set the name using scale_color_discrete(), where the color part belongs to the color attribute and the discrete because the legend is based on a factor variable.
gg1 <- gg + theme(plot.title=element_text(size=15, face="bold"), 
                  axis.text.x=element_text(size=5), 
                  axis.text.y=element_text(size=5),
                  axis.title.x=element_text(size=10),
                  axis.title.y=element_text(size=10)) + 
  scale_color_discrete(name="Cut of diamonds")  # add title and axis text, change legend title.
print(gg1)  # print the plot
#f the legend shows a shape attribute based on a factor variable, 
#you need to change it using scale_shape_discrete(name="legend title"). 
#Had it been a continuous variable, use scale_shape_continuous(name="legend title") instead.
# based on a fill attribute on a continuous variable? The answer is scale_fill_continuous(name="legend title").

#The Facets
#In the previous chart, you had the scatterplot for all different values of cut plotted in the same chart. What if you want one chart for one cut?
gg1 + facet_wrap( ~ cut, ncol=2)  # columns defined by 'cut'
#facet_wrap(formula) takes in a formula as the argument. The item on the RHS corresponds to the column. The item on the LHS defines the rows.
gg1 + facet_wrap(color ~ cut)  # row: color, column: cut
#In facet_wrap, the scales of the X and Y axis are fixed to accomodate all points by default. This would make comparison of attributes meaningful because they would be in the same scale. However, it is possible to make the scales roam free making the charts look more evenly distributed by setting the argument scales=free.
gg1 + facet_wrap(color ~ cut, scales="free")  # row: color, column: cut
#facet_grid
gg1 + facet_grid(color ~ cut)   # In a grid

#Commonly used features
#The ggfortify package makes it very easy to plot time series directly from a time series object, without having to convert it to a dataframe.
install.packages("ggfortify")
library(ggfortify)
autoplot(airmiles) + labs(title="Airmiles")  # where AirPassengers is a 'ts' object

#Plot multiple timeseries on same ggplot
#Plotting multiple timeseries requires that you have your data in dataframe format, in which one of the columns is the dates that will be used for X-axis.
#Approach 1: After converting, you just need to keep adding multiple layers of time series one on top of the other.
#Approach 2: Melt the dataframe using reshape2::melt by setting the id to the date field. Then just add one geom_line and set the color aesthetic to variable (which was created during the melt).
# Approach 1:
data("economics", package="ggplot2")  # init data
economics <- data.frame(economics)  # convert to dataframe
ggplot(economics) + geom_line(aes(x=date, y=pce, color="pcs")) + geom_line(aes(x=date, y=unemploy, col="unemploy")) + scale_color_discrete(name="Legend") + labs(title="Economics") # plot multiple time series using 'geom_line's
# Approach 2:
library(reshape)
df <- melt(economics[, c("date", "pce", "unemploy")], id="date")
ggplot(df) + geom_line(aes(x=date, y=value, color=variable)) + labs(title="Economics")# plot multiple time series by melting
#The disadvantage with ggplot2 is that it is not possible to get multiple Y-axis on the same plot. 
#To plot multiple time series on the same scale can make few of the series appear small. 
#An alternative would be to facet_wrap it and set the scales='free'.
df <- melt(economics[, c("date", "pce", "unemploy", "psavert")], id="date")
ggplot(df) + geom_line(aes(x=date, y=value, color=variable))  + facet_wrap( ~ variable, scales="free")

#Bar charts
plot1 <- ggplot(mtcars, aes(x=cyl)) + geom_bar() + labs(title="Frequency bar chart")  
# Y axis derived from counts of X item
print(plot1)
#However, if you would like the make a bar chart of the absolute number
#given by Y aesthetic, you need to set stat="identity" inside the geom_bar.
df <- data.frame(var=c("a", "b", "c"), nums=c(1:3))
plot2 <- ggplot(df, aes(x=var, y=nums)) + geom_bar(stat = "identity")  # Y axis is explicit. 'stat=identity'
print(plot2)

# Custom layout
#The gridExtra package provides the facility to arrage multiple ggplots in a single grid.
library(gridExtra)
grid.arrange(plot1, plot2, ncol=2)

#Flipping coordinates #thsi flips the bar chart
df <- data.frame(var=c("a", "b", "c"), nums=c(1:3))
ggplot(df, aes(x=var, y=nums)) + geom_bar(stat = "identity") + coord_flip() + labs(title="Coordinates are flipped")

#Adjust X and Y axis limits
#There are 3 ways to change the X and Y axis limits.
#Using coord_cartesian(xlim=c(x1,x2))
#Using xlim(c(x1,x2))
#Using scale_x_continuous(limits=c(x1,x2))
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() + coord_cartesian(ylim=c(0, 10000)) + labs(title="Coord_cartesian zoomed in!")
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() + ylim(c(0, 10000)) + labs(title="Datapoints deleted: Note the change in smoothing lines!")

#Equal coordinate
ggplot(diamonds, aes(x=price, y=price+runif(nrow(diamonds), 100, 10000), color=cut)) + geom_point() + geom_smooth() + coord_equal()

#Change themes
#Apart from the basic ggplot2 theme, you can change the look and feel of your plots using one of these builtin themes.
theme_gray()
theme_bw()
theme_linedraw()
theme_light()
theme_minimal()
theme_classic()
theme_void()
#The ggthemes package provides additional ggplot themes that imitates famous magazines and softwares. Here is an example of how to change the theme.
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() +theme_bw() + labs(title="bw Theme")

#Legend - Deleting and Changing Position
#By setting theme(legend.position="none"), you can remove the legend. By setting it to ‘top’, i.e. theme(legend.position="top"), you can move the legend around the plot. By setting legend.postion to a co-ordinate inside the plot you can place the legend inside the plot itself. The legend.justification denotes the anchor point of the legend, i.e. the point that will be placed on the co-ordinates given by legend.position.

p1 <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() + theme(legend.position="none") + labs(title="legend.position='none'")  # remove legend
p2 <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() + theme(legend.position="top") + labs(title="legend.position='top'")  # legend at top
p3 <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() + labs(title="legend.position='coords inside plot'") + theme(legend.justification=c(1,0), legend.position=c(1,0))  # legend inside the plot.
grid.arrange(p1, p2, p3, ncol=3)  # arrange

#Grid lines
ggplot(mtcars, aes(x=cyl)) + geom_bar(fill='darkgoldenrod2') +
  theme(panel.background = element_rect(fill = 'steelblue'),
        panel.grid.major = element_line(colour = "firebrick", size=3),
        panel.grid.minor = element_line(colour = "blue", size=1))


#Plot margin and background
ggplot(mtcars, aes(x=cyl)) + geom_bar(fill="firebrick") + theme(plot.background=element_rect(fill="steelblue"), plot.margin = unit(c(2, 4, 1, 3), "cm")) # top, right, bottom, left

#Annotation
library(grid)
my_grob = grobTree(textGrob("This text is at x=0.1 and y=0.9, relative!\n Anchor point is at 0,0", x=0.1,  y=0.9, hjust=0,
                            gp=gpar(col="firebrick", fontsize=25, fontface="bold")))
ggplot(mtcars, aes(x=cyl)) + geom_bar() + annotation_custom(my_grob) + labs(title="Annotation Example")

#Saving ggplot
plot1 <- ggplot(mtcars, aes(x=cyl)) + geom_bar()
ggsave("myggplot.png")  # saves the last plot.
ggsave("myggplot.png", plot=plot1)  # save a stored ggplot


#HOW TO USE PIECHART
df <- data.frame(
  group = c("Male", "Female", "Child"),
  value = c(25, 25, 50)) #created data frame
head(df) 
#Use a barplot to visualize the data :
library(ggplot2)
# Barplot
bp<- ggplot(df, aes(x="", y=value, fill=group))+
  geom_bar(width = 1, stat = "identity")
bp
#Create a pie chart :
pie <- bp + coord_polar("y", start=0)
pie
# Use custom color palettes
pie + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))
# use brewer color palettes
pie + scale_fill_brewer(palette="Dark2")

pie + scale_fill_brewer(palette="Blues")+
  theme_minimal()
# Use grey scale
pie + scale_fill_grey() + theme_minimal()
#Create a pie chart from a factor variable:
head(PlantGrowth)
ggplot(PlantGrowth, aes(x=factor(1), fill=group))+
  geom_bar(width = 1)+
  coord_polar("y")
#Customized pie charts
#Create a blank theme :
blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )
#Apply the blank theme. Remove axis tick mark labels. Add text annotations : The package scales is used to format the labels in percent
# Apply blank theme
library(scales)
pie + scale_fill_grey() +  blank_theme +
  theme(axis.text.x=element_blank()) +
  geom_text(aes(y = value/3 + c(0, cumsum(value)[-length(value)]), 
                label = percent(value/100)), size=5)
# Use brewer palette
pie + scale_fill_brewer("Blues") + blank_theme +
  theme(axis.text.x=element_blank())+
  geom_text(aes(y = value/3 + c(0, cumsum(value)[-length(value)]), 
                label = percent(value/100)), size=5)


















#Example of thus learnt so far
data.frame(iris)
flower <- data.frame(iris)
flower
library(ggplot2)
ggplot(flower, aes(x=Sepal.Length, y=Sepal.Width))
ggplot(flower, aes(x=Sepal.Length, y=Sepal.Width)) + geom_point()+ geom_smooth()

#plain code
ggplot(flower, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point() +
  geom_smooth() +
  coord_cartesian() +
  scale_color_gradient() +
  theme_classic()

#filled the plain code up:
data.frame(diamonds)
Diamond50<-head(diamonds, 50)
Diamond50
D50<-ggplot(Diamond50, aes(x=carat, y=price)) +
  geom_point(aes(col=cut)) +
  geom_smooth(aes(col= "yellow"), method = "lm") +
  coord_cartesian() +
  theme_gray() + scale_color_brewer(palette ="Set1") + 
  labs(title = "Price vs carat", subtitle = "First 50 Dataset", caption = "CaratCut")
plot(D50)
D50 + scale_y_reverse()
ggsave("plot.png", width = 5, height = 5)

#Exploring various stuff
#a and b are graphical primitives
a <- ggplot(seals, aes(x = long, y = lat))
b <- ggplot(economics, aes(date, unemploy))
plot(a)
plot(b)
a + geom_blank() #to expand
a + geom_curve(aes(yend = lat + delta_lat, 
                   xend = long + delta_long)) #x, xend, y, yend, alpha, angle, color, curvature, linetype, size
b + geom_path(lineend="butt",
              linejoin="round", linemitre=1)#x, y, alpha, color, group, linetype, size
b + geom_polygon(aes(group = 2, col="yellow"))#x, y, alpha, color, fill, group, linetype, size 
a + geom_rect(aes(xmin = long, ymin = lat,
                  xmax= long + delta_long, ymax = lat + delta_lat))
a + geom_step()
#c is one varible; continous.
c<- ggplot(mpg, aes(hwy)) 
c
c+ geom_area(stat = "bin") 
c + geom_dotplot()
c + geom_histogram()
c + geom_freqpoly()
c + geom_density()
#d is one discrete variable
d <- ggplot(mpg, aes(fl))
d + geom_bar()
#two variables, both continous
e <- ggplot(mpg, aes(cty, hwy))
e + geom_label(aes(label = cty), nudge_x = 1,
               nudge_y = 1, check_overlap = TRUE)
e + geom_jitter(height = 2, width = 2)
e + geom_point()
e + geom_quantile()
e + geom_text(aes(label = cty), nudge_x = 1,
              nudge_y = 1, check_overlap = TRUE)
e + geom_rug(sides = "bl")
#Discrete X, Continuous Y
f<- ggplot(mpg, aes(class, hwy))
f + geom_bar(stat= "identity")
f + geom_boxplot(aes(col= "red")) + labs(title = "hwy vs class") + theme_classic()
f + geom_dotplot(binaxis = "y", stackdir = "center")
f + geom_violin(aes(col= manufacturer),scale = "area")

# two variables, both discrete discrete X and Y
g <- ggplot(diamonds, aes(cut, color))
g + geom_count()

#Continous Bivariate distribution
h <- ggplot(diamonds, aes(carat, price))
h + geom_bin2d(aes(col=cut), binwidth = c(0.25, 500))
h + geom_density2d()
h+geom_hex()
#continous function
i <- ggplot(economics, aes(date, unemploy))
i + geom_area()
i + geom_line()
i + geom_step(direction = "hv")

#visualizing error
df <- data.frame(grp = c("A", "B"), fit = 4:5, se = 1:2)
j <- ggplot(df, aes(grp, fit, ymin = fit-se, ymax = fit+se))
j + geom_crossbar(fatten = 2)
j + geom_errorbar()
j + geom_linerange()
j + geom_pointrange()

#Maps
data <- data.frame(murder = USArrests$Murder, state = tolower(rownames(USArrests)))
map <- map_data("state")
k <- ggplot(data, aes(fill = murder))
k + geom_map(aes(map_id = state), map = map) +
  expand_limits(x = map$long, y = map$lat)

#Three variables
seals$z <- with(seals, sqrt(delta_long^2 + delta_lat^2))
l <- ggplot(seals, aes(long, lat))

l + geom_contour(aes(z = z))
l + geom_raster(aes(fill = z), hjust=0.5,
                vjust=0.5, interpolate=FALSE)
l + geom_tile(aes(fill = z))

#SCALES.
#To customize a discrete bar chart
d <- ggplot(mpg, aes(fl))
d
n <- d + geom_bar(aes(fill = fl))
n
n + scale_fill_manual(
  values = c("skyblue", "royalblue", "blue", "navy"), 
  limits = c("d", "e", "p", "r"), 
  breaks =c("d", "e", "p", "r"), 
  name = "fuel", labels = c("D", "E", "P", "R"))

#General Purpose scales
#Use with any aesthetic: alpha, color, fill, linetype, shape, size
scale_continuous() #- map cont’ values to visual values 
scale_discrete() #- map discrete values to visual values 
scale_identity() #- use data values as visual values 
scale_manual(values = c()) #- map discrete values to manually chosen visual values

#X and Y location scales
#Use with x or y aesthetics (x shown here)
scale_x_date(date_labels = "%m/%d") date_breaks = "2 weeks") #- treat x values as dates.
#See ?strptime for label formats. 
scale_x_datetime() #- treat x values as date times. Use same arguments as scale_x_date(). 
scale_x_log10() #- Plot x on log10 scale scale_x_reverse() - Reverse direction of x axis scale_x_sqrt() - Plot x on square root scale

#Color and fill scales

#Faceting
t <- ggplot(mpg, aes(cty, hwy)) + geom_point()
t
t + facet_grid(. ~ fl)





















