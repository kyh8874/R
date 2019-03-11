c(10L,NA,20L) -> v_integer
c(10,NA,20) -> v_numeric
c(10i,NA,20i) -> v_complex
c("10",NA, "20") ->v_charactor
c(T,NA, FALSE) ->v_logical


#data.frame생성
math=c(10,40,50,60)
english=c(60,50,30,70)
df_exam= data.frame(math,english)

read.csv("Data/csv_exam.csv")->df_csv
