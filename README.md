# gacd-project
Coursera Get and Cleaning Data Project

# Project description

The project uses the "Human Activity Recognition Using Smartphones" data set available here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Direct link to the data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original experiment consisted in recording measurement data from the gyroscope and accelerometers of mobile phones carried by subjets on their waist; the recordings were then processed to provide various kind of data. During the experiment, subjects were requested to perform various activities, like sitting, walking, standing etc...

The Coursera project consists in consolidating, tidying and selecting a subset of the data from the original dataset, and perform some operations on it.

# Script

The script performing the required operations is called [run_analysis.R](run_analysis.R), and can be found in this repository. It was developped and tested using R Studio 0.98.1102 and R 3.1.2 for windows.

Usage:

1. Put the script ([run_analysis.R](run_analysis.R)) in your working directory
2. Unzip the original data set in the same working directory. The files will be located in a subdirectory called "UCI HAR Dataset\".
3. Make sure you have dplyr package installed in your environment. If not, use the following command:

		install.packages("dplyr")

4. Run the script
5. Two files will be generated:

   * [tidy_means_per_activity_and_subject.txt](tidy_means_per_activity_and_subject.txt): contains the generated data set
   * [column_names.txt](column_names.txt): column names, not required for the project, provided for convenience.

# Codebook

The codebook is in the file named [Codebook.md](Codebook.md) in the Github repository.

