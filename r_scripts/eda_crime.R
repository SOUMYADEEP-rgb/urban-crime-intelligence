library(tidyverse)
library(skimr)
library(corrplot)
library(DataExplorer)

data <- read.csv("../data/processed/clean_data.csv")
str(data)
head(data)


summary(data)
skim(data)

colSums(is.na(data))
plot_missing(data)

#Crime Type Distribution 
ggplot(data, aes(x = Primary.Type)) +
  geom_bar(fill = "red") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Crime Type Distribution")

#Crime By Hour
ggplot(data,aes(x=Hour)) + geom_bar(fill="blue")+ ggtitle("Crimes by Hour")

#Crime by Month
ggplot(data,aes(x=Month))+ geom_bar(fill="green")+ ggtitle(("Crimes by Month"))

#Night vs Day
ggplot(data,aes(x=Night))+geom_bar(fill="darkgreen")+labs(x="Night(1=Yes)",title="Night vs Day Crimes")

#District Wise Crime
ggplot(data,aes(x=District))+ geom_bar(fill="orange")+ggtitle("Crimes by District")

#Domestic vs Non-Domestic
ggplot(data,aes(x=Domestic))+ geom_bar(fill="pink") + ggtitle("Domestic Crimes")



