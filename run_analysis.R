

# Task 1. Merges the training and the test sets to create one data set.

train <- read.table("train/X_train.txt")
test <- read.table("test/X_test.txt")
X <- rbind(train, test)

train <- read.table("train/subject_train.txt")
test <- read.table("test/subject_test.txt")
Z <- rbind(train, test)

train <- read.table("train/y_train.txt")
test <- read.table("test/y_test.txt")
Y <- rbind(train, test)

# Task 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
meanStdIndices <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, meanStdIndices]
names(X) <- features[meanStdIndices, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# Task 3. Uses descriptive activity names to name the activities in the data set

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# Task 4. Appropriately labels the data set with descriptive variable names.

names(Z) <- "subject"
cleaned <- cbind(Z, Y, X)
write.table(cleaned, "merged_data.txt")

# Task 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubs = unique(Z)[,1]
numSubs = length(unique(Z)[,1])
numActs = length(activities[,1])
numCols = dim(cleaned)[2]
res = cleaned[1:(numSubs*numActs), ]

row = 1
for (s in 1:numSubs) {
  for (a in 1:numActs) {
    res[row, 1] = uniqueSubs[s]
    res[row, 2] = activities[a, 2]
    tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
    res[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(res, "data_with_means.txt")
