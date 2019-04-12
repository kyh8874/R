library(tidyverse)
library(foreign)
library(readstata13)

koweps_h=read.dta13("koweps_m/koweps_h01_13_long_beta1.dta")
koweps_hp=read.dta13("koweps_m/koweps_hp01_13_long_beta1.dta")

koweps_h=koweps_m


str(koweps_hp)

