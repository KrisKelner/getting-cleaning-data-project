This is the repository for the Course Project for Coursera course "Getting and Cleaning Data".

##The assignment
"You should create one R script called run_analysis.R that does the following. 
- 1. Merges the training and the test sets to create one data set.
- 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
- 3. Uses descriptive activity names to name the activities in the data set
- 4. Appropriately labels the data set with descriptive variable names. 
- 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject." 

##Repository description
This repository contains 'run_analysis.R' script for R programming language, that downloads and transforms data for the assignment.
Data description, as well as transformation description, can be read in 'CodeBook.md' file.

##Dependencies
'run_analysis.R' uses 'ddply' from 'plyr' package.
Internet connection is necessary for this project to work, as the data will be downloaded during script execution.
