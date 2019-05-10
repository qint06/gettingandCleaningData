The codebook for the assignment Abstract “tidy.txt” coudl be read as a
data.table in R. The first column is the subject, thus the person the
test is upon. The second column shows the activity. The residual columns
show the data.

Generation of data The raw data are read in and merged into one dataset
from train and test data

    features<-read.table("UCI HAR Dataset/features.txt")
    activity<-read.table("UCI HAR Dataset/activity_labels.txt")
    XTrain<- read.table("UCI HAR Dataset/train/X_train.txt")
    YTrain<- read.table("UCI HAR Dataset/train/Y_train.txt")
    SubjectTrain <-read.table("UCI HAR Dataset/train/subject_train.txt")
    XTest<- read.table("UCI HAR Dataset/test/X_test.txt")
    YTest<- read.table("UCI HAR Dataset/test/Y_test.txt")
    SubjectTest <-read.table("UCI HAR Dataset/test/subject_test.txt")

    #merge train and test data
    X<-rbind(XTest, XTrain)
    Y<-rbind(YTest, YTrain)
    Subject<-rbind(SubjectTest, SubjectTrain)

Only standard deviations and means are kept for use

    locations<-grep("mean\\(\\)|std\\(\\)", features[,2])
    dataSub <-X[,locations]

label the data variables and activities

    labelsActivity <- as.character(activity[,2])
    Y[,1]<-labelsActivity[Y[,1]]

    names(dataSub) <- features[locations,2]
    names(Subject)<-"Subject"
    names(Y)<-"Activity"
    Data <- cbind(Subject, Y, dataSub)

Independent tidy data set with the average of each variable for each
activity and each subject is generated

    dataTidy <- aggregate(Data[,3:68], by = list(activity = Data$Activity, subject = Data$Subject),mean)
    write.table(x = dataTidy, file = "dataTidy.txt", row.names = FALSE)
