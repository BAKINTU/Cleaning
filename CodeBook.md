# Code Book for Cleaning data (Coursera project)

***run_analysis.R*** script contains the codes used for getting and cleaning relevant data to get a simple and tidy data. **Five** tasks were performed with the aim of getting a final data set that is tidy and easier to use for further analysis.

# TASKS

1. ***Merge the training and the test sets to create one data set***
    - Compressed zip folder, _UCI HAR Dataset_ containing all the data was downloaded and unzipped
    - Load all the files in the folder using ***read.csv***
      -  _features_: variable names
      -  _x train_: 7352 rows, 561 columns
      -  _y train_: 7352 rows, 1 column
      -  _x test_: 2947 rows, 561 columns
      -  _y test_: 2947 rows, 1 column
      -  _train subject_: 7352 rows, 1 column
      -  _test subject_: 2947 rows, 1 column
    -  Made two data sets (for train and test respectively) using ***data.frame***
       -  train subject, y train, x train (for train data): 7352 rows, 563 columns
       -  test subject, y test, x testvv(for test data): 2947 rows, 563 columns
    -  Using ***rbind***, the train and test data were combined to make one data set.
       -  The column names for both data sets are the same; ***(c('subject', 'activity'), features)***
       -  Dimension for the combined data is **10299 rows, 563 columns.**

2. ***Extract only the measurements on the mean and standard deviation for each measurement.***
    - Created a subset of the combined data set containing only the mean and standard deviation of each feature (variable)
        - Load the relevant package, ***dplyr**
        -  Using regular expression and ***grep**, any variable (features) where either "mean" or "std" appear was extracted; _mean_std <- grep("mean|std", features)_
        -  The mean/std data subset contains **10299 rows, 81 columns.**

3. ***Use descriptive activity names to name the activities in the data set.***
    - The activity column of the new data set was replaced with the corresponding activity using the _activity labels_ text file. The number and corresponsing activity replaced with are:
        - Walking: 1
        - Walking_Upstairs: 2
        - Walking_Downstairs: 3
        - Sitting: 4
        - Standing: 5
        - Laying: 6
4. ***Appropriately labels the data set with descriptive variable names.*** 
    - The variables (features) of the new data subset were renamed with more descriptive labels, using regular expression and ***gsub**
        - "-mean()" replaced with "Mean"
        - "Acc" replaced with "Accelerometer"
        - "Mag" = "Magnitude"
        - "BodyBody" = "Body"
        - "-freq()" = "Frequency"
        - "Gyro" = "Gyroscope"
        - "tBody" = "TimeBody"
        - Any word that starts with either "t" or "f" was replaced with either "Time" or"Frequency"
        - "-std() = "STD"
  
5. ***create a second, independent tidy data set with the average of each variable for each activity and each subject.***
    - First, the data subset of the mean and std measurments was converted to a table using ***data.table***
    - A new, tidy and independent data set of average of each subject was created using the code below
>              _Tidydata <- meanstd_data %>%_
>                   _group_by(subject, activity) %>%_
>                    _summarise_all(funs(mean))_

### The new and tidy data set contains ***180 rows and 81 columns.*** This is a more simplified data set compaired to the original (combined) data set with **10299 rows and 563 columns.**
           
