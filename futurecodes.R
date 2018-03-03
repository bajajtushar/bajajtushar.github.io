b=cut(ai.2$landowned,breaks=c(0,1,2,4,10,Inf),labels=c("marginal","v.small","small","medium","large"))

plot(j)



summary(ai.2$landowned)


stem(ai.2$landowned)

y=k%>%mutate(catlandown=j)%>%group_by(`Social group`,Religion,catlandown)%>%tally(wt=weight)

tst=select(tst,1:12,13,16,everything()) #rearrange col

f1 <- factor(x1, levels = unique(x1)) # creates levels

#use fact_reorder for reordering  and case when or fct_recode for reassigning;fct_collapse for combining

#msleep %>%  
#  select(name, sleep_total) %>%
#  mutate(sleep_total_discr = case_when(
 #   sleep_total > 13 ~ "very long",
 #   sleep_total > 10 ~ "long",
 #   sleep_total > 7 ~ "limited",
 #   TRUE ~ "short")) %>%
 # mutate(sleep_total_discr = factor(sleep_total_discr, 
                                   # levels = c("short", "limited", 
                                           #     "long", "very long")))



tst=tst %>%
  mutate(catlandown=cut(tst$landowned,breaks=c(0,1,2,4,10,Inf),labels=c("marginal","v.small","small","medium","large"))) %>%
  select (1:13,catlandown,everything())

p%>%select(Religion,catlandown)%>%group_by(p$occupation)%>%count()%>%
  filter(n>8)%>%kable()


