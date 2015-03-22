
#UCI HAR Dataset is the root directory of the data zip file
parentDirectory <-"UCI HAR Dataset";


#prepareFiles function downloads the zip file from the course information and unzips if it has not already been done before.
prepareFiles <- function() {
  if (!file.exists("GettingDataProjectData.zip")){
      download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ",destfile="GettingDataProjectData.zip",method="curl")
  
      unzip("GettingDataProjectData.zip")
  }
}

#mergeDataSets function reads subject, activity, and features for test and training and merges them into one data frame.
mergeDataSets <- function(){
  
  #Subject - Read subject columns for Test data and Training data
  testSubjectColumns <- read.table(paste(parentDirectory,"/test/subject_test.txt",sep="/"),header=FALSE)
  trainingSubjectColumns <- read.table(paste(parentDirectory,"/train/subject_train.txt",sep="/"),header=FALSE)
  mergedSubjectColumns <- rbind(testSubjectColumns,trainingSubjectColumns)
  names(mergedSubjectColumns)<-c("Subject")
  
  #Activity - Read activity columns for Test and Training data
  testActivityColumns <- read.table(paste(parentDirectory,"/test/Y_test.txt",sep="/"),header=FALSE)
  trainingActivityColumns <- read.table(paste(parentDirectory,"/train/Y_train.txt",sep="/"),header=FALSE)
  mergedActivityColumns <- rbind(testActivityColumns,trainingActivityColumns)
  mergedActivityColumns <- changeActivityName(mergedActivityColumns)
  names(mergedActivityColumns)<-c("Activity")

  #Feature - Read feature columns for the test and training data
  testFeatureColumns <- read.table(paste(parentDirectory,"/test/X_test.txt",sep="/"),header=FALSE)
  trainingFeatureColumns <- read.table(paste(parentDirectory,"/train/X_train.txt",sep="/"),header=FALSE)
  mergedFeatureColumns <- rbind(testFeatureColumns,trainingFeatureColumns)
  featureNames<-read.table(paste(parentDirectory,"features.txt",sep="/"),header=FALSE)
  names(mergedFeatureColumns)<-featureNames$V2
  
  
  #First merge columns for the Subject and Activity
  mergedSubjectActivity <- cbind(mergedSubjectColumns,mergedActivityColumns)
  #Merge features with subjects and activity
  mergedAllData <- cbind(mergedSubjectActivity,mergedFeatureColumns)
}


#printStdMeanVariables is utility function used to verify the variable name changes during tidy data creation.
printStdMeanVariables<-function(){
  parentDirectory <-"UCI HAR Dataset";
  
  featureNames<-read.table(paste(parentDirectory,"features.txt",sep="/"),header=FALSE)
  
  meanStdFeatureNames<-featureNames$V2[grep("mean\\(\\)|std\\(\\)", featureNames$V2)] 
  return (meanStdFeatureNames) 
  
}

#changeActivityName function converts the integer in activity as the english description, ie walking etc
changeActivityName<-function(mergedActivityColumns){
  activityLabels <- read.table(paste(parentDirectory,"activity_labels.txt",sep="/"),header=FALSE)
  mergedActivityColumns$V1 <- mapvalues(mergedActivityColumns$V1, from = as.vector(activityLabels$V1), to = as.vector(activityLabels$V2))
  return(mergedActivityColumns)
}

#createTidyData function changes the names of the some variables and does the aggregation and ordering of the data.
createTidyData<-function(mergedDataSet){
  mergedColNames<-colnames(mergedDataSet)
  mergedColNames <- gsub("-mean()","Mean",mergedColNames,fixed=TRUE)
  mergedColNames <- gsub("-std()","Std Deviation",mergedColNames,fixed=TRUE)
  mergedColNames <- gsub("BodyBody","Body",mergedColNames,fixed=TRUE)
  mergedColNames <- gsub("^t", "Time",mergedColNames,fixed=TRUE)
  mergedColNames <- gsub("^f", "Frequency",mergedColNames,fixed=TRUE)
  mergedColNames <- gsub("Acc", "Accelerometer",mergedColNames,fixed=TRUE)
  mergedColNames <- gsub("Gyro", "Gyroscope",mergedColNames,fixed=TRUE)
  mergedColNames <- gsub("Mag", "Magnitude",mergedColNames,fixed=TRUE)
  names(mergedDataSet)<-mergedColNames
  library(memisc)
  codebook(mergedDataSet)
  
  
  library(plyr);
  tidy_data <- aggregate(. ~Subject + Activity, mergedDataSet, mean)
  tidy_data<-tidy_data[order(tidy_data$Activity,tidy_data$Subject),]  
  write.table(tidy_data,file="TidyData.txt",row.name=FALSE)
}

#run_analysis function is the test harness used to test this project goals.
run_analysis<-function(){
  setwd("/Users/rpolikepati/workspace/coursera/DataScience/GettingData/Project");
  prepareFiles();
  #print(printStdMeanVariables());
  mergedDataSet<-mergeDataSets();
  
  createTidyData(mergedDataSet);
}



  
  





