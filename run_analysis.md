---
title: "run_analysis"
output: html_document
---

This is an R Markdown document for the run_analysis project that calculates mean, standard deviation etc for the samsung device motion detection. The data source is available at following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


```{r}
This program consists of several functions, such as,
* prepareFiles - This function downloads the zip file from internet if it has not already been downloaded and unzips the zip file.

* mergedDataSets - This function merges the data from activity, subject, and function data frames.

* printStdMeanVariables - This function displays all the mean and standard variables for the dataset.
[1] tBodyAcc-mean()-X           tBodyAcc-mean()-Y          
 [3] tBodyAcc-mean()-Z           tBodyAcc-std()-X           
 [5] tBodyAcc-std()-Y            tBodyAcc-std()-Z           
 [7] tGravityAcc-mean()-X        tGravityAcc-mean()-Y       
 [9] tGravityAcc-mean()-Z        tGravityAcc-std()-X        
[11] tGravityAcc-std()-Y         tGravityAcc-std()-Z        
[13] tBodyAccJerk-mean()-X       tBodyAccJerk-mean()-Y      
[15] tBodyAccJerk-mean()-Z       tBodyAccJerk-std()-X       
[17] tBodyAccJerk-std()-Y        tBodyAccJerk-std()-Z       
[19] tBodyGyro-mean()-X          tBodyGyro-mean()-Y         
[21] tBodyGyro-mean()-Z          tBodyGyro-std()-X          
[23] tBodyGyro-std()-Y           tBodyGyro-std()-Z          
[25] tBodyGyroJerk-mean()-X      tBodyGyroJerk-mean()-Y     
[27] tBodyGyroJerk-mean()-Z      tBodyGyroJerk-std()-X      
[29] tBodyGyroJerk-std()-Y       tBodyGyroJerk-std()-Z      
[31] tBodyAccMag-mean()          tBodyAccMag-std()          
[33] tGravityAccMag-mean()       tGravityAccMag-std()       
[35] tBodyAccJerkMag-mean()      tBodyAccJerkMag-std()      
[37] tBodyGyroMag-mean()         tBodyGyroMag-std()         
[39] tBodyGyroJerkMag-mean()     tBodyGyroJerkMag-std()     
[41] fBodyAcc-mean()-X           fBodyAcc-mean()-Y          
[43] fBodyAcc-mean()-Z           fBodyAcc-std()-X           
[45] fBodyAcc-std()-Y            fBodyAcc-std()-Z           
[47] fBodyAccJerk-mean()-X       fBodyAccJerk-mean()-Y      
[49] fBodyAccJerk-mean()-Z       fBodyAccJerk-std()-X       
[51] fBodyAccJerk-std()-Y        fBodyAccJerk-std()-Z       
[53] fBodyGyro-mean()-X          fBodyGyro-mean()-Y         
[55] fBodyGyro-mean()-Z          fBodyGyro-std()-X          
[57] fBodyGyro-std()-Y           fBodyGyro-std()-Z          
[59] fBodyAccMag-mean()          fBodyAccMag-std()          
[61] fBodyBodyAccJerkMag-mean()  fBodyBodyAccJerkMag-std()  
[63] fBodyBodyGyroMag-mean()     fBodyBodyGyroMag-std()     
[65] fBodyBodyGyroJerkMag-mean() fBodyBodyGyroJerkMag-std() 
477 Levels: angle(tBodyAccJerkMean),gravityMean) ...

* changeActivityName - This function replaces the activity number with the english value.

* createTidyData - This function takes the merged data frame from mergedDataSet function and changes the variable names to more descriptive. It also aggregates the data to calculate means and orders the data by activity and subject. This function also creates the TidyData.txt file uploaded with the assignment.


```
