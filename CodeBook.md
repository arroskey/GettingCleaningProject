# Getting and Cleaning Project Codebook
This codebook describes the following in this order:

  1. Original data and how obtained
  2. Transformations performed by the GettingCleaningProject.R script
  3. Variable descriptions
  
## Original Data

The original data is pulled from 
[project data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
and extracted into the current working directory.  If the data is already in place, this process will not be executed.

The original dataset is contained in multiple files.  These files are: 


  - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
  - 'features.txt': List of all features.
  - 'activity_labels.txt': Links the class labels with their activity name.
  - 'train/X_train.txt': Training set.
  - 'train/y_train.txt': Training labels.
  - 'test/X_test.txt': Test set.
  - 'test/y_test.txt': Test labels.

The orignal dataset contained 561 variables which include the raw measurements for each activity and then the associated summary variables such as mean() and std().  

For this project only the mean() and std() variables are retained.  All other variables are eliminated.  This reduces the dataset to 20 variables.

## Transformations

### Step 1
The first step is to obtain the data to be processed.  The following describes this step
The following steps were performed on the test and train datasets:
  - If the data already exists, then go to step 2
  - Download the .zip file from the internet
  - unzip the data into the current working directory.  The original directory structure is maintained.

### Step 2
The following describes the process that is performed on both the training and testing datasets that are described in **Original Data**.

  - Read all the datafiles previsouly described into their own dataframes.
  - Apply the variable names to the dataframes as they are created
  - Apply the descriptive names to the observations
  - Select the mean() and std() variables from the original dataset eliminating all other variables.
  - Sort the variables to get the assoicated mean() and std() together in the table for human readability
  - Bind the activities that are associated to the observations using cbind
  - Bind the subjects that are associted to the observations using cbind
  - Merge the activity names to the observations using the activity code as the merging variable
  - Perform a select to force the subject and activity name variable to the first two columns for readability
  - Drop the activity category as this is redundandant to the activity name
  
### Step 3
The following steps conclude the transformation once the test and train datasets are created.

  - Use rbind to combine the training and testing datasets into an all dataset
  - Perform a group_by for subject and activity name
  - Perform a summarise_all for mean() on all variables that produces the reduced dataset orderered by subject and activity name
  - Use write.csv to create a file that is easily consumed by the reader with Excel or other products to review the data

## Variable descriptions
The following variables are in the file produced by the above transformations:

  - Subject: The subject who recorded the observation
  - ActivityName: The activity associated to the observation
  
  The following are the averages associated to each of the original variables.  These values were produced by using the summarise_all with the mean() function.  These values are associated for each subject and activity.  There are 30 subjects and 6 activities for each subject.
  
  - fBodyAccMag-mean()
  - fBodyAccMag-std()
  - fBodyBodyAccJerkMag-mean()
  - fBodyBodyAccJerkMag-std()
  - fBodyBodyGyroJerkMag-mean()
  - fBodyBodyGyroJerkMag-std()
  - fBodyBodyGyroMag-mean()
  - fBodyBodyGyroMag-std()
  - tBodyAccJerkMag-mean()
  - tBodyAccJerkMag-std()
  - tBodyAccMag-mean()
  - tBodyAccMag-std()
  - tBodyGyroJerkMag-mean()
  - tBodyGyroJerkMag-std()
  - tBodyGyroMag-mean()
  - tBodyGyroMag-std()
  - tGravityAccMag-mean()
  - tGravityAccMag-std()

