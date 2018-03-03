library(tidyverse)
ai.2=read_csv("C:/R/projectWB/WB/tidylevel2.csv") #all india level 2 data
ai.3=read_csv("C:/R/projectWB/csvdatabase/level3data.csv") #all india
#write_csv(ai.2,"tidylevel2.csv") 
# count of redundant data
#count(ai.2,ai.2$`Round and Centre code`) # checking redundant data

 #MLT is sub sample multiplier
 #mltsr is sub round multiplier
#weight = MLT_SR/100, if NSS_SR=NSC_SR			
 # MLT_SR/200 otherwise.	
 
ai.2=ai.2 %>% select(-Level)
 
ai.2$weight= ifelse(ai.2$NSS_SR==ai.2$NSC_SR,ai.2$MLT_SR/100,ai.2$MLT_SR/200)
 # assign weights to each sample
 


#normalising landowned ,poss, cultivated

ai.2=rename(ai.2,landowned=`Land owned (0.000 hectares)`,landposs=`Land possessed (0.000 hectares)`,
       landcult=`Land cultivated (0.000 hectares)`)
ai.2=rename(ai.2,ismgnrega=`MGNREG job card ?` ,numofmgnrega=`No. of MGNREG jobcard`)
ai.2=rename(ai.2,isbankpostofficeaccnt=`Any member has bank/ post office account`)
ai.2=rename(ai.2,hhtype=`Household type`)
ai.2=rename(ai.2,hhsize=`Household size`)
ai.2$hhsize=as.numeric(ai.2$hhsize)
ai.2$numofmgnrega=as.numeric(ai.2$numofmgnrega)
ai.2$landowned=as.numeric(ai.2$landowned)/1000
ai.2$landposs=as.numeric(ai.2$landposs)/1000
ai.2$landcult=as.numeric(ai.2$landcult)/1000






# remove all redundant data
 
ai.2= ai.2 %>% select(-Round,-`Round and Centre code`,-`Schedule Number`,-Filler,
                 -Filler_1,Blank,-`Special characters for OK stamp`,
                 -Sample,-`Sub-Round`,-`Sub-sample`,-Blank,
                 -NSS,-NSS_SR,-MLT,-MLT_SR,-NSC,-NSC_SR)
 #label the data
 
ai.2$Sector=factor(ai.2$Sector,labels = c("rural","urban"))
ai.2$`Social group`=factor(ai.2$`Social group`,levels=c(1,2,3,9),labels = c("ST","SC","OBC","Others"))
ai.2$Religion=factor(ai.2$Religion,levels=c(1,2,3,4,5,6,7,9),labels = c("Hinduism", "Islam", "Christianity", "Sikhism", "Jainism", "Buddhism", "Zoroastrianism", "others"))
ai.2$ismgnrega=factor(ai.2$ismgnrega,labels = c("yes","no"))
ai.2$isbankpostofficeaccnt=factor(ai.2$isbankpostofficeaccnt,labels = c("yes","no"))
#labeling hhtype
krural=ai.2[ai.2$Sector=="rural",]
kurban=ai.2[ai.2$Sector=="urban",]

krural$hhtype=factor(krural$hhtype,levels=c(1,2,3,4,5,9),labels = c("selfempagri","rselfempnonagri","rregwage","rcaslabagr","rcaslabnonagr","rothers"))
kurban$hhtype=factor(kurban$hhtype,levels=c(1,2,3,9),labels = c("uselfemployed", "uregularwage", "ucasuallabour", "uother"))
ai.2=rbind(krural,kurban)
ai.2=arrange(ai.2,ai.2$X1) #arrange in real order
rm(krural,kurban)

#factorise land size

ai.2=ai.2 %>%
  mutate(catlandown=cut(ai.2$landowned,breaks=c(0,1,2,4,10,Inf),labels=c("marginal","v.small","small","medium","large"))) %>%
  select (1:19,catlandown,everything())

ai.2=ai.2 %>%
  mutate(cathhsize=cut(ai.2$hhsize,breaks=c(0,2,6,10,15,Inf),labels=c("single","small","medium","large","Laluprasad"))) %>%
  select (1:13,cathhsize,everything())

# label names to sub-region using join function
ai.2=full_join(ai.2,regioncodes,by=c("FOD-Sub-Region"="state-region"))

ai.2=select(ai.2,1:7,Region,everything())# check the position
#data redundancy due to no data for agartala ,Imphal
ai.2=rename(ai.2,subregion=Region)
ai.2=select(ai.2,1:3,subregion,District,everything())
ai.2=ai.2[1:101724,]
#label names at region level
ai.2$`State-Region`=as.character(ai.2$`State-Region`) 
ai.2=full_join(ai.2,regcodes)
ai.2=select(ai.2,1:2,Region,everything())
#label names at state level


ai.2=full_join(ai.2,statecodes)

ai.2=select(ai.2,1:2,state,Region,subregion,statecodes,District,Sector,everything())

#label of districts
ai.2$statecodes=as.character(ai.2$statecodes) 
ai.2=full_join(ai.2,distcodes)
ai.2=ai.2[1:101724,] # some districts were not sampled
ai.2=select(ai.2,1:5,districtname,everything())

ai.2=rename(ai.2,ncocode=`Principal occupation (NC0-2004) code`)

ai.2$ncocode=as.character(ai.2$ncocode)
ai.2=full_join(ai.2,ncocode)
ai.2=ai.2[1:101724,] # remove unused levels

ai.2=select(ai.2,1:21,occupation,everything(),-`Principal industry(NIC-2008) code`)

ai.2=select(ai.2,-Level)
#ai,2 data cleaned

