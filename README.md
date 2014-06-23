##Getting-and-Cleaning-Data-Project
=================================
##run_analysis.R contains the R script for Getting and Cleaning Data Project.The goal of the project is to collect and clean the UHC HAR dataset.

##Steps:
#1. Read files into R:
getwd()
setwd("UCI HAR Dataset/")
features<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")
subject_test<-read.table("subject_test.txt")
subject_train<-read.table("subject_train.txt")
X_test<-read.table("X_test.txt")
X_train<-read.table("X_train.txt")
y_test<-read.table("y_test.txt")
y_train<-read.table("y_train.txt")
y_test[,2] = activity_labels[y_tests[,1]]
y_train[,2] = activity_labels[y_train[,1]]
means_stds<-grep("mean|std",features$V2)

#2. Name columns for all the files:
names(X_test)=features$V2
names(X_train)=features$V2
names(y_test)="LabelID"
names(y_train)="LabelID"
names(subject_test)="subject"
names(subject_train)="subject"
colnames(activity_labels)<-c("LabelID","Activity")

#3. Merge columns from different files into one single file "dataset":
y_test<-merge(activity_labels,y_test)
y_train<-merge(activity_labels,y_train)
means_stds_test<-X_test[means_stds]
test<-cbind(subject_test,y_test,means_stds_test)
means_stds_train<-X_train[means_stds]
train<-cbind(subject_train,y_train,means_stds_train)
dataset<-rbind(test,train)

#4: Make tidy dataset and output 2 dataset (Original one & tidy one):
tidy_data = aggregate(dataset, by=list(activity = dataset$Activity, subject=dataset$subject),mean)
write.table(dataset, file="./dataset.txt", sep="\t", row.names=FALSE)
write.table(tidy_data, file="./tidy_data.txt", sep="\t", row.names=FALSE)
