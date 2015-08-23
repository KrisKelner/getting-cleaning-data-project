
##Checking if 'plyr' is installed

if (!require("plyr")) {
  install.packages("plyr")
  require("plyr")
}


##downloading raw dataset. Raw dataset is saved into the file "dataset.zip" inside working directory,
##and then unzipped. (This will give us the folder "UCI HAR Dataset" with dataset inside).

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zippedFile <- "dataset.zip"

download.file(url, zippedFile)

unzip(zippedFile)


##reading test data, labels and subjects into separate tables and merging them into "testMerged" table

testData <- read.table("UCI HAR Dataset/test/X_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testLabels <- read.table("UCI HAR Dataset/test/y_test.txt")
testMerged<- cbind(testSubjects, testLabels, testData)

##reading training data, labels and subjects into separate tables and merging them into "trainingMerged" table
trainingData <- read.table("UCI HAR Dataset/train/X_train.txt")
trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainingLabels <- read.table("UCI HAR Dataset/train/y_train.txt")
trainingMerged <- cbind(trainingSubjects, trainingLabels, trainingData)

##merging testMerged and trainingMerged into one dataset
overallDataset <- rbind(testMerged, trainingMerged)

##"activity_labels.txt" contains links between class labels and activity names:
## we replace numbers standing for different activities with their respective names.
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
overallDataset[,2] <- activityLabels[match(overallDataset[,2], activityLabels[,1]),2]


##inserting descriptive names for columns from "features.txt". (first two columns are "Subject" and "Activity")
features <- read.table("UCI HAR Dataset/features.txt")

nameList <- c("Subject","Activity", as.vector(features[,2]))
names(overallDataset) <- nameList

##extracting measurement for the mean and standart devication for each measurement;
##"Subject" and "Activity" columns are preserved as well.

overallDataset <- overallDataset[, c(1,2,grep("-mean|-std",colnames(overallDataset)))]

##Counting the average of each variable for each subject and each activity. 
##Storing this new tidy dataset as "tidyDataset.txt" in the working directory.

tidyDataset <- ddply(overallDataset, .(Subject, Activity), numcolwise(mean))
write.table(tidyDataset, file = "tidyDataset.txt", row.name=FALSE)
