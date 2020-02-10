url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("/Users/stephenyang/Downloads/UCI\ HAR\ Dataset.zip")){
        download.file(url, "/Users/stephenyang/Downloads/UCI\ HAR\ Dataset.zip", mode = "wb")
        unzip("/Users/stephenyang/Downloads/UCI\ HAR\ Dataset.zip", exdir = getwd())
}
UCIHARfeatures <- read.table('./UCI\ HAR\ Dataset/features.txt', header = FALSE, col.names = c("n", "functions"))
UCIHARactivity <- read.table('./UCI\ HAR\ Dataset/activity_labels.txt', header = FALSE, col.names = c("labels", "activity"))

#Train sets
X_train <- read.table('./UCI\ HAR\ Dataset/train/X_train.txt', col.names = UCIHARfeatures$functions)
Y_train <- read.table('./UCI\ HAR\ Dataset/train/y_train.txt', header = FALSE, col.names = c("labels"))
subject_train <- read.table('./UCI\ HAR\ Dataset/train/subject_train.txt',header = FALSE, col.names = c("subject"))
#Test sets
X_test <- read.table('./UCI HAR Dataset/test/X_test.txt', col.names = UCIHARfeatures$functions)
Y_test <- read.table('./UCI HAR Dataset/test/y_test.txt', header = FALSE, col.names = c("labels"))
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, col.names = c("subject"))


#1. Merges the training and the test sets to create one data set.
X <- rbind(X_train, X_test)
Y <- rbind(Y_train, Y_test)
Subject <- rbind(subject_train, subject_test)
Dataset1 <- cbind(Subject, Y, X)
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std_measurement <- grep("mean()|std()", UCIHARfeatures[, 2])
Dataset2 <- Dataset1[, mean_std_measurement]
#3. Uses descriptive activity names to name the activities in the data set
Dataset2$labels <- UCIHARactivity[Dataset2$labels,2]
#4. Appropriately labels the data set with descriptive variable names.
#3. Uses descriptive activity names to name the activities in the data set
Dataset2$labels <- UCIHARactivity[Dataset2$labels,2]
#4. Appropriately labels the data set with descriptive variable names.
name.new <- names(Dataset2)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("BodyBody", "Body", name.new)
name.new <- gsub("[(][)]", "", name.new)
name.new <- gsub("^t", "Time", name.new)
name.new <- gsub("^f", "Frequency", name.new)
name.new <- gsub("-mean()", "Mean", name.new)
name.new <- gsub("-std()", "Standard Deviation", name.new)
name.new <- gsub("-mad()", "Median", name.new)
name.new <- gsub("-max()", "Largest Value", name.new)
name.new <- gsub("-min()", "Smallest Value", name.new)
name.new <- gsub("-sma()", "Signal Magnitude Area", name.new)
name.new <- gsub("-max()", "Largest Value", name.new)
name.new <- gsub("-energy()", "Energy", name.new)
name.new <- gsub("-iqr()", "Interquartile Range", name.new)
name.new <- gsub("-Freq()", "Frequency", name.new)
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Dataset2$subject <- as.factor(Dataset2$subject)
Dataset2 <- data.table(Dataset2)
Dataset3 <- aggregate(. ~subject + labels, Dataset2, mean)
Dataset3 <- Dataset3[order(Dataset3$subject,Dataset3$labels),]
write.table(Dataset3, file = "tidy.txt", row.names = FALSE)
           
