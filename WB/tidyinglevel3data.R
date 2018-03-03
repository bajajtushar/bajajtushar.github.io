#level 3 data ai.3
#read_csv("C:/R/projectWB/csvdatabase/level3data.csv")---raw file
ai.3=read_csv("tidylevel3.csv") #ai.3---tidy file
ai.3$weight3= ifelse(ai.3$NSS_SR==ai.3$NSC_SR,ai.3$MLT_SR/100,ai.3$MLT_SR/200)

ai.3= ai.3%>% select(-Round,-`Round and Centre code`,-`Schedule Number`,-Filler,
                      -Filler_1,-Blank,-`Special characters for OK stamp`,
                      -Sample,-`Sub-Round`,-`Sub-sample`,
                      -NSS,-NSS_SR,-MLT,-MLT_SR,-NSC,-NSC_SR)

ai.3=ai.3 %>% select(-Level)
ai.3$Sector=factor(ai.3$Sector,labels = c("rural","urban"))

regioncodes=read_csv("C:/R/projectWB/subregioncodes.csv")
regcodes=read_csv("C:/R/projectWB/regcods.csv")
statecodes=read_csv("C:/R/projectWB/statecodes.csv")
distcodes=read_csv("C:/R/projectWB/districtcodes.csv")
regcodes$`State-Region`=as.character(regcodes$`State-Region`)
ai.3=full_join(ai.3,regcodes)

ai.3=full_join(ai.3,regioncodes,by=c("FOD-Sub-Region"="state-region"))





ai.3=ai.3[1:456999,] # removing redundant columns

ai.3=rename(ai.3,Region=Region.x,subregion=Region.y)
statecodes$`State-Region`=as.character(statecodes$`State-Region`) 
ai.3=full_join(ai.3,statecodes)
distcodes$statecodes=as.character(distcodes$statecodes)
ai.3$statecodes=as.character(ai.3$statecodes)
ai.3=full_join(ai.3,distcodes)

ai.3=ai.3[1:456999,]

ai.3=select(ai.3,1:2,state,Region,subregion,districtname,statecodes,statecodes,District,Sector,everything())

#labeling attributes of level3

ai.3$Sex= factor(ai.3$Sex,levels = c(1,2),labels = c("male","female"))

ai.3$`Relation to head`=as.character(ai.3$`Relation to head`)
ai.3=full_join(ai.3,y,by=c("Relation to head"="relationcode"))

#never married -1, currently married -2, widowed -3, divorced/separated -4.
ai.3$`Marital status`=factor(ai.3$`Marital status`,levels = c('1','2','3','4'),labels=c("nevermarried","married","widowed","divorced"))
ai.3$`General education`=as.numeric(ai.3$`General education`)
ai.3=full_join(ai.3,x)

ai.3=select(ai.3,1:17,relation,education,everything())

#write_csv(ai.3,"tidylevel3.csv")


