## This script loads disparate files from the UCI HAR Dataset and merges them
## to create one data set. It then extracts the mean and standard deviation
## variables for each of the 33 measurements listed in the original
## features_info.txt file. After some cleaning and re-labeling, a data set
## giving the mean of each variable for each subject-activity pair.

## It is assumed that the UCI HAR Dataset folder has been extracted and that
## it resides in the working directory

## Each relevant file is loaded into its own data frame
activityLabels <- read.table(paste0(getwd(),"/UCI HAR Dataset/activity_labels.txt"))
features <- read.table(paste0(getwd(),"/UCI HAR Dataset/features.txt"))
subjectTrain <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/subject_train.txt"))
xTrain <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/X_train.txt"))
yTrain <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/y_train.txt"))
subjectTest <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/subject_test.txt"))
xTest <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/X_test.txt"))
yTest <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/y_test.txt"))

## The subject and activity columns are appended to the corresponding (training
## or test) data set and then the training and test are stacked row-wise to form
## one complete data set
train <- cbind(subjectTrain,yTrain,xTrain)
test <- cbind(subjectTest,yTest,xTest)
complete <- rbind(train,test)

## Variables are labeled appropriately. The latter 561 are taken from features.txt.
colnames(complete)[1:2] = c("subject","activity")
colnames(complete)[3:563] = as.character(features[,2])

## Only the mean and standard deviation variables for each of 33 original measurements
## are included. Additional derived measurements are excluded as they involve extra
## transformations.
meansStds <- complete[, grep("subject|activity|mean\\(\\)|std\\(\\)", colnames(complete))]

## Mislabled measurements are fixed, i.e. "BodyBody" is replaced with "Body"
colnames(meansStds) <- gsub("BodyBody","Body",colnames(meansStds))

## Variables names are cleaned up for clarity and convention
## Variables names are not altered further as they are descriptive enough
## Additional alterations would make variable names too long or too hars to read
## (See Codebook for an explanation of each variable)
colnames(meansStds) <- gsub("-",".",colnames(meansStds))
colnames(meansStds) <- gsub("\\(\\)","",colnames(meansStds))

## Activity values are replaced with activity labels as in activity_labels.txt
## and the subject variable is recoded as a factor
meansStds$activity <- activityLabels$V2[match(meansStds$activity, activityLabels$V1)]
meansStds$subject <- as.factor(meansStds$subject)

## The mean of each of 66 measurements is provided for each of 180 subject-activity pairs
subjActMeans <- aggregate(meansStds[,3:68], meansStds[,1:2], mean)

## The above data set is exported as a tab-separated .txt file to the working directory
write.table(subjActMeans, paste0(getwd(),"/tidyData.txt"), sep="\t")