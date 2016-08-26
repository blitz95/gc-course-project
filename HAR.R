#Desiree Johnson
#Coursera - Getting and Cleaning Data Class Project
#This script downloads a zipped file containting data from Human Activity
#Recognition study. Ref:
#[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
#Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly
#Support Vector Machine. International Workshop of Ambient Assisted Living
#(IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

#Data is downloaded and unzipped
#It is then tranformed into a dataset which is a subset of the means of
#"mean" and "std" variables summarized by ActivityName and SubjectID.
#Please see the README.txt and Code Book files for more information

#Load R.utils package to enable downloadig of zipped file
library(R.utils)

#Load data.table package
library(data.table)

#Load dplyr package
library(dplyr)

################################################################################
#Create data directory if is does not exist and download and unzip file
#Check if data directory exists under working directory
#If it does not exist create directory called data under current working dir
if(!file.exists("TEMP828")) {
    dir.create("TEMP828")
}

#Set working directory to directory to create the temporary directory in
setwd("./TEMP828")

#Create a variable containing the fileurl of the zip file to be downloaded
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#Create a variable containing file name from the basename of the file url path 
file <- basename(fileurl)

#Download the the zipped file to the file name created
download.file(fileurl, file)

#Unzip the file to the current directory
unzip(file)

#Reset working directory to directory above the data folder
setwd("../")

################################################################################
#Create Activity Labels data frame
#Read in activity Lables from activity_labels.txt file
actLabels <- read.table("./TEMP828/UCI HAR Dataset/activity_labels.txt", sep = "\r", stringsAsFactors = FALSE)

#Split string create table with numbers and activity labels
#sapply splits the strings in the column of the actLables dataframe
#result is a [2,6] data frame. Transposed to a [6,2] data frame
#so could later merge with the combined traning and test data
actLabels <- t(sapply(strsplit(actLabels[[1]], " "), function(x) x[]))

#Convert to character matrix to data frame and add column names
actLabels <- as.data.frame(actLabels)
names(actLabels) <- c("ActID", "ActName")

################################################################################
#Create index of features that contain "mean" and "std" in names
#Read list of 561 features into dataframe to use as names
features <- read.table("./TEMP828/UCI HAR Dataset/features.txt", sep = "\r", stringsAsFactors = FALSE)

#Create an Index vector by searching for "mean" and "std" in features
mean_std <- grep('(mean|std)', features[,1])

################################################################################
#Create a dataframe containing the test subject identification numbers for each 
#test record
#Read in subject_test to subject_test object
subject_test <- read.table("./TEMP828/UCI HAR Dataset/test/subject_test.txt", sep = "\r", stringsAsFactors = FALSE)

################################################################################
#Create a data frame containing the activity label ids for each test record
testy <- read.table("./TEMP828/UCI HAR Dataset/test/y_test.txt", sep = "\r", stringsAsFactors = FALSE)

################################################################################
#Read in X_test data using read.tabe and colClasses for test measurement data
#Read in 10 rows of the test measurement data to run classes on the variables
tab10rowsTest <- read.table("./TEMP828/UCI HAR Dataset/test/X_test.txt", nrows = 10)
#Use sapply to determine classes of variables as 
classes <- sapply(tab10rowsTest, class)
#Use classes object as argument to read.table to read test measurement records
testx <- read.table("./TEMP828/UCI HAR Dataset/test/X_test.txt", colClasses = classes)

#Select subset of columns in the data frame by matching text to "mean" and "std" strings
#Used mean_std index vector created using grep function
testxMnStd <- testx[, mean_std]

################################################################################
#Column combine test subject Id, activity label Id, measurement data frames
test_data <- cbind(subject_test, testy, testxMnStd)

################################################################################
#Create training data frame
#Repeat steps for test data frame to create train data frame
#Training subject Id data frame
subject_train <- read.table("./TEMP828/UCI HAR Dataset/train/subject_train.txt", sep = "\r", stringsAsFactors = FALSE)
#Training Activity Label Id data frame
trainy <- read.table("./TEMP828/UCI HAR Dataset/train/y_train.txt", sep = "\r", stringsAsFactors = FALSE)
#Training measurement data frame
tab10rowsTrain <- read.table("./TEMP828/UCI HAR Dataset/train/X_train.txt", nrows = 10)
classes <- sapply (tab10rowsTrain, class)
trainx <- read.table("./TEMP828/UCI HAR Dataset/train/X_train.txt", colClasses = classes)
trainxMnStd <- trainx[ , mean_std]

################################################################################
#Column combine training subject Id, activity label Id, measurement data frames
train_data <- cbind(subject_train, trainy, trainxMnStd)

################################################################################
#Combine test and train data frames using row combine
data_combined <- rbind(test_data,train_data)

################################################################################
#Create a character string vector with variable names for mean and std variables
#Referenced
fVarNames <- sapply(strsplit(features[mean_std,], " "), '[', 2)

#Apply names to data frame variables
names(data_combined) <- c("SubjectId", "ActivityId", fVarNames)

#Merge data with Activity labels
data_comb_labeled <- merge(data_combined, actLabels, by.x = "ActivityId", by.y = "ActID")

#Aggregate and take mean
HAR_tidy_data <- aggregate(data_comb_labeled[,3:81],list(Activity=data_comb_labeled$ActName,SubjectID=data_comb_labeled$SubjectId),mean)

#Write the HAR_tidy_data data frame to the data folder under the working directory
write.table(HAR_tidy_data, file = "HAR_tidy_data.txt")

print("Output file HAR_tidy_data.txt written to current directory")

unlink("./TEMP828", recursive = TRUE)

print("TEMP828 directory, subdirectories and files removed")