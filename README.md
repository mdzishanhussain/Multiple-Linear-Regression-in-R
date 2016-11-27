GETTING AND CLEANING DATA COURSE PROJECT

This README file explains how run_analysis works

1. First, unzip the data from the mentioned source https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip in the folder "data".
2. The folder "data" and the run_analysis.R script must both be in the current working directory. 
3. Next, use source("run_analysis.R") command in RStudio or in R.
4. Then, you will find two output files that get generated in the working directory:
5. merged_data.txt (around 7.9 Mb): it contains a data frame called cleanedData with 10299*68 dimension.
6. data_with_means.txt (220 Kb): it contains a data frame called result which is the required result.
7. At last, apply data <- read.table("data_with_means.txt") in RStudio to read the file. Since we are required to get the average of each    variable for each activity and each subject, and there are 6 activities in total and 30 subjects in total, we have 180 rows with all      combinations for each of the 66 features.
