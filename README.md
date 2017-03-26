# Getting and Cleaning Data - Final Project
Final project for Coursera Getting and Cleaning Data.

Data from the UCI machine learning project described here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones was tidied using the following method:

1. read each data input file including 
- labeling information in activity_labels.txt and 
- data in test and train folders
2. merge the test and train data sets to create one data set each for subject, activity, and measurement
3. extract only the measurements required for analysis (those with -mean or -std in the name)
4. combine subject, activity, and required measurements into a data frame (maindf)
5. use descriptive activity names
6. use descriptive variable names
7. write out this raw data set as raw-UCI-HAR-data.txt
8. create a second data set with the averages of each metric by combination of subject and activity
9. write out this summary data set as summary-UCI-HAR-data.txt
