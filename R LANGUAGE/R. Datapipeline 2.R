# The easiest way to get magrittr is to install the whole tidyverse:
install.packages("tidyverse")

# Alternatively, install just magrittr:
install.packages("magrittr")

# Or the development version from GitHub:
install.packages("devtools")
devtools::install_github("tidyverse/magrittr")

#example 1
f <- . %>% cos %>% sin
# is equivalent to 
f <- function(.) sin(cos(.)) 

#Example 2
iris %>%
  subset(Sepal.Length > mean(Sepal.Length)) %$%
  cor(Sepal.Length, Sepal.Width)
#> [1] 0.3361992

data.frame(z = rnorm(100)) %$%
  ts.plot(z)

iris

library(magrittr)
foo_foo <- little_bunny()




















