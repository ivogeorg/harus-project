# File: run_analysis.R
# Author: Ivo Georiev
# Date: 2015-04-26

# Please, see README.md for more information.

# Step 0: Check if dataset exists and, if not, download and unpack it
if (!file.exists("./data/UCI HAR Dataset")) {  
  if (!file.exists("./data")) {
    dir.create("./data")
  }
  
  samsungDataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  localFile <- "./data/samsung_data.zip"
  download.file(samsungDataURL, destfile=localFile, method="curl")
  unzip(localFile, exdir="./data")
}

# Step 1: Feature vector sets
# Step 1.1: Load and merge train and test feature vector sets
trainX <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
testX <- read.table("./data/UCI HAR Dataset/test/X_test.txt")

X <- rbind(trainX, testX)

# Step 1.2: Select only the features containing means and standard deviations
f <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = F)
featureColIndices <- grep("mean\\(\\)|std\\(\\)", f$V2)
meanAndStdX <- X[, featureColIndices]

# Step 1.3: Give descriptive names to the feature columns
names(meanAndStdX) <- f[featureColIndices, 2]

# Step 2: Activity labels
# Step 2.1: Load and merge train and test activity labels
trainy <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
testy <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

y <- rbind(trainy, testy)

# Step 2.2: Substitute descriptive activity labels for integer codes 
a <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
activityMatch <- merge(y, a, by.x="V1", by.y="V1")
readableY <- activityMatch[2]

# Step 2.3: Give a descriptive name to the activity column
names(readableY) <- "activity"

# Step 3: Subject identifiers
# Step 3.1: Load and merge train and test subject identifiers
trainSubj <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
testSubj <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

s <- rbind(trainSubj, testSubj)

# Step 3.2: Give a descriptive name to the subject column
names(s) <- "subject"

# Step 4: Merge all
# Step 4.1: Merge subjects, features, and activities in a single data set
allData <- cbind(s, meanAndStdX, readableY)

# Step 5: Create tidy dataset with feature averages per {activity, subject}
# Step 5.0: Require package 'reshape2'
print("run_analysis.R: Step 5 requires package 'reshape2'")
if (require("reshape2")) {
  print("run_analysis.R: Package 'reshape2' is loaded correctly")
} else {
  print("run_analysis.R: Trying to install package 'reshape2'")
  install.packages("reshape2")
  if (require("reshape2")) {
    print("run_analysis.R: Package 'reshape2' installed and loaded")
  } else {
    stop("run_analysis.R: ERROR: Could not install package 'reshape2")
  }
}

# Step 5.1: Melt and recast dataset to get the averages across all features
allMelt <- melt(allData, id=c("activity", "subject")) 
subjActyAvg <- dcast(allMelt, activity + subject ~ variable, mean)

# Step 5.2: Rename feature column names
labelAvg <- function(x) { paste(x, "-AVG", sep="")}
names(subjActyAvg)[3:length(subjActyAvg)] <- sapply(f[featureColIndices, 2], labelAvg, USE.NAMES=F)

# Step 6: Write out the new dataset to a file
write.table(subjActyAvg, file="./data/subj_acty_avg.txt", row.names=F)

