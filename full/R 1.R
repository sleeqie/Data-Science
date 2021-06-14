#Refreshers course
#simple expressions using it as a calculator
2+2
2-1
#To know what classes
class(4)
class(4L)
class('a')
#some simple expressions
2%%3
3%%6
2**2
#strings
'hello'
'world!'
#assignment to a variable
x <- 2
(x *2)

p <- 'invisible'
(q<- 'visible')

1:50
#length and characters count
length('a')
length('quux')
length(c('foo','barz'))

nchar('ukgbj')
nchar(c('foo', 'zthg'))

#indexing vectors
v <- 1:5
(v <- 1:5)
v[1]
v[4]
v[1:3]
v[c(1, 2, 5)]

#boolean 
v[c(TRUE, FALSE, TRUE, FALSE, TRUE)]
v[c(FALSE, TRUE, FALSE, TRUE, FALSE)]
#remainder sign
v%%2
v%%2== 0
v[v%%2==0]
#minus
v[-(1:3)]
#renaming vectors within a dataset
p<- c("A"=1, "B"= 2, "C"=3)
p
p["A"]
#To change names
names(p)<- c("x", "y", "z")
p

#vectorized expressions
x ** 2 - y
y <- 1
y

x <- 1:3
(x <- 1:3)
x**2
(y<- 6:8)
x**2-y

(x<- 1:4)
(y<-5:8)
x-y

#Functions
length("aedede")

#writing your own functions
square <- function(x) x**2
square (1:4)

#To run functions on several statements
square_and_subtract <- function(x, y)
{squared <- x**2
squared - y}
square_and_subtract(1:5, rev (1:5))

#another way to write the simple code
square_and_subtract_other <- function(x,y) x ** 2- y
square_and_subtract_other(1:5, rev (1:5))

square_and_subtract_other_1 <- function (x,y) return (x ** 2- y)
square_and_subtract_other_1(1:5, rev (1:5))

#vectorized expressions and functions
sum(1:4)
average <- function(x) {
  n <- length (x)
  sum (x) / n
}
average (1:5) #OR

average<- function(x) sum (x)/length (x)
average(1:5)

#control structures
#if (<boolean expression>)<expression>
if (2>3) 'false' #wont work
if (3>2) 'true' #will work

x <- 'foo'
if (2>3) x <- 'bar'
x


if (3>2) x <- 'baz'
x

if (2>3) 'bar' else 'baz'


x <- 1:5
if (x>3) 'bar' else 'baz' #it wont run

x <- (1:5)
ifelse(x> 3, 'bar', 'baz')

#maybe square
maybe_square <-  function (x) {
  ifelse (x%%2== 0, x**2, x)
}
maybe_square(1:5)

#functor
x <- 1:5
total <- 0
for (element in x) total <- total + element
total

x1 <- 1:4
total <- 0
for (element in x1) total <- total + element
total

x2 <- 1:2
total <- 0
for (element in x2) total <- total + element
total

#seq_along









