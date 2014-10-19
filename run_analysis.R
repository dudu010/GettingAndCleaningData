# Coursera - Getting and Cleaning Data - Course Project
# October 2014

# Zip file with datasets downloaded from the following location
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Zip file must be expanded into the R Working Directory

# Files: X holds the measures, y holds the activities, and subject holds subjects

# Reading test files
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"")

# Reading train files
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"")

# STEP 1
# Appending test and train datasets
subject <- rbind(subject_test, subject_train)
y <- rbind(y_test, y_train)
TT <- rbind(X_test, X_train)

# Adding subject and y (activity) to TT (adding columns 562 and 563)
TT$V562 <- subject$V1
TT$V563 <- y$V1


# Loading dplyr library to easily manipulate datasets
library(dplyr)

# Loading TT data frame to a tbl_df then removing TT
DS <- tbl_df(TT)
rm("TT")

# STEP 2
# Extracting only measurements on the mean and 
# standard deviation for each measurement (from DS to newDS)
newDS <-
        DS %>%
        select(V1,V2,V3,V4,V5,V6, 
               V41,V42,V43,V44,V45,V46,
               V81,V82,V83,V84,V85,V86,
               V121,V122,V123,V124,V125,V126,
               V161,V162,V163,V164,V165,V166,
               V201,V202,
               V214,V215,
               V227,V228,
               V240,V241,
               V253,V254,
               V266,V267,V268,V269,V270,V271,
               V345,V346,V347,V348,V349,V350,
               V424,V425,V426,V427,V428,V429,
               V503,V504,
               V516,V517,
               V529,V530,
               V542,V543,
               V562,V563) 

# STEP 3                
# Using descriptive activity names to name the activities in the data set
newDS$V563 <- factor(newDS$V563,
                     levels = c(1,2,3,4,5,6),
                     labels = c("Walking", "Walking_Upstairs", 
                                "Walking_Downstairs","Sitting",
                                "Standing","Laying")) 

# STEP 4
# Assigning labels to the dataset (descriptive variable names from features.txt) 
colnames(newDS) <- c("tBodyAcc_mean_X",
                     "tBodyAcc_mean_Y",
                     "tBodyAcc_mean_Z",
                     "tBodyAcc_std_X",
                     "tBodyAcc_std_Y",
                     "tBodyAcc_std_Z",
                     "tGravityAcc_mean_X",
                     "tGravityAcc_mean_Y",
                     "tGravityAcc_mean_Z",
                     "tGravityAcc_std_X",
                     "tGravityAcc_std_Y",
                     "tGravityAcc_std_Z",
                     "tBodyAccJerk_mean_X",
                     "tBodyAccJerk_mean_Y",
                     "tBodyAccJerk_mean_Z",
                     "tBodyAccJerk_std_X",
                     "tBodyAccJerk_std_Y",
                     "tBodyAccJerk_std_Z",
                     "tBodyGyro_mean_X",
                     "tBodyGyro_mean_Y",
                     "tBodyGyro_mean_Z",
                     "tBodyGyro_std_X",
                     "tBodyGyro_std_Y",
                     "tBodyGyro_std_Z",
                     "tBodyGyroJerk_mean_X",
                     "tBodyGyroJerk_mean_Y",
                     "tBodyGyroJerk_mean_Z",
                     "tBodyGyroJerk_std_X",
                     "tBodyGyroJerk_std_Y",
                     "tBodyGyroJerk_std_Z",
                     "tBodyAccMag_mean",
                     "tBodyAccMag_std",
                     "tGravityAccMag_mean",
                     "tGravityAccMag_std",
                     "tBodyAccJerkMag_mean",
                     "tBodyAccJerkMag_std",               
                     "tBodyGyroMag_mean",
                     "tBodyGyroMag_std",              
                     "tBodyGyroJerkMag_mean",
                     "tBodyGyroJerkMag_std",               
                     "fBodyAcc_mean_X",
                     "fBodyAcc_mean_Y",
                     "fBodyAcc_mean_Z",
                     "fBodyAcc_std_X",
                     "fBodyAcc_std_Y",
                     "fBodyAcc_std_Z",
                     "fBodyAccJerk_mean_X",
                     "fBodyAccJerk_mean_Y",
                     "fBodyAccJerk_mean_Z",
                     "fBodyAccJerk_std_X",
                     "fBodyAccJerk_std_Y",
                     "fBodyAccJerk_std_Z",
                     "fBodyGyro_mean_X",
                     "fBodyGyro_mean_Y",
                     "fBodyGyro_mean_Z",
                     "fBodyGyro_std_X",
                     "fBodyGyro_std_Y",
                     "fBodyGyro_std_Z",             
                     "fBodyAccMag_mean",
                     "fBodyAccMag_std",               
                     "fBodyBodyAccJerkMag_mean",
                     "fBodyBodyAccJerkMag_std",
                     "fBodyBodyGyroMag_mean",
                     "fBodyBodyGyroMag_std",
                     "fBodyBodyGyroJerkMag_mean",
                     "fBodyBodyGyroJerkMag_std",               
                     "subject",       
                     "activity")            

# STEP 5
# Creating a tidy data set with the average of each variable for each activity and each subject

# Grouping newDS by subject and activity, summarinzing the means and 
# assigning all to result

result <-
        newDS %>%
        group_by(subject, activity) %>%
        summarize(mean(tBodyAcc_mean_X),
                  mean(tBodyAcc_mean_Y),
                  mean(tBodyAcc_mean_Z),
                  mean(tBodyAcc_std_X),
                  mean(tBodyAcc_std_Y),
                  mean(tBodyAcc_std_Z),
                  mean(tGravityAcc_mean_X),
                  mean(tGravityAcc_mean_Y),
                  mean(tGravityAcc_mean_Z),
                  mean(tGravityAcc_std_X),
                  mean(tGravityAcc_std_Y),
                  mean(tGravityAcc_std_Z),
                  mean(tBodyAccJerk_mean_X),
                  mean(tBodyAccJerk_mean_Y),
                  mean(tBodyAccJerk_mean_Z),
                  mean(tBodyAccJerk_std_X),
                  mean(tBodyAccJerk_std_Y),
                  mean(tBodyAccJerk_std_Z),
                  mean(tBodyGyro_mean_X),
                  mean(tBodyGyro_mean_Y),
                  mean(tBodyGyro_mean_Z),
                  mean(tBodyGyro_std_X),
                  mean(tBodyGyro_std_Y),
                  mean(tBodyGyro_std_Z),
                  mean(tBodyGyroJerk_mean_X),
                  mean(tBodyGyroJerk_mean_Y),
                  mean(tBodyGyroJerk_mean_Z),
                  mean(tBodyGyroJerk_std_X),
                  mean(tBodyGyroJerk_std_Y),
                  mean(tBodyGyroJerk_std_Z),
                  mean(tBodyAccMag_mean),
                  mean(tBodyAccMag_std),
                  mean(tGravityAccMag_mean),
                  mean(tGravityAccMag_std),
                  mean(tBodyAccJerkMag_mean),
                  mean(tBodyAccJerkMag_std),               
                  mean(tBodyGyroMag_mean),
                  mean(tBodyGyroMag_std),              
                  mean(tBodyGyroJerkMag_mean),
                  mean(tBodyGyroJerkMag_std),               
                  mean(fBodyAcc_mean_X),
                  mean(fBodyAcc_mean_Y),
                  mean(fBodyAcc_mean_Z),
                  mean(fBodyAcc_std_X),
                  mean(fBodyAcc_std_Y),
                  mean(fBodyAcc_std_Z),
                  mean(fBodyAccJerk_mean_X),
                  mean(fBodyAccJerk_mean_Y),
                  mean(fBodyAccJerk_mean_Z),
                  mean(fBodyAccJerk_std_X),
                  mean(fBodyAccJerk_std_Y),
                  mean(fBodyAccJerk_std_Z),
                  mean(fBodyGyro_mean_X),
                  mean(fBodyGyro_mean_Y),
                  mean(fBodyGyro_mean_Z),
                  mean(fBodyGyro_std_X),
                  mean(fBodyGyro_std_Y),
                  mean(fBodyGyro_std_Z),             
                  mean(fBodyAccMag_mean),
                  mean(fBodyAccMag_std),               
                  mean(fBodyBodyAccJerkMag_mean),
                  mean(fBodyBodyAccJerkMag_std),
                  mean(fBodyBodyGyroMag_mean),
                  mean(fBodyBodyGyroMag_std),
                  mean(fBodyBodyGyroJerkMag_mean),
                  mean(fBodyBodyGyroJerkMag_std)                 
        )

# Creating file "result.txt" with the results
write.table(result, file = "result.txt", row.names = FALSE)

