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








