# getting_and_cleaning_data_week4

## Packages needed
reshape2 is needed.
Please install it with the command below.
install.packages(reshape2)

## Running the script
run\_analysis.R should be in the same directory as the "UCI HAR Dataset" folder.
This directory should also be the working directory.

You can run the script using the command : source("run\_analysis.R")

The script will create a data\_submission\_file.txt in your working directory.
The R working directory will also contain 3 dataframes :
* full\_data (the merge of the test set and the train set)
* mean\_std\_measurements (a subset of "full\_data" that contains only mean and standard deviation columns)
* final\_dataset (the independent tidy data set)
