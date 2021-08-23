#download the zipped data
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file<- "UCI HAR Dataset.zip"
library(dplyr)
library(downloader)
if(!file.exists(file)){download(url,file,mode="wb")}
unzip(file,exdir=".")


#read in the training data
subject_train<-read.table(file.path("UCI HAR Dataset","train","subject_train.txt"))
x_train<-read.table(file.path("UCI HAR Dataset","train","x_train.txt"))
y_train<-read.table(file.path("UCI HAR Dataset","train","y_train.txt"))

#read in the test data
subject_test<-read.table(file.path("UCI HAR Dataset","test","subject_test.txt"))
x_test<-read.table(file.path("UCI HAR Dataset","test","x_test.txt"))
y_test<-read.table(file.path("UCI HAR Dataset","test","y_test.txt"))

#read in features and activity lables files 
features<-read.table(file.path("UCI HAR Dataset","features.txt"))
activity_labels<-read.table(file.path("UCI HAR Dataset","activity_labels.txt"))

#assign column names 

colnames(subject_train)<-"subjectId"
colnames(x_train)<-features[,2]
colnames(y_train)<-"activityId"

colnames(subject_test)<-"subjectId"
colnames(x_test)<-features[,2]
colnames(y_test)<-"activityId"

colnames(activity_labels)<-c("activityId","activity")

############################################################
#Q1 merge the training and the test sets to create one dataset
############################################################
mergetrain<-cbind(subject_train,y_train,x_train)
mergetest<-cbind(subject_test,y_test,x_test)

finalmerge<-rbind(mergetrain,mergetest)

###################################################################################
#Q2 extracts only the measurements on the mean and standard deviation for each measurement
###############################################################################

#filter the columns 
extracts<-grepl("subjectId|activityId|mean|std", colnames(finalmerge))

#create new dataset with only selected columns 
finalmerge<-finalmerge[,extracts]

##########################################################################
#Q3 Uses descriptive activity names to name the activities in the data set
##############################################################################

#merge the dataset with activity labels
datasetwithnames<- merge(finalmerge,activity_labels, by = "activityId", all.x = TRUE)

#move the activity column from the last to the second column

datasetwithnames<- datasetwithnames%>%select(subjectId,activity,everything())
###############################################################################
#Q4 Appropriately labels the data set with descriptive variable names
###########################################################################

#check column names 
names(datasetwithnames)

#rename the variables 
names(datasetwithnames)<-gsub("Acc","Accelerometer", names(datasetwithnames))
names(datasetwithnames)<-gsub("^t","time", names(datasetwithnames))
names(datasetwithnames)<-gsub("Gyro","Gyroscope", names(datasetwithnames))
names(datasetwithnames)<-gsub("Mag","Magnitude", names(datasetwithnames))
names(datasetwithnames)<-gsub("^f","frequency", names(datasetwithnames))
names(datasetwithnames)<-gsub("BodyBody","Body", names(datasetwithnames))
names(datasetwithnames)<-gsub("-mean()","Mean", names(datasetwithnames))
names(datasetwithnames)<-gsub("Freq()","Frequency", names(datasetwithnames))
names(datasetwithnames)<-gsub("-std()","StandardDeviation", names(datasetwithnames))

################################################################################
#Q5 From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject. 
###############################################################################

#group the new mean dataset by subjectId & activity
tidydataset<-datasetwithnames%>%group_by(subjectId,activity)%>%summarise_all(funs(mean))


#drop the activityId column
tidydataset<-tidydataset%>%select(-activityId)
#writing the dataset to txt file 
write.table(tidydataset,"TidyDataset.txt", row.names = FALSE, quote = FALSE)
