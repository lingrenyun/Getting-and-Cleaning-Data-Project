#setup directory
getwd()
setwd("UCI HAR Dataset/")

#Read files
features<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")
subject_test<-read.table("test/subject_test.txt")
subject_train<-read.table("train/subject_train.txt")
x_test<-read.table("test/X_test.txt")
x_train<-read.table("train/X_train.txt")
y_test<-read.table("test/y_test.txt")
y_train<-read.table("train/y_train.txt")

#Name the columns
names(x_test)=features$V2
names(x_train)=features$V2
names(y_test)="LabelID"
names(y_train)="LabelID"
names(subject_test)="subject"
names(subject_train)="subject"
colnames(activity_labels)<-c("Label","Activity")

#Merge data sets into one single dataset and only keep the measurements on the mean and standard deviation
y_test<-merge(activity_labels,y_test)
y_train<-merge(activity_labels,y_train)
mean_std<-grep("mean|std",features$V2)
test<-cbind(subject_test,y_test,x_test[mean_std])
train<-cbind(subject_train,y_train,x_train[mean_std])
dataset<-rbind(test,train)

#Get a tidy dataset
tidy_data = aggregate(dataset, by=list(activity = dataset$Activity, subject=dataset$subject),mean)
tidy_data$Activity <- NULL

#Output the 2 tables (tidy dataset & original dataset)
write.table(tidy_data, file="./tidy_data.txt", sep="\t", row.names=FALSE)
write.table(dataset, file="./dataset.txt", sep="\t", row.names=FALSE)
