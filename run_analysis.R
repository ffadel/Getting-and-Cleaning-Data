#Getting and Cleaning Data
library(plyr)
library(dplyr)

#1.Merge the training and the test sets to create one data set.

## download files decompress
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",".\\HCI_HAR_dataset.zip")
unzip(".\\HCI_HAR_dataset.zip")

## read test data
x_test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
y_test <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
subject_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")

## read train data
x_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
y_train <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
subject_train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")

## merge train and test data
x_data <- rbind(x_train,x_test)
y_data <- rbind(y_train,y_test)
subject_data <- rbind(subject_train,subject_test)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.

## read features
features <- read.table("features.txt")

## match pattern for mean/std in the form of -mean() or -std()
mean_and_std <- grep("-(mean|std)\\(\\)",features[,2],value=FALSE)

## select only required variables from dataset
x_data <- x_data[,mean_and_std]
  

#3.Uses descriptive activity names to name the activities in the data set

# read activity names
activity_labels <- read.table("activity_labels.txt")

## replace y_data wih corresponding description of activity
y_data[,1] <- activity_labels[y_data[,1],2]


#4.Appropriately labels the data set with descriptive variable names. 
## label variables
names(x_data) <- features[mean_and_std,2]
names(y_data) <- "Activity"
names(subject_data) <- "Subject"

## merge all into a single dataset
dt <- cbind(x_data,y_data,subject_data)


#5.From the data set in step 4, creates a second, independent tidy data set 
#  with the average of each variable for each activity and each subject.
subject_activity_average <- aggregate(dt[,1:(ncol(dt)-2)],by=list(Activity=dt$Activity,Subject=dt$Subject),mean)

## write output file
write.table(subject_activity_average,file=".\\subject_activity_average.txt",row.name=FALSE)