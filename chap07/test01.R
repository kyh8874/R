library(tidyvers)

mpg <- as.data.frame(ggplot2::mpg) # mpg 데이터 불러오기
mpg[c(10, 14, 58, 93), "drv"] <- "k" # drv 이상치 할당
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42) # cty 이상치 할당

#drv이상치확인
table(mpg$drv)
table(mpg$cty)

#drv 이상치 결측처리
mpg$drv<-ifelse(mpg$drv %in% c("4","f","r"),mpg$drv,NA)

#drv 이상치 결측처리 확인
table(is.na(mpg$drv))

#boxplot으로 cty로 이상치확인
boxplot(mpg$cty)$stats

#cty 이상치 결측처리
mpg$cty<-ifelse(mpg$cty < 9 | mpg$cty >26, NA,mpg$cty)

#cty 이상치 결측처리 확인
table(is.na(mpg$cty))

#결측치 제외하고 분석
mpg %>% filter(!is.na(mpg$drv) & !is.na(mpg$cty)) %>% 
        select(drv,cty) %>% 
        group_by(drv) %>% 
        summarise(drv_mean=mean(cty))

