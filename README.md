This README file explains how run_analysis works

First, unzip the data from the mentioned source https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip in the folder "data".
The folder "data" and the run_analysis.R script must both be in the current working directory.
Next, use source("run_analysis.R") command in RStudio or in R.
Then, you will find two output files that get generated in the working directory:
merged_data.txt (around 7.9 Mb): it contains a data frame called cleanedData with 10299*68 dimension.
data_with_means.txt (220 Kb): it contains a data frame called result which is the required result.
At last, apply data <- read.table("data_with_means.txt") in RStudio to read the file. Since we are required to get the average of each variable for each activity and each subject, and there are 6 activities in total and 30 subjects in total, we have 180 rows with all combinations for each of the 66 features.