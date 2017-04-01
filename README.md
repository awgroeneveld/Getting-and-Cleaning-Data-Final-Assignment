# Getting and Cleaning Data Course Project
This project is delivered as the final assignment to the Getting and Cleaning Data course and aims to transform and tidy Samsung Galaxy S sensor measurement datasets for several subjects performing activities.

Refer to the [CodeBook.md](https://github.com/awgroeneveld/Getting-and-Cleaning-Data-Final-Assignment/blob/master/CodeBook.md) file for a description of the data and the transformations performed by this projects's code.

The working directory should be set to the directory containing the data as specified in the CodeBook file in a subdirectory `UCI HAR Dataset`.

The script to perform the requested transformations is in `run_analysis.R`. The file can be run as follows:
* source("run_analysis.R")
* run.analysis()

From the main script the following actions are performed:
* initialize the base path to `UCI HAR Dataset`
* read the `activity_labels.txt` file to be able to translate the activity IDs
* read the `features.txt` file to name the columns later on
* make a subset of the feature names containing only `mean` and `std` features
* get the merged Dataset `getData()`
  * get the training data `getDataSet()`
    * get the observation data (`readAndFilterObservations`)
    * get the subject data
    * get the activity data
    * combine the data using `cbind()` and the factor level/label lookup
  * get the test data `getDataSet()`
    * (see training data)
  * merge the data using `rbind()`
  * write result to `mergedData.csv`
* create the averaged and tidy Dataset `averageAndMakeTidy()`
  * average features for SubjectId and Activity
  * tidy the feature names (see the `CodeBook.md` file and R comments for description)
  * write result to `tidyData.csv` and `tidyData.txt`
* return the tidy Dataset
