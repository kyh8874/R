df_csv <- data.frame(제품=c("사과","딸기","수박"), 
                    가격=c(1800,1500,3000),
                    판매량 = c(24,38,13))
df_csv
mean(df_csv$가격)
mean(df_csv$판매량)
library(sqldf)
sqldf(" 
       select 가격, 판매량 from df_csv")

sqldf(" 
       select avg(가격), avg(판매량) from df_csv")

mean(df_csv[,2])
