## Producing a Tidy Data Set Using UCI HAR Data

The goal of this project is to process and clean data from an experimental study called "Human Activity Recognition Using Smartphones" performed by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto of the Università degli Studi di Genova in Italy. The final output is a tidy data set providing the average of selected measurements for each subject-activity pair in the study.

A full description of the study can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The original data can be downloaded from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

This repo contains four files:

1. README.md: this file

2. CodeBook.md: a markdown file describing the raw data, procedures and transformations performed, and final variables

3. subjActMeans.txt: a text file containing the tidy data set which is the output of the R script below

4. run_analysis.R: an R script, performing the following steps:
  * Loads each of the relevant files in the UCI HAR Dataset folder in the working directory into its own data frame in R
  * Merges the data frames appropriately into one data set:
    * The training data frames (subject, activity, and main data set) are combined column-wise
    * The test data frames (subject, activity, and main data set) are combined column-wise
    * The complete training data frame and the complete test data frame are stacked row-wise
  * Labels the variables (columns) appropriately (as given by a file in the original data set)
  * Creates a new data frame with only mean and standard deviation variables for each of 33 selected measurements (see CodeBook.md for an explanation on how those were selected)
  * Re-labels incorrectly labeled variables
  * Renames remaining variables for clarity and convention
  * Replaces the numeric values in the activity variable with corresponding descriptive English labels
  * Creates an independent tidy data set with the averages of each measurement variable for each subject-activity pair
  * Write above file to a tab-separated text file

For a more thorough explanation of the steps above, please read the run_analysis.R script and CodeBook.md.
