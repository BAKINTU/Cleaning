filename <- "UCI_Dataset_project.zip"
# Checking if zip file already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}
# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) {
  unzip(filename)
}

##Load all the required files, save with simple and descriptive names

##Features i.e names of the columns
features <- read.csv('./UCI HAR Dataset/features.txt', 
                     header = FALSE, sep = ' ')
features <- as.character(features[,2])

##Load individual train data file, then combine to a single train data frame
x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
y_train <- read.csv('./UCI HAR Dataset/train/y_train.txt', 
                    header = FALSE, sep = ' ')

train_subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt',
                          header = FALSE, sep = ' ')
train_data <-  data.frame(train_subject, y_train, x_train)

##Indicates the column names
names(train_data) <- c(c('subject', 'activity'), features)

##Load individual test data file, then combine to a single test data frame
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
y_test <- read.csv('./UCI HAR Dataset/test/y_test.txt', 
                   header = FALSE, sep = ' ')
test_subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', 
                         header = FALSE, sep = ' ')
test_data <-  data.frame(test_subject, y_test, x_test)

##Indicates the column names
names(test_data) <- c(c('subject', 'activity'), features)

combined_data <- rbind(train_data, test_data)

library(dplyr)

##Extracts only the measurements on the mean 
##And standard deviation for each measurement

#Using regular expression, create a subset of data frame including all
#columns where either "mean" or "std" appears
mean_std <- grep("mean|std", features)
meanstd_data <- combined_data[,c(1,2,mean_std + 2)]
View(meanstd_data)

##Use descriptive activity names to name the activities in the new data set
##Data set used is the subset containing only mean/std variables

#First, read the activity label text file
activity_names <- read.table('./UCI HAR Dataset/activity_labels.txt', 
                             header = FALSE)
activity_names <- as.character(activity_names[,2])
##Merge the activity name with the activity column of the new data set.
meanstd_data$activity <- activity_names[meanstd_data$activity]

##Appropriately labels the data set with descriptive variable names.
names(meanstd_data) <- gsub("Acc", "Accelerometer", names(meanstd_data))
names(meanstd_data) <- gsub("Gyro", "Gyroscope", names(meanstd_data))
names(meanstd_data) <- gsub("BodyBody", "Body", names(meanstd_data))
names(meanstd_data) <- gsub("Mag", "Magnitude", names(meanstd_data))
names(meanstd_data) <- gsub("^t", "Time", names(meanstd_data))
names(meanstd_data) <- gsub("^f", "Frequency", names(meanstd_data))
names(meanstd_data) <- gsub("tBody", "TimeBody", names(meanstd_data))
names(meanstd_data) <- gsub("-mean()", "Mean", names(meanstd_data), 
                            ignore.case = TRUE)
names(meanstd_data) <- gsub("-std()", "STD", names(meanstd_data), 
                            ignore.case = TRUE)
names(meanstd_data) <- gsub("-freq()", "Frequency", names(meanstd_data), 
                            ignore.case = TRUE)
names(meanstd_data) <- gsub("angle", "Angle", names(meanstd_data))
names(meanstd_data) <- gsub("gravity", "Gravity", names(meanstd_data))

##creates a second, independent tidy data set with the 
##average of each variable for each activity and each subject

##first convert the new data set to table
meanstd_data <- data.table(meanstd_data)

##Create a new tidy data
Tidydata <- meanstd_data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
##Save as Text file
write.table(Tidydata, "Tidydata.txt", row.name=FALSE)
