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

locations<-grep("mean\\(\\)|std\\(\\)", features[,2])
dataSub <-X[,locations]

labelsActivity <- as.character(activity[,2])
Y[,1]<-labelsActivity[Y[,1]]

names(dataSub) <- features[locations,2]
names(Subject)<-"Subject"
names(Y)<-"Activity"
Data <- cbind(Subject, Y, dataSub)

dataTidy <- aggregate(Data[,3:68], by = list(activity = Data$Activity, subject = Data$Subject),mean)
write.table(x = dataTidy, file = "dataTidy.txt", row.names = FALSE)

