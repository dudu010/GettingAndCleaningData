---
title: "README.md"
output: html_document
---

This document describes the run_analysis.R script, all the steps it implements to reach its goal. The basic idea of this script is to process a set of source files producing a tidy data set as its output.

The source files can be downloaded from the following location:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This zip file must be expanded into the R Working Directory, so the script can find all the needed files to perform its operations. The files X holds the measures, y holds the activities, and subject holds subjects.

Prior to initiate, the script load the needed test and train files:
```{r}
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"")
```

The 1st Step is to combine the two data sets, test and train, in only one data set. This is done by the following code:
```{r}
# Appending test and train datasets
subject <- rbind(subject_test, subject_train)
y <- rbind(y_test, y_train)
TT <- rbind(X_test, X_train)

# Adding subject and y (activity) to TT (adding columns 562 and 563)
TT$V562 <- subject$V1
TT$V563 <- y$V1
```

Prior to perform the 2nd Step it is important to load the dblyr library and use the tbl_df function to easily manipulate the data set:
```{r}
# Loading dplyr library to easily manipulate datasets
library(dplyr)

# Loading TT data frame to a tbl_df then removing TT
DS <- tbl_df(TT)
rm("TT")
```

The 2nd Step extracts only measurements on the mean and standard deviation for each measurement. This code begins like the follow:
```{r}
newDS <-
        DS %>%
        select(V1,V2,V3,V4,V5,V6, 
```
Use the original R script file to see all code related to the 2nd Step.

The 3rd Step applies descriptive activity names to name the activities in the data set.
```{r}
newDS$V563 <- factor(newDS$V563,
                     levels = c(1,2,3,4,5,6),
                     labels = c("Walking", "Walking_Upstairs", 
                                "Walking_Downstairs","Sitting",
                                "Standing","Laying"))  
```

The 4th Step assigns labels to the dataset using the descriptive variable names from features.txt (the original file from the data sources containg the variable names). This piece of code begins like follow:
```{r}
colnames(newDS) <- c("tBodyAcc_mean_X",
                     "tBodyAcc_mean_Y",
                     "tBodyAcc_mean_Z",
                     "tBodyAcc_std_X",
                     "tBodyAcc_std_Y",  
```
Use the original R script file to see all code related to the 4th Step.

The final step, the 5th Step, creates a tidy data set with the average of each variable for each activity and each subject. This is done by grouping the original data set, newDS, by subject and activity, summarinzing the means and assigning all to result. The code begins like:
```{r}
result <-
        newDS %>%
        group_by(subject, activity) %>%
        summarize(mean(tBodyAcc_mean_X),
                  mean(tBodyAcc_mean_Y),
                  mean(tBodyAcc_mean_Z), 
```
Use the original R script file to see all code related to the 5th Step.

At the end, the script saves the result in a text file in the working directory.
```{r}
write.table(result, file = "result.txt", row.names = FALSE)
```

