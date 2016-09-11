## run_analysis.R


zip_file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## create a "data" folder if it doesn't exist yet
if (!file.exists("./data")) {
    dir.create("./data")
}

## download the data zip file in the "data" folder
download.file(zip_file_url, destfile = "./data/Dataset.zip")

unzip("./data/Dataset.zip")