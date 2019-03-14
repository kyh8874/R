library(dplyr)
library(ggplot2)

#문제1
df_midwest = as.data.frame(ggplot2::midwest)
head(df_midwest)
tail(df_midwest)
View(df_midwest)
dim(df_midwest)
str(df_midwest)
summary(df_midwest)

#문제2
df_midwest <- rename(df_midwest, total = poptotal, asian=popasian)
head(df_midwest)

#문제3
df_midwest$p_asian = (df_midwest$asian /df_midwest$total) *100
qplot(df_midwest$state,df_midwest$p_asian, data=df_midwest, geom="auto")

#문제4
avg=mean(df_midwest$p_asian)
df_midwest$grade = ifelse(df_midwest$p_asian>=avg,"large","small")
                  
#문제5
table(df_midwest$grade)
qplot(df_midwest$grade)
