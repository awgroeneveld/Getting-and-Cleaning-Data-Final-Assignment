library(data.table)

# Gets the file name based on
# * basePath - base file path
# * dataSet - train or test
# * dataType - X (feature data), y, subject
getDataFileName <- function(basePath, dataSet, dataType){
  fileName <- paste(dataType, "_", dataSet, ".txt",sep = "")
  file.path(basePath, dataSet, fileName)
}

# Gets the variables
# * basePath - base file path
readVariables <- function(basePath){
  read.table(file.path(basePath,"features.txt"),col.names = c("Sequence","Variable"))
}

# Reads the feature data and filters it for desired features to keep
# * basePath - base file path
# * dataSet - train or test
# * columns - column names for the feature data file
# * columnsToKeep - columns (features) that need to be returned
readAndFilterObservations<-function(basePath, dataSet,columns, columnsToKeep){
  observations <- read.table(getDataFileName(basePath, dataSet, "X"))
  names(observations)<-columns$Variable
  filteredObservations <- observations[,columnsToKeep$Sequence]
  filteredObservations
}

# Gets the desired data set 
# * basePath - base file path
# * dataSet - train or test
# * variables - column names for the feature data file
# * filteredVariables - columns (features) that need to be returned
# * activityLabels - labels for the activity ids
# Flow:
# 1. read main feature data
# 2. read subjects
# 3. read activities and translate them 
# 4. combine feature, subject and activity data
# 5. return as data.table for easier postprocessing
getDataSet <- function(basePath,dataSet,variables,filteredVariables,activityLabels){
  observations <- readAndFilterObservations(basePath,dataSet,variables,filteredVariables)
  subjects <- read.table(getDataFileName(basePath,dataSet,"subject"),col.names =  c("SubjectId"))
  activities <- read.table(getDataFileName(basePath,dataSet,"y"), col.names = c("ActivityId"))
  allData <- cbind(SubjectId=factor(subjects$SubjectId), Activity=factor(activities$ActivityId, levels=activityLabels$ActivityId, labels=activityLabels$Activity), observations)
  data.table(allData)
}

# Gets the merged data
# * basePath - base file path
# * dataSet - train or test
# * variables - column names for the feature data file
# * filteredVariables - columns (features) that need to be returned
# * activityLabels - labels for the activity ids
# Flow:
# 1. get train data
# 2. get test data
# 3. merge 1) and 2)
getData <- function(basePath,variables,filteredVariables,activityLabels){
  trainData<-getDataSet(basePath,"train",variables,filteredVariables,activityLabels)
  testData<-getDataSet(basePath,"test",variables,filteredVariables,activityLabels)
  rbind(trainData,testData)
}


# Do the averaging by subject and activity and tidy the data set 
# * dataSet - data set to be averaged and tidied
# Make column names compliant:  
# - Make Camel Case: replace `-[a-z]xxxxx' by `[A-Z]xxxx'
# - Replace initial t or f by a more meaningful abbreviation Time or Freq (for Frequency)
# - Remove the parenthesis and dashes
# - Replace `BodyBody' by `Body'
averageAndMakeTidy<-function(dataSet){
  tidyDataSet <- dataSet[, lapply(.SD, mean), by=list(SubjectId, Activity)]
  
  names <- names(tidyDataSet)
    names <- gsub("\\-([a-z])", "\\U\\1", names, perl=TRUE)
  names <- gsub("^t", "Time", names)
  names <- gsub("^f", "Freq", names)
  names <- gsub("[()-]", "", names)
  names <- gsub("BodyBody", "Body", names)
  names(tidyDataSet) <- names
  write.table(factor(names), file="tidyFeatures.txt",row.names=FALSE,quote = FALSE)
  tidyDataSet
}

# Main function to run requested transformations
run.analysis <- function(){
  # initial setup globals
  basePath <- file.path(getwd(), "UCI HAR DataSet")
  activityLabels <- read.table(file.path(basePath, "activity_labels.txt"),col.names = c("ActivityId","Activity"))
  variables=readVariables(basePath)
  
  # filter the mean and standard features
  filteredVariables=variables[grep("-(mean|std)\\(\\)",variables$Variable),]
  
  # get the training and test data as a merged dataset
  mergedData<-getData(basePath,variables,filteredVariables,activityLabels)
  write.csv(mergedData,file="mergedData.csv",row.names = FALSE, quote=FALSE)

  # create the tidy dataset
  tidyData<-averageAndMakeTidy(mergedData)
  write.csv(tidyData,file="tidyData.csv",row.names = FALSE, quote=FALSE)
  write.table(tidyData,file="tidyData.txt",row.names = FALSE)
  # return the tidy dataset
  tidyData
}