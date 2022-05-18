#Installing Packages

install.packages("arules")
library(arules)

install.packages("arulesViz")
library(arulesViz)

install.packages("tidyverse")
library(tidyverse)

install.packages("ggplot2")
library(ggplot2)

install.packages("plyr")
library(plyr)

lnstall.packages("Knitr")
library (knitr)

install.packages("dplyr")
library(dplyr)

install.packages("magrittr")
library(magrittr)

install.packages("RColorBrewer")
library(RColorBrewer)

#Data PreProcessing - Reading the dataset into R
ItemList <- read.csv("C:/Users/23480/OneDrive - University of Salford/Desktop/Oluwaseun/Data Science/ASDM/Coursework/Association Rule/Retail_Data.csv")
ItemList

#Inspecting the Data
names(ItemList)
head(ItemList)
tail(ItemList)
summary(ItemList)
str(ItemList)
ncol(ItemList)
nrow(ItemList)
dim(ItemList)

#Cleaning the Data by removing the rows with missing values
ItemList <- ItemList[complete.cases(ItemList),]
ItemList #ItemList now reduced from 522064 to 388023

#Grouping Items bought together in one invoice into a row
GroupedItems <- ddply(ItemList, c("BillNo", "Date"),function(df1)paste(df1$Itemname, collapse ="," ))


GroupedItems #Items have now been grouped and rows reduced to 18192 from 388023

write.csv(GroupedItems, "Items_New.csv", quote = FALSE, row.names=TRUE)

#Removing BillNo and Date Columns as they are not required.
GroupedItems$BillNo <-NULL
GroupedItems$Date <-NULL
colnames(GroupedItems) <- c("Items")
GroupedItems

write.csv(GroupedItems, "ItemList_New.csv", quote = FALSE, row.names=FALSE)

#Generating the Association rules by loading the data into an object of the transaction class
TR <- read.transactions("C:/Users/23480/OneDrive - University of Salford/Desktop/Oluwaseun/Data Science/ASDM/Coursework/Association Rule/ItemList_New.csv", format = 'basket', sep=',')

write.csv(TR, "ItemList_New.csv", quote = FALSE, row.names=FALSE)

summary(TR)

#Generating the Absolute Item Frequency Plot
itemFrequencyPlot(TR, topN=20, cex.names =0.5, type="absolute", col=brewer.pal(8, 'Pastel2'), main="Absolute Item Frequency Plot")
dev.off()
#Determining the Relative Frequency
itemFrequencyPlot(TR,topN=20, cex.names =0.5, type="relative",col=brewer.pal(8,'Pastel2'),main="Relative Item Frequency Plot")

#Generating the Association rules using the APRIORI Algorithm

association.rules <- apriori(TR, parameter = list(supp=0.005, conf=0.9,maxlen=10))
association.rules <- sort(association.rules, by='confidence', decreasing=TRUE)
summary(association.rules)

#Inspecting for Redundant Rules
inspect(association.rules)
inspect(association.rules[is.redundant(association.rules)])

subrule <- which(colSums(is.subset(association.rules, association.rules)) > 1) #subset rules 
length(subrule)
key.rules <- association.rules[-subrule] # remove subset rules. 
inspect(key.rules)

#Filtering the rules to Top 20

inspect(key.rules[1:20])
plot(key.rules)

top20Rules <- head(association.rules, n=20)
plot(top20Rules)

#Interactive Scatter plot

plot(association.rules, engine ="plotly")
plot(top20Rules, engine="plotly")

#Graph based visualization and Group Method
plot(top20Rules, method="matrix3D", measure="lift")
plot(top20Rules, method="grouped")
plot(top20Rules, method = "grouped", interactive= TRUE)


plot(top20Rules@quality)
plot(top20Rules, method = "paracoord")
plot(top20Rules, method = "graph")
plot(top20Rules, method="graph", control=list(circular =TRUE))
  
#Exploring the association rules on a Shiny Dashboard using the ruleExplorer function

rules_ex <- apriori(association.rules, parameter = list(supp=0.005, conf=0.9,maxlen=10))
ruleExplorer(rules_ex)
