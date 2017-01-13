#Team Valor
#Breast Cancer Wisconsin Classification Experiment USING R

cancer=read.csv("~/Desktop/Machine Learning CS167/Code/breast-cancer-wisconsin.csv",header=T)

#Data Cleaning Process
#============================================================================================

#Check the data structure:
str(cancer) 
cancer=cancer[-1] #Since ID is irrelevant and unique variables, we removed it from the column.
table(cancer$bare_nucleoli) #Identify Missing valuesdata <- read.csv('test.csv', colClasses=c("time"="character"))
cancer=na.omit(cancer) #omit na values
cancer$class <- as.factor(cancer$class)
cancer$bare_nucleoli<- as.integer(cancer$bare_nucleoli)

set.seed(16103)  # Random seed
cancer.split <- sample(2, nrow(cancer), 
                     replace = TRUE,
                     prob = c(2/3, 1/3))
cancer.train <- cancer[cancer.split == 1, ]
cancer.test  <- cancer[cancer.split == 2, ]


# Compute random forest of decision trees
set.seed(5972)                              # Random seed
cancer.rf <- randomForest(class ~ .,        # Use all var
                        data = cancer.train,  # Data
                        ntree = 1000,        # Num trees
                        importance=TRUE,
                        proximity = TRUE)   # Compute prox

print(cancer.rf)       # Results with classification table
plot(cancer.rf)        # Plot of error by number of trees
importance(cancer.rf)  # Table of variable importance
varImpPlot(cancer.rf)  # Plot of variable importance

cancer.pred <- predict(cancer.rf, newdata = cancer.test)
table(cancer.pred, cancer.test$class)
##Prediction Accuracy
prediction=array(cancer.pred)
cancertest=array(cancer.test$class)
predictionAccuracy <- sum(prediction==cancertest)/nrow(prediction)
print(predictionAccuracy + "%")