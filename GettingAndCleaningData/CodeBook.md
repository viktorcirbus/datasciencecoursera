CodeBook file
=============
This file describes steps needed to produce two output files: "newdata.txt" and "submission.txt".  
The zip data for this project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* The run_analysis.R script performs the following steps to clean the data:   
 1. Read X_test.txt, y_test.txt and subject_test.txt from the "./UCI HAR Dataset/test" folder and store them in *dataset*, *datasetactivity* and *datasetsubject* variables respectively. 
 2. Concatenate *dataset* to *datasetactivity* to *datasetsubject* to generate a 2947x563 data frame, *dataset* 
 3. Read X_train.txt, y_train.txt and subject_train.txt from the "./UCI HAR Dataset/train" folder and store them in *temp_dataset*, *temp_datasetactivity* and *temp_datasetsubject* variables respectively. 
 4. Concatenate *dataset* to *temp_datasetactivity* to *temp_datasetsubject* to generate a 7352x563 data frame, *temp_dataset*  
 5. Concatenate *dataset* to *temp_dataset* to generate a 10299x563 data frame, *dataset* 
 6. Read the features.txt file from the "/UCI HAR Dataset" folder and store the data in a variable called *datasetcolumnlabels*. We only extract the measurements on the mean and standard deviation. This results in a 66 indices list. We get a subset of *dataset* with the 66 corresponding columns in *meanandstd*.  
 7. Read the activity_labels.txt file from the "./UCI HAR Dataset"" folder and store the data in a variable called *activity_labels*.  
 8. Transform the values of *dataset* according to the *activity_labels* data frame.  
 9. Combine the *subject*, *activity* columns and *meanandstd* by column to get a new cleaned 10299x68 data frame, *newdata*. Properly name the first two columns, "subject" and "activity". The "subject" column contains integers that range from 1 to 30 inclusive; the "activity" column contains 6 kinds of activity names; the last 66 columns contain measurements that range from -1 to 1 exclusive.  
 10. Write the *newdata* out to "newdata.txt" file in current working directory.  
 11. Finally, generate a second independent tidy data set first by melting the *newdata* data set by subject and activity and then by applying dcast function to calculate mean values of subject and activity combination.
 12. Write the *final* out to "submission.txt" file in current working directory. 
 
