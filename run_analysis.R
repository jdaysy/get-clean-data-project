runAnalysis <- function(){
## load required libraries
library(dtplyr, quietly=TRUE)
        
## read each data input file
activitylabels <- fread("./UCI HAR Dataset/activity_labels.txt")
features <- fread("./UCI HAR Dataset/features.txt")
subj_test <- fread("./UCI HAR Dataset/test/subject_test.txt", col.names=c("subjectID"))
subj_train <- fread("./UCI HAR Dataset/train/subject_train.txt", col.names=c("subjectID"))
x_test <- fread("./UCI HAR Dataset/test/X_test.txt", col.names=gsub("[(|)]","",features$V2))
x_train <- fread("./UCI HAR Dataset/train/X_train.txt", col.names=gsub("[(|)]","",features$V2))
y_test <- fread("./UCI HAR Dataset/test/y_test.txt", col.names=c("activity"), colClasses="factor")
y_train <- fread("./UCI HAR Dataset/train/y_train.txt", col.names=c("activity"), colClasses="factor")

## merge training and test sets to create one data set
subject <- bind_rows(subj_test, subj_train)
activity <- bind_rows(y_test, y_train)
meas <- bind_rows(x_test, x_train)


## extract only the measurements on mean and standard deviation
## for each measurement before creating first combined set
meas <- select(meas, ends_with("-mean"), ends_with("-std"), contains("-mean-"), contains("-std-"))

maindf <- bind_cols(subject, activity, meas)

## use descriptive activity names to name the activities in the data set
maindf <- mutate(maindf, activity = factor(maindf$activity, labels=activitylabels$V2))

## appropriately label the data set with descriptive variable names
## make friendly names
x <- names(maindf)
newnames <- c("subjectID", "activity")
for(i in seq_along(x)){
        if(x[i]!="subjectID" & x[i]!="activity"){
                if(substr(x[i],1,1)=="t") {domain <- "time"}
                if(substr(x[i],1,1)=="f") {domain <- "frequency"}
                namelist <- strsplit(x[i],"-")
                if(namelist[[1]][2]=="mean") {math <- "mean_of"}
                if(namelist[[1]][2]=="std") {math <- "std_of"}
                if(!is.na(namelist[[1]][3])) {axis <- namelist[[1]][3] }
                if(length(namelist[[1]])==2) {cleanname <- paste(math, substr(namelist[[1]][1],2,nchar(namelist[[1]][1])),"in",domain, sep="_")}
                if(length(namelist[[1]])==3) {cleanname <- paste(math, substr(namelist[[1]][1],2,nchar(namelist[[1]][1])),"in",domain, "along_axis", axis, sep="_")}
                newnames <- c(newnames, cleanname)     
        }
        
}


## write main data set
if(!file.exists("./data")){dir.create("./data")}
write.table(maindf, "./data/raw-UCI-HAR-data.txt", row.names = FALSE)


## create a second independent tidy data set with the averages of each variable 
## for each activity and each subject
seconddf <- maindf %>% group_by(subjectID, activity) %>% summarize_each(funs(mean(., na.rm=TRUE)))
write.table(seconddf, "./data/summary-UCI-HAR-data.txt", row.names = FALSE) 
}
        