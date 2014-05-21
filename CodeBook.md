# Code Book

## Original Data

It is assumed that the UCI HAR Dataset folder has been extracted and that it resides in the working directory. The original data can be downloaded from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A description of the experiment as well as other useful notes can be found in the ‘README.txt’ file.

The relevant files in the UCI HAR Data Set folder are (descriptions copied from the ‘README.txt’ file in said folder):

* 'features.txt': List of all features
* 'activity_labels.txt': Links the class labels with their activity name
* 'train/X_train.txt': Training set
* 'train/y_train.txt': Training labels
* 'test/X_test.txt': Test set
* 'test/y_test.txt': Test labels
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample
* 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample

The original 561 variables collected in the study are fully listed in 'features.txt' and are explained in 'features_info.txt' and so I will not repeat them here. I will provide only the variables that made it into the final two tidy data sets in the 'Variables' section below.

## Procedures and Transformations

* Each of the above files was loaded into its own data frame (respectively: 'features', 'activityLabels', 'xTrain', 'yTrain', 'xTest', 'yTest', 'subjectTrain', and 'subjectTest')
* 'subjectTrain', 'yTrain', and 'xTrain' were stacked column-wise in a data frame called 'train'
* 'subjectTest', 'yTest', and 'yTrain' were stacked column-wise in a data frame called 'test'
* 'train' and 'test' were stacked row-wise in a data frame called 'complete'
* Columns 1 and 2 of 'complete' were renamed 'subject' and 'activity' while the names for the rest of the 561 variables were taken from 'features'
* The 'subject' and 'activity' variables as well as any variables containing the string "mean()" or "std()" (which refer to mean and standard deviation functions applied on a set of 33 key measurements listed in 'features_info.txt') were copied to a new data frame called 'meansStds' (see the 'Summary Choices' section below on why only these variables were selected) containing 10,299 rows and 68 columns
* Variables erroneously including the string "BodyBody" were corrected to include only one "Body"
* Original variable names were also altered as follows:
  * Hyphens ("-") were replaced by dots (".")
  * Parentheses ("(" and ")") were removed
* No other alterations were made to variable names (see 'Summary Choices' section)
* Numerical values of the 'activity' variable were replaced with corresponding descriptive English labels as given in 'activityLabels'
* The 'subject' variable values were recoded from integer to factor
* Data frame 'subjActMeans' was created by averaging the values of each of the latter 66 variables for each subject-activity pair
* 'subjActMeans' was exported as a tab-separated text file called 'tidyData.txt'

## Final Variables

Below is a list of 68 variables that are present in the data frames 'meansStds' and 'subjActMeans':

1. subject: experimental subject identifier
  * factor with 30 levels: “1”, “2”, “3”, ..., “30” 
2. activity: activity labels
  * factor with 6 levels: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"
3.	tBodyAcc.mean.X
4.	tBodyAcc.mean.Y
5.	tBodyAcc.mean.Z      
6.	tBodyAcc.std.X
7.	tBodyAcc.std.Y
8.	tBodyAcc.std.Z
9.	tGravityAcc.mean.X
10.	tGravityAcc.mean.Y   
11.	tGravityAcc.mean.Z
12.	tGravityAcc.std.Xt
13.	GravityAcc.std.Y
14.	tGravityAcc.std.Z
15.	tBodyAccJerk.mean.X  
16.	tBodyAccJerk.mean.Y
17.	tBodyAccJerk.mean.Z
18.	tBodyAccJerk.std.X
19.	tBodyAccJerk.std.Y
20.	tBodyAccJerk.std.Z   
21.	tBodyGyro.mean.X
22.	tBodyGyro.mean.Y
23.	tBodyGyro.mean.Z
24.	tBodyGyro.std.X
25.	tBodyGyro.std.Y      
26.	tBodyGyro.std.Z
27.	tBodyGyroJerk.mean.X
28.	tBodyGyroJerk.mean.Y
29.	tBodyGyroJerk.mean.Z
30.	tBodyGyroJerk.std.X  
31.	tBodyGyroJerk.std.Y
32.	tBodyGyroJerk.std.Z
33.	tBodyAccMag.mean
34.	tBodyAccMag.std
35.	tGravityAccMag.mean  
36.	tGravityAccMag.std
37.	tBodyAccJerkMag.mean
38.	tBodyAccJerkMag.std
39.	tBodyGyroMag.mean
40.	tBodyGyroMag.std     
41.	tBodyGyroJerkMag.mean
42.	tBodyGyroJerkMag.std
43.	fBodyAcc.mean.X
44.	fBodyAcc.mean.Y
45.	fBodyAcc.mean.Z      
46.	fBodyAcc.std.X
47.	fBodyAcc.std.Y
48.	fBodyAcc.std.Z
49.	fBodyAccJerk.mean.X
50.	fBodyAccJerk.mean.Y  
51.	fBodyAccJerk.mean.Z
52.	fBodyAccJerk.std.X
53.	fBodyAccJerk.std.Y
54.	fBodyAccJerk.std.Z
55.	fBodyGyro.mean.X     
56.	fBodyGyro.mean.Y
57.	fBodyGyro.mean.Z
58.	fBodyGyro.std.X
59.	fBodyGyro.std.Y
60.	fBodyGyro.std.Z      
61.	fBodyAccMag.mean
62.	fBodyAccMag.std
63.	fBodyAccJerkMag.mean
64.	fBodyAccJerkMag.std
65.	fBodyGyroMag.mean    
66.	fBodyGyroMag.std
67.	fBodyGyroJerkMag.mean
68.	fBodyGyroJerkMag.std

where:
*	t ≡ time
*	f ≡ frequency domain
*	Acc ≡ acceleration
*	Gyro ≡ gyroscope
*	Mag ≡ magnitude
*	std ≡ standard deviation
*	'-XYZ' is used to denote 3-axial signals in the X, Y, and Z directions
*	Jerk, Body, mean are unabbreviated

Variables 3-68 are numerical values ranging from -1 to 1. For more explanation, refer to study page and original data.

## Summary Choices

### Variable Selection

The project specification asks for "measurements on the mean and standard deviation for each measurement." 'features.txt' contains 56 variables that contain the string '[Mm]ean' and 33 variables that contain 'std'. Upon further exploration of 'features_info.txt', of the 56 variables that contain '[Mm]ean', only 33 come directly from the accelerometer and gyroscope features. Other measurements are derived from these original features, but do not come from applying mean() or std() functions. It also seemed appropriate that the number of mean variables and the number of standard deviation variables match.

### Variable Naming

'subject' and 'activity' are both descriptive and self-explanatory names for an experimental subject identifier and an activity label, respectively.

At first, the names of the other variables were loaded from the original data's 'features.txt' file.
* Hyphens and parentheses were removed as they do not properly process in R (clarity and convention also played a role)
* Dots replaced hyphens to separate feature name from measurement type (mean, std) and measurement type from the X, Y, or Z direction identifier (where available)
* Variable names could have been made slightly more descriptive by replacing abbreviated parts of the variable with their unabbreviated counterparts, but that would have made variable names even longer than they were originally, which would have been a nuisance when viewing or summarizing the data
* camelCase was kept in place of making the variable name lower-case for readability of the different name components
