wb2=filter(ai.2,state=="West Bengal")
wb3=filter(ai.3,state=="West Bengal")

wb2=wb2%>%select(-1,-3,-7,-8,-(10:15),-17,-20)%>%rename_all(tolower)
wb3=wb3%>%select(-1,-3,-7,-8,-(10:15),-20,-(24:32))%>%rename_all(tolower)
wb3=rename(wb3,relationtohead=relation)

save(ai.2,ai.3,wb2,wb3, file="C:/R/projectWB/wb.RData")
load("C:/R/projectWB/wb.RData")
library(DT)
library(tidyverse)
library(magrittr)
library(forcats)
library(stringr)

library(gridExtra)



