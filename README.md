# Getting and Cleaning Data - Final Project
Final project for Coursera Getting and Cleaning Data

## Synopsis
Data from the UCI machine learning project described here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones was tidied using the following method:

1. read each data input file including  
  a. labeling information in activity_labels.txt and  
  b. data in test and train folders
2. merge the test and train data sets to create one data set each for subject, activity, and measurement
3. extract only the measurements required for analysis (those with -mean or -std in the name)
4. combine subject, activity, and required measurements into a data frame (maindf)
5. use descriptive activity names
6. use descriptive variable names - rearrange names for readability
7. write out this raw data set as raw-UCI-HAR-data.txt
8. create a second data set with the averages of each metric by combination of subject and activity
9. write out this summary data set as summary-UCI-HAR-data.txt

all steps are contained in run_analysis.R

## To Use This Code (Input & Dependencies )
**NOTE:** run_analysis.R requires library dtplyr 

1. retrieve the data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones (see Download link at the top of the page)
2. unzip the data. you will see a folder called "UCI HAR Dataset"
3. set your working directory to the folder which _contains_ the UCI HAR Dataset folder
4. run runAnalysis()

## Output
the code will produce two files in a subfolder called "data"
* raw-UCI-HAR-data.txt - the raw readings for mean and standard deviation measures for all test and train subjects and activities
* summary-UCI-HAR-data.txt - a summary of the data showing averages of each metric by combination of subject and activity
