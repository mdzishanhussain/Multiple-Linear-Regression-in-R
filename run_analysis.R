# 1. Merges the training and the test sets to create one data set.
# downloading datafile
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile = "./project/analysis.zip")
traindata <- read.table("./project/analysis/train/x_train.txt")
trainlabel <- read.table("./project/analysis/train/y_train.txt")
trainsubject <- read.table("./project/analysis/train/subject_train.txt")
testdata <- read.table("./project/analysis/test/x_test.txt")
testlabel <- read.table("./project/analysis/test/y_test.txt")
testsubject <- read.table("./project/analysis/test/subject_test.txt")

dim(traindata) # 7352*561
dim(testdata) # 2947*561

head(traindata)
head(testdata)

table(trainlabel)
table(testlabel)

#merging

joindata <- rbind(traindata,testdata)
joinlabel <- rbind(trainlabel,testlabel)
joinsubject <- rbind(trainsubject,testsubject)

#dimensions

dim(joindata) # 10299*561
dim(joinlabel) # 10299*1
dim(joinsubject) # 10299*1

# 2. Extracts only the measurements on the mean and standard 
#   deviation for each measurement.

features <- read.table("./project/analysis/features.txt")
dim(features)
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices) # 66
joindata <- joindata[, meanStdIndices]
dim(joindata) # 10299*66
names(joindata) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joindata) <- gsub("mean", "Mean", names(joindata)) # capitalize M
names(joindata) <- gsub("std", "Std", names(joindata)) # capitalize S
names(joindata) <- gsub("-", "", names(joindata)) # remove "-" in column names

# 3. Uses descriptive activity names to name the activities in 
#    the data set
activity <- read.table("./project/analysis/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activitylabel <- activity[joinlabel[, 1], 2]
joinlabel[, 1] <- activitylabel
names(joinlabel) <- "activity"

# 4. Appropriately labels the data set with descriptive activity 
#    names. 
names(joinsubject) <- "subject"
cleaneddata <- cbind(joinsubject, joinlabel, joindata)
dim(cleaneddata) # 10299*68
write.table(cleaneddata, "merged_data.txt") # write out the 1st dataset

# 5. Creates a second, independent tidy data set with the average of 
#    each variable for each activity and each subject. 
subjectlen <- length(table(joinsubject)) # 30
activitylen <- dim(activity)[1] # 6
columnlen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectlen*activitylen, ncol=columnlen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleaneddata)
row <- 1
for(i in 1:subjectlen) {
  for(j in 1:activitylen) {
    result[row, 1] <- sort(unique(joinsubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cleaneddata$subject
    bool2 <- activity[j, 2] == cleaneddata$activity
    result[row, 3:columnLen] <- colMeans(cleaneddata[bool1&bool2, 3:columnlen])
    row <- row + 1
  }
}
head(result)
write.table(result, "./project/tidy.txt") # write out the 2nd dataset