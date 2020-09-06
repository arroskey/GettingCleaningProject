## Load the necessary libraries
library(dplyr)

## If datafiles do not exits download .zip file and extract
if ( !dir.exists("UCI HAR Dataset") ) {
  if (!file.exists("project.zip") ) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","project.zip")
  }
  unzip(zipfile="project.zip", exdir=".")
}

## Arguments
##  ds: The dataset which to build, either train or test
##
## Summary
##  This function will combine all the pieces for the dataset into one dataframe
##  and return that dataframe for the specified data by ds

buildDF <- function(ds) {
  filePath <- "./UCI HAR Dataset"
  
  ## Read all the components that need to be combined to form the final data set
  obsFile <- paste(filePath, "/", ds, "/X_", ds, ".txt", sep="")
  observations <- read.table(obsFile)
  
  labelsFile <- paste(filePath, "/features.txt", sep="")
  labs <- read.table(labelsFile)
  
  activitiesFile <- paste(filePath, "/", ds, "/Y_", ds, ".txt", sep="")
  activities <- read.table(activitiesFile)
  names(activities) <- c("ActivityCategory")

  subjectsFile <- paste(filePath, "/", ds, "/subject_", ds, ".txt", sep="")
  subjects <- read.table(subjectsFile)
  names(subjects) <- c("Subject")
  
  activityLabsFile <- paste(filePath, "/activity_labels.txt", sep="")
  activityLabs <- read.table(activityLabsFile)
  names(activityLabs) <- c("ActivityCategory","ActivityName")
  
  ## Apply descriptive names to observations, select only mean() and std() variables, and order
  ## the columns by these descriptive names to get the mean and std together for each
  ## of the main variables
  names(observations) <- labs[,2]
  observations <- select(observations, ends_with("mean()"), ends_with("std()"))
  n1 <- sort(names(observations))
  observations <- select(observations, n1)
  
  ## cbind with observations and activities
  observations <- cbind(activities, observations)
  observations <- cbind(subjects, observations)
  
  ## Merge in activity labels and ensure the Subject and ActivityName are in the first two
  ## columns.  NOTE: Drop the ActivityCategory  
  observations <- observations %>% merge(activityLabs, by="ActivityCategory") %>%
      select(Subject, ActivityCategory, ActivityName, everything() ) %>%
      select(-ActivityCategory)
  
  ## Return the final dataframe
  
  observations
}

#####################
##### Main line #####
#####################
## Create the training and testing dataframes
trainDF <- buildDF("train")
testDF <- buildDF("test")

##Bind the two dataframes together for the complete dataframe
allDF <- rbind(trainDF, testDF)

##Perform the group_by and summarize all columns with mean by subject,activity 
##to create the final tidy dataset
allDF <- allDF %>% group_by(Subject,ActivityName) %>% summarize_all(mean) 

##write the tidy dataset to a .csv file for ease of use outside of R.  
##This file can be read with apps such as Excel for viewing
if ( file.exists("measurement_means.csv") ) {
  file.remove("measurement_means.csv")
  file.remove("measurement_means.txt")
}

write.csv(allDF, file="measurement_means.csv")
write.table(allDF, file="measurement_means.txt",row.names=FALSE)
