#### IMPORTANT ####
# A. dplyr package must be installed on your system. Use the following command to install it if necessary:
#       install.packages("dplyr")
# B. I did not include the dataset to save your bandwidth.
#    Just in case, it can be downloaded here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#    The dataset must be unzipped in the _working directory_.
#    This will create a subfolder named "UCI HAR Dataset" containing all necessary files and subfolders.
#
#   working directory
#   +- UCI HAR Dataset
#       +- test
#         +- Intertial Signals
#         + subject_test.txt
#         + X_test.txt
#         + y_test.txt
#       +- train
#     ...etc...
#
# Don't forget to set the working directory using the setwd() command :-)
#
# Thanks for reviewing the project!
#
library(dplyr)

# Read test data
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Read train data
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Read descriptions of features and activity labels
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)


# 1) Merges the training and the test sets to create one data set.
y <- rbind(y_test, y_train)
X <- rbind(X_test, X_train)
subject <- rbind(subject_test, subject_train)

# 4) Appropriately labels the data set with descriptive variable names. 
names(y) <- "activity"
# Uses make.names to avoid invalid characters and duplicates
names(X) <- make.names(names=features$V2, unique=TRUE, allow_ = FALSE)

names(subject) <- "subject"

# 2) Extracts only the measurements on the mean and standard deviation for each measurement
X <- select(X, contains("std.."), contains("mean.."), -contains("angle"))

# Cleanup the names of the variables (removes double dots, and replace triple dots with an underscore)
names(X) <- names(X) %>%
  sub(pattern = "\\.\\.\\.", replacement = "_") %>%
  sub(pattern = "\\.\\.", replacement = "")
names(X) <- paste("mean(", names(X), ")", sep="")


# 3) Uses descriptive activity names to name the activities in the data set
# The descriptive activity names are stored in 'labels', along with the activity number.
# The loop goes through each activity in 'labels'...
for(i in 1:nrow(labels)){
  # ... extracts its number and name ...
  activity_num <- labels[i,1]
  activity_label <-labels[i,2]
  # ... and finally replaces the activity number by its name in 'y'.
  y[y == activity_num] <- activity_label
}

# Combine columns to form the tidy set
tidy_set <- tbl_dt(cbind(y, subject, X))

#-------------

# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_means_per_activity_and_subject <- group_by(tidy_set, activity, subject) %>%
  summarise_each(funs(mean), -activity, -subject)


# write results in the working directory:
write.table(tidy_means_per_activity_and_subject, "tidy_means_per_activity_and_subject.txt", row.names = FALSE, col.names = TRUE)
write.table(names(tidy_means_per_activity_and_subject), "column_names.txt", row.names=FALSE, col.names = FALSE, quote = FALSE)
