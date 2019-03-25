library(foreign)
library(haven)
library(tidyverse)
##Data Read
#1. spss
welfare_spss =read.spss("koweps/Koweps_p10_2015_beta3.sav", to.data.frame = T)


#2. sas
library(sas7bdat)
welfare_sas=read.sas7bdat("koweps/koweps_p10_2015_beta3.sas7bdat")



#3. stata
welfare_dta =read.dta("koweps/Koweps_hpc10_2015_beta3.dta")

class(welfare_dta)
class(welfare_spss)
class(welfare_sas)

welfare_dta=as_tibble(welfare_dta)
welfare_dta
