The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

This repo contains:

   * Codebook.md – codebook with additional info about variables in datasets
   * run_Analysis.R – main script for cleaning datasets & create tidy data.

The run_analysis.R script should

    * Merge the training and the test sets to create one data set.
    * Extracts only the measurements on the mean and standard deviation for each measurement. 
    * Uses descriptive activity names to name the activities in the data set
    * Appropriately labels the data set with descriptive variable names. 
    * Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

As only data for mean and standard deviation were requires i chose to use the grep function to extract columns with mean and std in their name. 

As data was tidied and not created I chose not to rename variables from the original, which I found adequately descriptive.

Since the tidy data was required to be saved in a txt file I chose to use melt and ddply to create a narrow data frame, which I find to tidier than wide data when viewed in programs such as notepad.

