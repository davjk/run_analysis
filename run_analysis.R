# Project file: Getting & Cleaning Data Course
# You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Read required data
x_test <- read.table("C:/Users/David/Desktop/coursera/ProjectData/UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("C:/Users/David/Desktop/coursera/ProjectData/UCI HAR Dataset/train/X_train.txt")
y_test <- read.table("C:/Users/David/Desktop/coursera/ProjectData/UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("C:/Users/David/Desktop/coursera/ProjectData/UCI HAR Dataset/train/y_train.txt")
activites <- read.table("C:/Users/David/Desktop/coursera/ProjectData/UCI HAR Dataset/activity_labels.txt")
vnames <- read.table("C:/Users/David/Desktop/coursera/ProjectData/UCI HAR Dataset/features.txt")
subject_train <- read.table("C:/Users/David/Desktop/coursera/ProjectData/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("C:/Users/David/Desktop/coursera/ProjectData/UCI HAR Dataset/test/subject_test.txt")

# set column names
colnames(subject_train) <- c("subject")
colnames(subject_test) <- c("subject")
colnames(y_train) <- c("activity_code")
colnames(y_test) <- c("activity_code")
colnames(activites) <- c("code", "activity")
colnames(x_test) <- as.vector(vnames[[2]])
colnames(x_train) <- as.vector(vnames[[2]])

# Merge activity code with description
y_test_labels <- merge(activites, y_test, by.x="code", by.y="activity_code")
y_train_labels <- merge(activites, y_train, by.x="code", by.y="activity_code")

# Remove code column
y_test_fin <- subset(y_test_labels, select = -c(code))
y_train_fin <- subset(y_train_labels, select = -c(code))

# Bind subject list with activities
subject_ytest <- cbind(subject_test, y_test_fin)
subject_ytrain <- cbind(subject_train, y_train_fin)

# Join subject & activities with data
new_test <- cbind(subject_ytest, x_test)
new_train <- cbind(subject_ytrain, x_train)

# Join test & training data
all <- rbind(new_test, new_train)

# Use grep to get standard deviation and mean columns
gstd <- grep("*[Ss]td*", as.character(colnames(all)))
gmean <- grep("*[Mm]ean*", as.character(colnames(all)))

# Combine mean and std colums and add to data
stdmean <- sort(c(1, 2, gstd, gmean))
allstdmean <- all[,stdmean]

# Load plyr library and use melt to create a narrower data frame
library(plyr)
melted <- melt(allstdmean, id.vars=c("subject", "activity"))

# Rename variable column
colnames(melted)[3] <- c("accelerometer")


# Use ddply to tidy the "melted" data & save the tidy data as a text file
tidy_data <-ddply(melted, c("subject", "activity", "accelerometer"), summarize,mean = mean(value))
write.table(tidy_data, "tidydata.txt", row.names = FALSE)
