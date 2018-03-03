tst=ai.2
j=t
t=read_csv("C:/R/projectWB/csvdatabase/level1-2data.csv")

tst=select(tst,1:12,13,16,everything()) #rearrange col
#number of mgnrega holders
count(ai.2,ai.2$ismgnrega * ai.2$weight)
options(scipen = 999)
ggplot(ai.2, aes(ai.2$ismgnrega, weight = weight)) + geom_histogram(stat = "count")



