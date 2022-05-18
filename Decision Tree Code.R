install.packages("GGplot2")

Telco_Churn <-read.csv("telecom_churn.csv", header= TRUE)
na.omit(Telco_Churn)
#Preprocessing my Data using the Tidyverse package to rename some of my variables
install.packages("tidyverse")
library(tidyverse)

Telco_Churn<- Telco_Churn %>%rename("Duration" = "AccountWeeks")
Telco_Churn
Telco_Churn<- Telco_Churn %>%rename("Renewal" = "ContractRenewal")
Telco_Churn<- Telco_Churn %>%rename("CallCentre" = "CustServCalls")

Telco_Churn
#Exploring the Dataset
names(Telco_Churn)
head(Telco_Churn)
tail(Telco_Churn)
summary(Telco_Churn)
str(Telco_Churn)

hist(Telco_Churn$AccountWeeks, col="red")
hist(Telco_Churn$ContractRenewal, col="blue")
hist(Telco_Churn$DataPlan, col="Yellow")
hist(Telco_Churn$DataUsage, col="Green")
hist(Telco_Churn$CustServCalls, col="Orange")
hist(Telco_Churn$DayMins, col="Purple")
hist(Telco_Churn$DayCalls, col="pink")
hist(Telco_Churn$MonthlyCharge, col="violet")
hist(Telco_Churn$OverageFee, col="cyan")
hist(Telco_Churn$RoamMins, col="darksalmon")
#Checking the Dimension of the Dataset
nrow(Telco_Churn)
ncol(Telco_Churn)
dim(Telco_Churn)

#Converting the Tagert Variable - Churn to categorical form
Telco_Churn$ChurnP <- as.factor(Telco_Churn$Churn)
str(Telco_Churn)

#Drop non useful columns
Telco_Churn$Churn<- NULL
Telco_Churn

# Perform Boruta search
install.packages("Boruta")
library(Boruta)
boruta_data <- Boruta(ChurnP ~ ., data=na.omit(Telco_Churn), doTrace=0)
names(boruta_data)
# Get significant variables including tentatives
boruta_var <- getSelectedAttributes(boruta_data, withTentative = TRUE)
print(boruta_var)

#Do a tentative rough fix
roughFix <- TentativeRoughFix(boruta_data)
boruta_var <- getSelectedAttributes(roughFix)
print(boruta_var)

#Variable Importance Scores
imp_var <- attStats(roughFix)
imp_var2 = imp_var[imp_var$decision != 'Rejected', c('meanImp', 'decision')]
head(imp_var2[order(-imp_var2$meanImp), ]) # descending sort

# Plot the variable importance
plot(boruta_data, cex.axis=.7, las=2, xlab="", main="Important Variables by Mean")

# Training rpart model to compute important variables.
install.packages("caret")
library(caret)
set.seed(1000)
rPart_dt <- train(ChurnP ~ ., data=Telco_Churn, method="rpart")
rpart_Imp <- varImp(rPart_dt)
print(rpart_Imp)
# plotting the important variables
plot(rpart_Imp, top = 6, main='Variable Importance - rPart')


#Specifying my train and validate datasets for 70% and 30% respectively

set.seed(2000)
tc <- sample(2, nrow(Telco_Churn),replace=TRUE,prob=c(0.7,0.3))
tc
train <- Telco_Churn[tc==1,]
test<- Telco_Churn[tc==2,]

dim(train)
dim(test)
#Implementing the Decision Tree using the party package
#Installing the rpart package instead of ctree
install.packages("rpart")
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)
#Training the Tree with the rpart() function

churn_tree <- rpart(ChurnP ~ DayMins + CallCentre +  MonthlyCharge + Renewal + DataUsage + DataPlan+ OverageFee + RoamMins, data = train, method= "class")
churn_tree
rpart.plot::rpart.plot(churn_tree)

#Plotting the tree with the fancyRpartPlot function under the rattle package.
install.packages("rattle")
library(rattle)
fancyRpartPlot(churn_tree)

#Cross Validating the decision tree for optimal values
churn_tree <- rpart(ChurnP ~ DayMins + CallCentre +  MonthlyCharge + Renewal + DataUsage + DataPlan+ OverageFee + RoamMins, data = train, method= "class")
printcp(churn_tree)
plotcp(churn_tree)
summary(churn_tree)

fancyRpartPlot(churn_tree, uniform=TRUE, main="")
ptree<- prune(churn_tree, cp=   churn_tree$cptable[which.min(churn_tree$cptable[,"xerror"]),"CP"])

fancyRpartPlot(ptree, uniform=TRUE, main="pruned")

#Checking the prediction/confusion Matrix on train dataset
predict_Train <-predict(churn_tree, train, type = 'class')
predict_Train

table_train<- table(train$ChurnP, predict_Train)
table_train

#Predicting Accuracy for Train Dataset

accuracy_Train <- sum(diag(table_train)) / sum(table_train)
print(paste('Accuracy for Train', accuracy_Train))

1 - sum(diag(table_train)) / sum(table_train)


#Now usimg the model from the train data to validate/predict the test data

predict_Test<-predict(churn_tree, test, type = 'class')
predict_Test
table_test <- table(test$ChurnP, predict_Test)
table_test

confusionMatrix(table_test)


#Now calculating the prediction accuracy and error on the test data set

accuracy_Test <- sum(diag(table_test)) / sum(table_test)
print(paste('Accuracy for test', accuracy_Test))
accuracy_Test

1 - sum(diag(table_test)) / sum(table_test)
