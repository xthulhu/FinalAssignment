#Course Project Code Book

Data used for this assignment available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Original source of data available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

<h2>What this script does:</h2>

Merges `train/X_train.txt` and `test/X_test.txt` into a **10299x561 data frame**, according to the description: `"Number of Instances: 10299" and "Number of Attributes: 561"`

Merges `train/subject_train.txt` and `test/subject_test.txt` into a **10299x1 data frame** with subject IDs.

Merges `train/y_train.txt` and `test/y_test.txt` into a **10299x1 data frame** with activity IDs.

Parses `features.txt` for the Mean and Std Deviation of each measurement. Only 66/561 attributes matched Mean and Std Deviation. The result is a **10299x6 data frame**.

Reads `activity_labels.txt` then applies descriptive activity name to activities in the data set.
```
WALKING

WALKING_UPSTAIRS

WALKING_DOWNSTAIRS

SITTING

STANDING

LAYING
```
As per the requirement, the script labels the data set with descriptive names. Feature names and activity names are lower case, with underscores and brakets removed. 

The 10299x66 data frame (features) is merged with the 10299x1 data frames (activity labels and subject IDs). The output is written as a **10299x68 data frame** to `merged_data.txt` in the format:

```
First column: subject IDs

Second column: activity labels

Remaining 66 columns: measurements
```

Subject IDs are integers between 1 and 30, with attribute names in the following format:
```
tbodygyro-std-x 
tbodygyro-std-y 
tbodygyro-std-z 
tbodygyrojerk-mean-x 
tbodygyrojerk-mean-y 
tbodygyrojerk-mean-z
```
The script then produces an independent tidy data set with averages of each measurement per activity and subject. This is written as a **180x68** data frame to `data_with_means.txt` in the format:
```
First column: subject IDs

Second column: activity labels

Remaining 66 columns: averages per attribute
```

For a total of 30 subjects, 6 activities, and 180 rows with averages.

