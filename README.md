---
output:
  html_document: default
  pdf_document: default
---
# GettingCleaningProject
Repository for the Getting and Cleaning course project

# Instructions
There is only one script that is used for this project.  The file is GettingCleaningProject.R.  On a high level this
script will perform the following actions:

  * If the zip file does not exist locally, down load the zip file.
  * Extract the zip file if the directory structure does not exists.
  * Create two data sets that are completely merged with the headers, subjects, and activities.  These datasets are for training and test data.  Only the variables for mean() and std() will be retained.
  * Merge the two datasets from previous.
  * Perform the group_by for subject and activity name.
  * Perform the summary of mean() across all variables associated to the group_by.
  * Produce a csv file that can be used to review with any tool. 

Simply by executing GettingCleaningProject.R, the user will get the required output.  The dataset allDF is retained which is the final dataset used to create the csv file.  This allows for further exploration if needed.


