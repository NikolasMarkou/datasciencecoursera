require(knitr);
require(markdown);
require(data.table);
require(reshape2);

setwd("C:\\Users\\arxwn\\Documents\\Repositories\\datasciencecoursera\\CleaningData\\Project");
currentDir <- getwd();
dataRootDir <- file.path(currentDir, "UCI HAR Dataset");

## This is a safest way of reading
## a table file, it ensures file endings dont crash the
## reading process 
readDataTable <- function(filename){
  dataFile <- read.table(filename);
  dataTable <- data.table(dataFile);
  return(dataTable);
}

#########################################################
## Read the required files
testX <- readDataTable(file.path(dataRootDir, "test", "X_test.txt"));
trainX <- readDataTable(file.path(dataRootDir, "train", "X_train.txt"));
testY <- fread(file.path(dataRootDir, "test", "Y_test.txt"));
trainY <- fread(file.path(dataRootDir, "train", "Y_train.txt"));
subjectTest <- fread(file.path(dataRootDir, "test", "subject_test.txt"));
subjectTrain <- fread(file.path(dataRootDir, "train", "subject_train.txt"));
#########################################################
## Merge training and tests sets
dataTableActivityY <- rbind(testY, trainY);
dataTableActivityX <- rbind(testX, trainX);
dataTableTmpSubject <- rbind(subjectTest, subjectTrain);

## Give better names
setnames(dataTableTmpSubject, "V1", "subject");
setnames(dataTableActivityY, "V1", "activityNumber");

## Merge collumns
dataTableSubject <- cbind(dataTableTmpSubject, dataTableActivityY, dataTableActivityX);
setkey(dataTableSubject, subject, activityNumber);
#########################################################
## Extract mean and standard deviation
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

#########################################################3
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
#########################################################
## Create a tidy data set
setkey(dataTableSubject, subject, activity, featureDomain, featureAcceleration, featureInstrument, featureJerk, featureMagnitude, featureVariable, featureAxis);
dataTableTidy <- dataTableSubject[, list(count = .N, average = mean(value)), by=key(dataTableSubject)];
## write the tidy data table
write.table(dataTableTidy,file = "tidyDataset.txt", row.name = FALSE);


knit("makeCodebook.Rmd", output = "codebook.md", encoding = "ISO8859-1", quiet = TRUE);