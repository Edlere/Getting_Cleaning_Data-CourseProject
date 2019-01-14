install.packages("reshape2")
library(reshape2)

###TEST
##Reading 

test<-read.table("./UCI HAR Dataset/test/X_test.txt")
test_label<-read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./UCI HAR dataset/test/subject_test.txt")


## Names
for (i in 1:2497) {
  if (test_label[i,1]==1) {

 test_label[i,1]<- "WALKING"
  }
  if (test_label[i,1]==2) {
    
    test_label[i,1]<- "WALKING_UPSTAIRS"
  }
  if (test_label[i,1]==3) {
  
    test_label[i,1]<- "WALKING_DOWNSTAIRS"
  }
  if (test_label[i,1]==4) {

    test_label[i,1]<- "SITTING"
  }
  if (test_label[i,1]==5) {
   
    test_label[i,1]<- "STANDING"
  }
  if (test_label[i,1]==6) {

    test_label[i,1]<- "LAYING"
  }
}

##Merge test dataframes 
total_1<-cbind(test_label,test)

colnames(total_1)[1]<-"Activity"

total_test<-cbind(subject_test,total_1)
colnames(total_test)[1]<-"Subject"
View(total_test)


###TRAIN
train<-read.table("./UCI HAR Dataset/train/X_train.txt")
train_label<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")


for (i in 1:2497) {
  if (train_label[i,1]==1) {
    
    train_label[i,1]<- "WALKING"
  }
  if (train_label[i,1]==2) {
    
    train_label[i,1]<- "WALKING_UPSTAIRS"
  }
  if (train_label[i,1]==3) {
    
    test_label[i,1]<- "WALKING_DOWNSTAIRS"
  }
  if (train_label[i,1]==4) {
    
    train_label[i,1]<- "SITTING"
  }
  if (train_label[i,1]==5) {
    
    train_label[i,1]<- "STANDING"
  }
  if (train_label[i,1]==6) {
    
    train_label[i,1]<- "LAYING"
  }
}

##Merge train dataframes

total_2<-cbind(train_label,train)
colnames(total_2)[1]<- "Activity"
total_train<-cbind(subject_train,total_2)
colnames(total_train)[1]<-"Subject"
#View(total_train)

########Mean, standar deviation

##Test
test_mean<-c(2,3)   
test_sd<-c(2,3)

for (i in 1:561) {
  test_mean[i] <- lapply(total_test[i], mean) ##Mean
  test_sd[i]<-lapply(total_test[i],sd)         ##Standar deviation
}
test_mean
test_sd

##Train
train_mean<-c(2,3)
train_sd<-c(2,3)

for (i in 1:561) {
 train_mean[i] <- lapply(total_train[i], mean) ##Mean
 train_sd[i]<-lapply(total_train[i],sd)         ##Standar deviation
}
class(train_mean)
train_sd


##Subjects and activities
  ##Merge dataframes
totaldata<-rbind(total_test,total_train)

totaldata$Activity <- factor(totaldata$Activity, labels=c("Walking",
                                                        "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

melted <- melt(totaldata, id=c("Subject","Activity"))
tidy <- dcast(melted, Subject+Activity ~ variable, mean)

write.table(totaldata,"tidy.txt",row.names = FALSE)

