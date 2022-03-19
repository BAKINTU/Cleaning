## Getting and Cleaning Data Project (Peer-Reviewed, Coursera)


The purpose of the project is to test my ablity to create a tidy data from various related datasets. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### Datasets
The data used for this project is contained in a compressed zip file "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip". The file includes the following information:
* **Features:** This includes all the variables/column names
* **Test folder:** Files of the _x_, _y_ and _subject_ information of the project's test data
* **Train folder:** Files of the _x_, _y_, and _subject_ information of the project's train data. 
* **Activity:** Include the activities being performed by the subject while the data was collected. The activities are 
    - Walking
    - Walking upstairs
    - Walking downstairs
    - Sitting
    - Standing
    - Laying
 
### Tasks Performed
 Created a  R script called ***run_analysis.R*** to create a tidy data in the order of the task listed below:

1. Merged the training and the test sets to create one large data set. This was easy to perform using _rbind_ since the column names are thesame for the two sets.
2. Extracted only the measurements on the mean and standard deviation for each measurement using regular expression and _grep()_. 
3. Used descriptive activity names to name the activities in the data set i.e replace the number with the actual activity label.
4. Appropriately labeled the data set with descriptive variable names using regular expression and _gsub()_. 
5. From the new data set, created a second, independent tidy data set with the average of each variable for each activity and each subject.
