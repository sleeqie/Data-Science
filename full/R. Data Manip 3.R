#data manipulation
library(datasets)
library(help= 'datasets')

data (cars)
head(cars)

library(ggplot2)
cars%>%qplot(speed, dist, data = .)

install.packages('mlbench')
library('mlbench')
library(help = 'mlbench')

#Quickly reviewing data
cars%>% head (3)
head(cars[1:2])

cars%>% tail (3)
tail(cars[1:2])

cars%>%summary
summary(cars)

data(iris)
iris%>%summary()

#reading and formatting datasets
#breastcancerdataset
library(mlbench)
data("BreastCancer")
BreastCancer%>%head(3)

lines <- readLines('http://tinyurl.com/kw4xtts')
lines[1:5]

raw_breast_cancer <- read.csv('http://tinyurl.com/kw4xtts')
raw_breast_cancer %>% head(3) #first line seen as header

raw_breast_cancer <- read.csv('http://tinyurl.com/kw4xtts', header = FALSE)
raw_breast_cancer %>% head(3)

names(raw_breast_cancer) <- names(BreastCancer)#to give the data names
raw_breast_cancer %>% head(3)

raw_breast_cancer <- read.csv('http://tinyurl.com/kw4xtts', header = FALSE, col.names = names(BreastCancer))
raw_breast_cancer %>% head(3)

#to translate the numbers into a factor by first translating numbers into strings
raw_breast_cancer
formatted_breast_cancer <- raw_breast_cancer

map_class <- function(x){
  ifelse(x==2, 'benign',
         ifelse (x==4, 'malignant',
                 NA))
}

mapped <- formatted_breast_cancer$Class %>% map_class
mapped
mapped %>% table

map_class <- function(x){
  ifelse(x==2, 'benign',
         'malignant')
}
map_class

mapped <- formatted_breast_cancer$Class %>% map_class
mapped
mapped%>%table

#Nested if else
#we do this to directly convert numbers to strings
dict <- c("2" ="benign", "4" = "Malignant")
mapped <- formatted_breast_cancer $ Class %>%map_class
mapped
mapped%>%table

mapped [1:5]
mapped %<>% unname
mapped [1:5]

#boston housing dataset
library(mlbench)
mlbench
data("BostonHousing")
str(BostonHousing)


boston_housing <- read.table('http://tinyurl.com/zq2u8vx')
str(boston_housing)

col_classes <- rep('numeric', length(BostonHousing))
col_classes [which('chas'== names(BostonHousing))] <- 'factor'
boston_housing <- read.table('http://tinyurl.com/zq2u8vx',
                             col.names = names(BostonHousing),
                             colClasses = col_classes)
str(boston_housing)

#Readr package
install.packages('readr')
library(readr)

#dplyr
install.packages('dplyr')
library('dplyr')
iris%>%tbl_df()


#select
iris%>%tbl_df%>%select(Petal.Length)%>% head(3)

iris%>%tbl_df%>%select(Sepal.Width, Petal.Length)%>% head(3)

iris%>%tbl_df%>%select(Sepal.Width: Petal.Length)%>% head(3)

iris%>%tbl_df%>%select (starts_with('petal'))%>% head(3)

iris%>%tbl_df%>%select (ends_with('width'))%>% head(3)

iris%>%tbl_df%>%select (contains('petal'))%>% head(3)

iris%>%tbl_df%>%select (matches('.t.'))%>% head(3)

#mutate function
iris%>%tbl_df%>%select (starts_with('petal'))%>% head(3)

iris%>%tbl_df%>%
  mutate (Petal.Width.plus.Length = Petal.Width + Petal.Length) %>%
  select(Species, Petal.Width.plus.Length)%>%
  head(3)

#transmute
iris%>%tbl_df%>%
  transmute (Petal.Width.plus.Length = Petal.Width + Petal.Width) %>%
  head(3)

#Arrange
iris%>%tbl_df%>%
  arrange (Sepal.Width) %>%
  head(3)

#to arrange in descending order
iris%>%tbl_df%>%
  arrange(desc (Petal.Width.plus.Length = Petal.Width + Petal.Length)) %>%
  head(3)

#filter
iris%>%tbl_df%>% 
  filter (Sepal.Length > 5) %>%
  head(3)

iris%>%tbl_df%>% 
  filter (Sepal.Length > 5 & Species == 'Virginica') %>%
  select(Species, Sepal.Length)%>%
  head(3)

#groupby
iris%>%tbl_df%>% 
  group_by (Species) %>%
  head(10)

#Summarize
iris%>%
  summarise(mean.Petal.Length = mean(Petal.Length, 
                                     mean.sepal.length = mean(Sepal.Length)))

#summarize + groupby
iris%>%
  group_by(Species)%>%
  summarise(mean.Petal.Length = mean(Petal.Length))

iris%>%
  summarise(observations= n())

iris%>%
  group_by(Species)%>%
  summarise(Number.of.Species. = n())

iris%>%
  group_by(Species)%>%
  summarise(Number.of.Samples. = n(),
            mean.petal.length= mean(Petal.Length))

#Breast cancer data Manipulation
formatted_breast_cancer <- raw_breast_cancer %>% mutate (Class= Class)%>%
  {c ('2' = 'benign', '4' = 'malignant') [as.character(.) ]}%>%
  unname%>% factor(levels = c('benign', 'malignant'))

format_class <- . %>% {
  dict <- c ('2' = 'Benign', '4' = 'Malignant')
  dict [as.character(.)]
} %>% unname %>% factor(levels = c('Benign', 'Malignant'))

formatted_breast_cancer <- raw_breast_cancer %>% mutate(Class=format_class(Class))

#fORMATTED BREAST CANCER
formatted_breast_cancer %>% group_by(Class)%>%
  summarise(mean.thickness= mean(Cl.thickness))

formatted_breast_cancer %>% group_by(Class)%>%
  summarise(mean.size= mean(Cell.size))

formatted_breast_cancer %>% arrange(Cell.size)%>%
  group_by(Cell.size, Class) %>%
  summarise(classcount= n())

#combined parameters
#we shall observe how the cells behave as a function of both class and cell size
formatted_breast_cancer %>% group_by(Class, as.factor(Cell.size))%>%
  summarise(mean.thickness = mean (Cl.thickness))

formatted_breast_cancer %>% group_by(as.factor(Cell.size), Class)%>%
  summarise(mean.thickness = mean (Cl.thickness))

#











































