The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

data
-The dataset is located in the TidyDataset.txt of this repository, it contains 180 observations of 81 variables 


variable
- subjectId: Subject identifier, integer, ranges from 1 to 30.
- activity: including 6 activities; WALKING,WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,SITTING,STANDING and LAYING
- 79 averaged signal measurements

The measurements selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a
corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 
Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value

std(): Standard deviation


the steps of the scripts calculated:
1.Download the dataset
  - Dataset downloaded and extracted under the folder called UCI HAR Dataset
  - features.txt : 561 rows, 2 columns
  - activity_labels.txt : 6 rows, 2 columns
  - subject_test.txt : 2947 rows, 1 column
         contains test data of 9/30 volunteer test subjects being observed
  - X_test.txt : 2947 rows, 561 columns
               contains recorded features test data
  - y_test.txt : 2947 rows, 1 columns
                   contains test data of activities’code labels
  - subject_train.txt : 7352 rows, 1 column
          contains train data of 21/30 volunteer subjects being observed
  - X_train.txt : 7352 rows, 561 columns
            contains recorded features train data
  - y_train.txt : 7352 rows, 1 columns
              contains train data of activities’code labels

2. Merges the training and the test sets to create one data set
mergetrain (7352 rows, 563 columns) is created by merging subject_train,y_train,x_train using cbind() function
mergetest ( 2947 rows, 563 column) is created by merging subject_test,y_test,x_test using cbind() function
finalmerge (10299 rows, 563 column) is created by merging mergetrain,mergetest using rbind() function


3.Extracts only the measurements on the mean and standard deviation for each measurement
finalmerge (10299 rows, 81 columns) is created by using grepl to filter out only columns with mean and standard deviation 

4. Uses descriptive activity names to name the activities in the data set
merged the finalmerge dataset with activity labels dataset; and rearrange the column sequence 

5.Appropriately labels the data set with descriptive variable names

All Acc in dataset’s name replaced by Accelerometer
All Gyro in dataset’s name replaced by Gyroscope
All BodyBody in dataset’s name replaced by Body
All Mag in dataset’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time
All -mean() in dataset's name replaced by Mean
All -std() in dataset's name replaced by StandardDeviation
All Freq in dataset's name repalced by Frequency 

6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
Tidydataset (180 rows, 81 columns) is created by sumarizing tidydataset taking the means of each variable for each activity and each subject, after groupped by subjectId and activity.
Export the final dataset into TidyDataset.txt file.







