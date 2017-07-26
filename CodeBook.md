# CodeBook.md

This describes the variables, data and transformation implemented in the runAnalysis.R script

### Variables 

The following describes the variables created in the script:

* `x_test, y_test, subject_test, x_train, y_train, subject_train` 
are the dataset from the downloaded 
[UCI HAR Dataset](name:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

* `x_data, y_data, subject_data` are the corresponding merged datasets created from combining the train and test sets.

* `features` represent the names of variables contained in the `x_train and x_test` datasets.

* `mean_and_std` represents the columns names (varaible names) that contain the mean and std values from the experiment.

* `dt` is single dataset that contains thhe combined columns of `x_data, y_data and subject_data`.

* `subject_activity_average` is the final tidy data set that contains the average by activity and subject.

### Transformation

The tranfomation steps consist of the following 5 steps:

* 1. combine test and tran files into a single dataset using `rbind` function.

* 2. Extract the column ids of the variables containing the mean and standard deviation and extract the associated data from the `x_data` data set using `grep()` function.

* 3. Update the value of each activity in the label data set `y_data` with the actual representation of that value.

* 4. Label all variables in the `x-data` dataset using the features.txt, set variable names of Activity and Subject accordingly then combine all datasets into `dt` data set using the `cbind` function.

* 5. Aggregate the data from step above by subject and activity then store the results into `subject_activity_average` which then writes out into the `subject_activity_average.csv` file.