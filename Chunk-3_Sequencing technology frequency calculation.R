################Sequencing technology frequency calculation#####
##Time
NCBI$Year <- format(as.Date(NCBI$Date, format = "%Y/%m/%d"), "%Y")

##Calculate the frequency for each year
year_frequency <- table(NCBI$Year)

##Output year frequency table
print(year_frequency)

##Sequencing technology
#stage1(2004~2010)
library(dplyr)
library(tidyr)
stage1 <- NCBI %>%
  filter(Year == c("2004","2005","2006","2007","2008","2009","2010"))
stage1 <- stage1 %>%
  mutate(Sequencing.Tech = strsplit(Sequencing.Tech, "; "))
stage1_long <- stage1 %>%
  unnest(Sequencing.Tech)
technique_frequency <- stage1_long %>%
  count(Sequencing.Tech, sort = TRUE)
print(technique_frequency)
write.csv(technique_frequency,"/Users/jingsun/Desktop/stage3_2.csv")


#stage2(2011~2020)
stage2 <- NCBI %>%
  filter(Year == c("2011","2012","2013","2014","2015","2016","2017","2018","2019","2020"))
stage2 <- stage2 %>%
  mutate(Sequencing.Tech = strsplit(Sequencing.Tech, "; "))
stage2_long <- stage2 %>%
  unnest(Sequencing.Tech)
technique_frequency <- stage2_long %>%
  count(Sequencing.Tech, sort = TRUE)
print(technique_frequency)


#Stage3 (2021~2023)
stage3 <- NCBI %>%
  filter(Year == c("2021","2022","2023"))
stage3 <- stage3 %>%
  mutate(Sequencing_technology.y = strsplit(Sequencing_technology.y, "; "))
stage3_long <- stage3 %>%
  unnest(Sequencing_technology.y)
technique_frequency <- stage3_long %>%
  count(Sequencing_technology.y, sort = TRUE)
print(technique_frequency)
