# Getting and Cleaning Data final assignment CodeBook
The analysis has been based on data acquired by subjects utilizing a Samsung Galaxy S SmartPhone while performing certain activities. The sensor data of the phone has been recorded, for more information: [Project web site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
1. Data was retrieved from [Download Location](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. From this data only mean and standard deviation measurements have been selected
3. The training and test data have been merged
4. The merged data has been averaged by subject and activity
5. The aggregated data set has been tidied by renaming features

The tidy aggregated data file is called `tidyData.csv`

## Some background info on the input data:
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals TimeAccXYZ and TimeGyroXYZ. These time domain signals (prefix 'Time' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (TimeBodyAccXYZ and TimeGravityAccXYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (TimeBodyAccJerkXYZ and TimeBodyGyroJerkXYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (TimeBodyAccMag, TimeGravityAccMag, TimeBodyAccJerkMag, TimeBodyGyroMag, TimeBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing FreqBodyAccXYZ, FreqBodyAccJerkXYZ, FreqBodyGyroXYZ, FreqBodyAccJerkMag, FreqBodyGyroMag, FreqBodyGyroJerkMag. (Note the 'Freq' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:  
'XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* TimeBodyAccXYZ
* TimeGravityAccXYZ
* TimeBodyAccJerkXYZ
* TimeBodyGyroXYZ
* TimeBodyGyroJerkXYZ
* TimeBodyAccMag
* TimeGravityAccMag
* TimeBodyAccJerkMag
* TimeBodyGyroMag
* TimeBodyGyroJerkMag
* FreqBodyAccXYZ
* FreqBodyAccJerkXYZ
* FreqBodyGyroXYZ
* FreqBodyAccMag
* FreqBodyAccJerkMag
* FreqBodyGyroMag
* FreqBodyGyroJerkMag

The set of variables that were estimated from these signals are:
* Mean: Mean value
* Std: Standard deviation

And averaged by SubjectId and Activity

## Resulting tidy data set
This leads to the following set of factor columns:
* SubjectId
* Activity
With these feature columns (see description above)
* TimeBodyAccMeanX
* TimeBodyAccMeanY
* TimeBodyAccMeanZ
* TimeBodyAccStdX
* TimeBodyAccStdY
* TimeBodyAccStdZ
* TimeGravityAccMeanX
* TimeGravityAccMeanY
* TimeGravityAccMeanZ
* TimeGravityAccStdX
* TimeGravityAccStdY
* TimeGravityAccStdZ
* TimeBodyAccJerkMeanX
* TimeBodyAccJerkMeanY
* TimeBodyAccJerkMeanZ
* TimeBodyAccJerkStdX
* TimeBodyAccJerkStdY
* TimeBodyAccJerkStdZ
* TimeBodyGyroMeanX
* TimeBodyGyroMeanY
* TimeBodyGyroMeanZ
* TimeBodyGyroStdX
* TimeBodyGyroStdY
* TimeBodyGyroStdZ
* TimeBodyGyroJerkMeanX
* TimeBodyGyroJerkMeanY
* TimeBodyGyroJerkMeanZ
* TimeBodyGyroJerkStdX
* TimeBodyGyroJerkStdY
* TimeBodyGyroJerkStdZ
* TimeBodyAccMagMean
* TimeBodyAccMagStd
* TimeGravityAccMagMean
* TimeGravityAccMagStd
* TimeBodyAccJerkMagMean
* TimeBodyAccJerkMagStd
* TimeBodyGyroMagMean
* TimeBodyGyroMagStd
* TimeBodyGyroJerkMagMean
* TimeBodyGyroJerkMagStd
* FreqBodyAccMeanX
* FreqBodyAccMeanY
* FreqBodyAccMeanZ
* FreqBodyAccStdX
* FreqBodyAccStdY
* FreqBodyAccStdZ
* FreqBodyAccJerkMeanX
* FreqBodyAccJerkMeanY
* FreqBodyAccJerkMeanZ
* FreqBodyAccJerkStdX
* FreqBodyAccJerkStdY
* FreqBodyAccJerkStdZ
* FreqBodyGyroMeanX
* FreqBodyGyroMeanY
* FreqBodyGyroMeanZ
* FreqBodyGyroStdX
* FreqBodyGyroStdY
* FreqBodyGyroStdZ
* FreqBodyAccMagMean
* FreqBodyAccMagStd
* FreqBodyAccJerkMagMean
* FreqBodyAccJerkMagStd
* FreqBodyGyroMagMean
* FreqBodyGyroMagStd
* FreqBodyGyroJerkMagMean
* FreqBodyGyroJerkMagStd

## Transformations that have been performed
### Retrieve, filter and label the data
* read the data files `X_train.txt` or `X_test.txt` and add the right column names obtained from `features.text`.
* only features that contain -mean() or -std() are selected.
* add the subject ID from `subject_train.txt` or `subject_test.txt`
* add the activity label derived from the combination of `y_train.txt` or `y_test.txt` with `activity_labels.txt`

### Merge training and test data
* read data from files in corresponding directory `train` or `test`

### Aggregate the merged dataset
* the merged data features have been averaged by subject and activity

### Tidy the aggregated dataset
* make the features Camel Case
* replace all parentheses and dashes
* replace the `t` and `f` column prefixes with Time and Freq respectively
* replace `BodyBody` by `Body`
