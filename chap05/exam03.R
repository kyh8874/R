library(ggplot2)

#in place
df_mpg=mpg
names(df_mpg)
names(df_mpg)[8] <-"city"
names(df_mpg)[9] <-"highway"
names(df_mpg)[10] <-"fuel"
names(df_mpg)[8:10] = c("city","highway","fuel")

#out palce
library(dplyr)
df_mpg2=mpg
rename(df_mpg2, city=cty, highway=hwy, fuel=fl)
rename(df_mpg2, city=cty, highway=hwy, fuel=fl)-> df_mpg2
df_mpg2

