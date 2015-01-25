---
title: "Project Documentation"
author: "Nikolas Markou"
date: "Sunday, January 25, 2015"
output: html_document
---

Getting and Cleaning Data Project
------------------------

> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  
> 
> One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
> 
> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
> 
> Here are the data for the project: 
> 
> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
> 
> You should create one R script called run_analysis.R that does the following. 
> 
> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set.
> 4. Appropriately labels the data set with descriptive activity names.
> 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Preparation
------------------------
> We assume that the data files are already downloaded and unziped, so the run_analysis.R is run in a directory with the "UCI HAR Dataset" directory unziped.
> We also assume that the packages "data.table" and "reshape2" are available

Reproducing analysis
------------------------
1. Open the `run_analysis.R` script and replace the working directory to your own where you have an unzipped `UCI HAR Dataset` dataset inside.
2. Run the `run_analysis.R` script
3. A file `codebook.md` should be created as well as a `tidyDataset.txt` file

Analysis of the Process
------------------------
> We first read the data in the appropriate variables.
> Files `X_test.txt` and `X_train.txt` require some special handling so we don't import them directly.
```r
testX <- readDataTable(file.path(dataRootDir, "test", "X_test.txt"));
trainX <- readDataTable(file.path(dataRootDir, "train", "X_train.txt"));
testY <- fread(file.path(dataRootDir, "test", "Y_test.txt"));
trainY <- fread(file.path(dataRootDir, "train", "Y_train.txt"));
subjectTest <- fread(file.path(dataRootDir, "test", "subject_test.txt"));
subjectTrain <- fread(file.path(dataRootDir, "train", "subject_train.txt"));
````

> We then merge the training and the testing data
```r
dataTableActivityY <- rbind(testY, trainY);
dataTableActivityX <- rbind(testX, trainX);
dataTableTmpSubject <- rbind(subjectTest, subjectTrain);
setnames(dataTableTmpSubject, "V1", "subject");
setnames(dataTableActivityY, "V1", "activityNumber");
dataTableSubject <- cbind(dataTableTmpSubject, dataTableActivityY, dataTableActivityX);
setkey(dataTableSubject, subject, activityNumber);
```

> Extracting the mean and the standard deviation
```r
## Get which variables are measurements for the mean and standard deviation 
dataTableFeatures <- fread(file.path(dataRootDir, "features.txt"))
setnames(dataTableFeatures, names(dataTableFeatures), c("featureNumber", "featureName"))

## Get the working subset for our purposes
dataTableFeatures <- dataTableFeatures[grepl("mean\\(\\)|std\\(\\)", featureName)]

## Convert column numbers to a vector of variable names 
## Subset these variables using their names
dataTableFeatures$featureCode <- dataTableFeatures[, paste0("V", featureNumber)];
selectedKeys <- c(key(dataTableSubject), dataTableFeatures$featureCode);
dataTableSubject <- dataTableSubject[, selectedKeys, with=FALSE];

dataTableActivityLabels <- fread(file.path(dataRootDir, "activity_labels.txt"))
setnames(dataTableActivityLabels, names(dataTableActivityLabels), c("activityNumber","activityName"));
```

> It is important to label everything with descriptive names as well as group multidimensional features
```r
## Label data with descriptive names
dataTableSubject <- merge(dataTableSubject, dataTableActivityLabels, by="activityNumber", all.x=TRUE);
# add activityLabel as a key
setkey(dataTableSubject, subject, activityNumber, activityName);
# flip data rows and columns
keydataTableSubject <- key(dataTableSubject);
dataTableSubject <- data.table(melt(dataTableSubject, keydataTableSubject, variable.name="featureCode"))

dataTableSubject <- merge(dataTableSubject, dataTableFeatures[, list(featureNumber, featureCode, featureName)], by="featureCode", all.x=TRUE)

dataTableSubject$activity <- factor(dataTableSubject$activityName)
dataTableSubject$feature <- factor(dataTableSubject$featureName)

## Separate features from featureName
grepFeature <- function (regex) {
  return(grepl(regex, dataTableSubject$feature))
}

## Features with 1 category
dataTableSubject$featureJerk <- factor(grepFeature("Jerk"), labels=c(NA, "Jerk"))
dataTableSubject$featureMagnitude <- factor(grepFeature("Mag"), labels=c(NA, "Magnitude"))

## Features with 2 categories
n <- 2
y <- matrix(seq(1, n), nrow=n)
x <- matrix(c(grepFeature("^t"), grepFeature("^f")), ncol=nrow(y))
dataTableSubject$featureDomain <- factor(x %*% y, labels=c("Time", "Freq"))
x <- matrix(c(grepFeature("Acc"), grepFeature("Gyro")), ncol=nrow(y))
dataTableSubject$featureInstrument <- factor(x %*% y, labels=c("Accelerometer", "Gyroscope"))
x <- matrix(c(grepFeature("BodyAcc"), grepFeature("GravityAcc")), ncol=nrow(y))
dataTableSubject$featureAcceleration <- factor(x %*% y, labels=c(NA, "Body", "Gravity"))
x <- matrix(c(grepFeature("mean()"), grepFeature("std()")), ncol=nrow(y))
dataTableSubject$featureVariable <- factor(x %*% y, labels=c("Mean", "SD"))

## Features with 3 categories
n <- 3
y <- matrix(seq(1, n), nrow=n)
x <- matrix(c(grepFeature("-X"), grepFeature("-Y"), grepFeature("-Z")), ncol=nrow(y))
dataTableSubject$featureAxis <- factor(x %*% y, labels=c(NA, "X", "Y", "Z"))
```

> Finally we create a tidy dataset and cookbook
```r
setkey(dataTableSubject, subject, activity, featureDomain, featureAcceleration, featureInstrument, featureJerk, featureMagnitude, featureVariable, featureAxis);
dataTableTidy <- dataTableSubject[, list(count = .N, average = mean(value)), by=key(dataTableSubject)];
## write the tidy data table
write.table(dataTableTidy,file = "tidyDataset.txt", row.name = FALSE);
```

