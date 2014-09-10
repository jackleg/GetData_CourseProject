# read metadata - feature and activity labels
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
names(features) <- c("code", "name")
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
names(activityLabels) <- c("code", "name")

# Step 1. Merges the training and the test sets to create one data set.
# read train data and set names
XTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
names(XTrain) <- features$name

# attach subject and y value to train data
YTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
XTrain$subject <- subjectTrain$V1
XTrain$y <- YTrain$V1

# read test data and set names
XTest <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
names(XTest) <- features$name

# attach subject and y value to test data
YTest <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
XTest$subject <- subjectTest$V1
XTest$y <- YTest$V1

# merge train & test data
trainLength = length(XTrain$y)
rownames(XTrain) <- seq(1, trainLength)
rownames(XTest)  <- seq(trainLength+1, along.with = XTest$y)
allData <- rbind(XTrain, XTest)

# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# mean and std names
meanStdNames <- as.character(features$name[grep("mean\\(\\)|std\\(\\)", features$name)])
selectedNames <- c(meanStdNames, "y", "subject")
meanStdData <- allData[selectedNames]

# Step 3. Uses descriptive activity names to name the activities in the data set
# merge data with activity names
mergedActivity <- merge(meanStdData, activityLabels, by.x="y", by.y="code")

# Step 4. Appropriately labels the data set with descriptive variable names.
# make name
mergedActivityNames <- names(mergedActivity)
mergedActivityNames[1]  = "ActivityCode"
mergedActivityNames[68] = "SubjectId"
mergedActivityNames[69] = "ActivityName"
mergedActivityNames <- sub("-mean\\(\\)-|-mean\\(\\)", "Mean", mergedActivityNames)
mergedActivityNames <- sub("-std\\(\\)-|-std\\(\\)", "Std", mergedActivityNames)
names(mergedActivity) <- mergedActivityNames

# Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# average of each variables
resultDf <- ddply(mergedActivity[1:68], .(ActivityCode, SubjectId), colMeans)

resultDf