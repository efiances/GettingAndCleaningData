

# Charging libraries and useful paths
  
library(plyr)
packages <- c("data.table", "reshape2")
sapply(packages, require, character.only = TRUE, quietly = TRUE)
PathRoot <- c('C:\\01 DC\\03 Getting and Cleaning Data\\04 Week 4\\04 07 Final Project\\02 Test')
PathResult1 <- c('C:\\01 DC\\03 Getting and Cleaning Data\\04 Week 4\\04 07 Final Project\\02 Test\\01 Tidy Dataset')
PathResult2 <- c('C:\\01 DC\\03 Getting and Cleaning Data\\04 Week 4\\04 07 Final Project\\02 Test\\02 Summary Dataset')


# 0. Download of information from indicated url and set of working folder

URL_Site <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
Download_File_01 <- file.path(PathRoot, "Dataset.zip")
download.file(URL_Site,Download_File_01)
setwd(PathRoot)
unzip("Dataset.zip")

PathGround <- c('C:\\01 DC\\03 Getting and Cleaning Data\\04 Week 4\\04 07 Final Project\\02 Test\\UCI HAR Dataset')
PathTest <- c('C:\\01 DC\\03 Getting and Cleaning Data\\04 Week 4\\04 07 Final Project\\02 Test\\UCI HAR Dataset\\test')
PathTrain <- c('C:\\01 DC\\03 Getting and Cleaning Data\\04 Week 4\\04 07 Final Project\\02 Test\\UCI HAR Dataset\\train')


# 1. Merger of training and test sets to create one data set
# 1.1. Extraction and setting of downloaded information

setwd(PathGround)
HeadVector <- read.table("features.txt", header = FALSE, sep = "")
setwd(PathTest)
xTest <- read.table("X_test.txt", header = FALSE, sep = "")
yTest <- read.table("y_test.txt", header = FALSE, sep = "")
SubTest <- read.table("subject_test.txt", header = FALSE, sep = "")

setwd(PathTrain)
xTrain <- read.table("X_train.txt", header = FALSE, sep = "")
yTrain <- read.table("y_train.txt", header = FALSE, sep = "")
SubTrain <- read.table("subject_train.txt", header = FALSE, sep = "")


# 1.2. Merger of databases

xMerged <- rbind(xTrain, xTest)
yMerged <- rbind(yTrain, yTest)
SubjectMerged <- rbind(SubTrain, SubTest)


# 2. Extraction of measurements on the mean and standard deviation.

MeanStdev <- grep("(mean|std)\\(\\)", HeadVector[, 2])
x_MeanStdev <- xMerged[, MeanStdev]
names(x_MeanStdev) <- HeadVector[MeanStdev,2]
head(x_MeanStdev)
summary(x_MeanStdev)


# 3. Use of descriptive activity names to name the activities in the data set

setwd(PathGround)
Activity <- read.table("activity_labels.txt", header = FALSE, sep = "")
head(Activity)
ActivityLabel <- yMerged
ActivityLabel[, 1] <- Activity[yMerged[, 1], 2]
head(ActivityLabel)


# 4. Appropriate labeling of data sets and set of main Clean & Tidy Dataset

# 4.1. Label of Activities


names(ActivityLabel) <- c("Activity")
head(ActivityLabel)


# 4.2. Label of Subject data

Subject <- SubjectMerged
names(Subject) <- "Subject"
head(Subject)


# 4.3. Merge of datasets. Set file of Clean & Tidy Dataset

FullData <- cbind(x_MeanStdev, ActivityLabel, Subject)
head (FullData)
setwd(PathResult1)
write.table(FullData, "01_TidyDataSet.txt", row.name = FALSE)
TidyDataSet <- read.table("01_TidyDataSet.txt", header = TRUE)


# 5. Creation of a tidy data set with the average of each variable for each activity and subject.

# 5.1. Create Averages Dataset

SummaryTable <- ddply(FullData, .(Subject, Activity), function(x) colMeans(x[, 1:66]))
head(SummaryTable)


# 5.2 Set file of Averages Dataset

setwd(PathResult2)
write.table(SummaryTable, "02_AveragesDataSet.txt", sep = " ", row.name=FALSE)
AveragesDataSet <- read.table("02_AveragesDataSet.txt", header = TRUE)

