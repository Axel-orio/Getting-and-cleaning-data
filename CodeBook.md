# Data preparation
To fulfill the instructions of the project there are 6 data sets form the UCI HAR Dataset that are needed, which are x_train.txt, x_test.txt, y_train.txt, y_test.txt, subject_train.txt and subject_test.txt.

The features.txt contains the correct variable name, which corresponds to each column of x_train.txt and x_test.txt.
The activity_labels.txt contains the desciptive names for each activity label, which corresponds to each number in the y_train.txt and y_test.txt.



# Transformations
The script run_analysis.R fulfills the poject instructions by :

Merging the training and the test sets to create one data set. The x_test.txt,x_train.txt; y_test.txt,y_train.txt and subject_test.txt, subject_train.txt are binded by row, and after that all three of them are binded by column.

Extracting the measurements on the mean and standard deviation for each measurement. For the column of observations, extracts only the ones that have mean() or std() in their names,and also keeps the subject and codes for future use

Using descriptive activity names to name the activities in the data set. replaces each number in the y_data column with activity_labels.txt.

Appropriately labels the data set with descriptive variable names and renames the column code to activity

From the provisional data set , creates a second, independent tidy data set with the average of each variable for each subject and each activity.

Writes out the tidy dataset to grouped_data.txt.
