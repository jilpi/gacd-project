
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
# Use make.names to avoid invalid characters and potential duplicates
names(X) <- make.names(names=features$V2, unique=TRUE, allow_ = FALSE)
names(subject) <- "subject"

# 2) Extracts only the measurements on the mean and standard deviation for each measurement
X <- select(X, contains("std"), contains("mean"))

# 3) Uses descriptive activity names to name the activities in the data set
for(i in 1:nrow(labels)){
  activity_num <- labels[i,1]
  activity_label <-labels[i,2]
  y[y == activity_num] <- activity_label
}

# Combine columns to form the tidy set
tidy_set <- tbl_dt(cbind(y, subject, X))

#-------------

# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_set_per_activity_and_subject <- group_by(tidy_set, activity, subject) %>%
  summarise_each(funs(mean), -activity, -subject)

write.table(tidy_set_per_activity_and_subject, "tidy_set_per_activity_and_subject.txt")
