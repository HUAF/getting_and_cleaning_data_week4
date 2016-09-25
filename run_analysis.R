## run_analysis.R

#load reshape2 library
library(reshape2)

# load needed data sets
## activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
## features
features <- read.table("UCI HAR Dataset/features.txt")
## subjects
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
## data files
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt")
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")

train_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")

### bind data by rows and delete unused variables
subjects <- rbind(test_subjects, train_subjects)
rm(test_subjects, train_subjects)

labels <-rbind(test_labels, train_labels)
rm(test_labels, train_labels)
named_labels <- merge(labels, activity_labels, by.x = "V1", by.y = "V1")
named_labels <- named_labels["V2"]
colnames(named_labels) <- c("activity_name")

data <- rbind(test_data, train_data)
rm(test_data, train_data)

## renanming col names before data final binding (AS ASKED)
colnames(subjects) <- c("subject_id")
colnames(labels) <- c("label_id")
colnames(data) <- features[, 2]

## bind the 3 data frames together

### full_data is the merge of the test set and the training set
full_data <- cbind(subjects, named_labels, data)
rm(subjects, labels, data)


# We will consider measurements on the mean to be the columns containing "mean" in their
# column name, measurements on the standard deviation the columns containing std in their
# column name.

### 2
# mean_std_measurements <- full_data[1, 2, grepl("(mean|std)", full_data)]
mean_std_vect <- grep("(mean|std)", colnames(full_data))

## mean_std_measurements is 
mean_std_measurements <- full_data[c(1, 2, mean_std_vect)] # get grep outside the vector

#melting the data
melted_dataset <- melt(mean_std_measurements, id = c("subject_id", "activity_name"), measure.vars = colnames(mean_std_measurements[3:81]))

final_dataset <- dcast(melted_dataset, subject_id + activity_name ~ variable, mean)

write.table(final_dataset, file = "./data_submission_file.txt", row.names = FALSE)

### removing unused variables
rm(activity_labels, features, melted_dataset, named_labels)
