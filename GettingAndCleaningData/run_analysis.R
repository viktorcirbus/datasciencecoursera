#Remove datasets if they exists with the same name

  if (exists("dataset")) {rm("dataset")}
  if (exists("temp_dataset")) {rm("temp_dataset")}
  
  
#1. Merges the training and the test sets to create one data set
    
    # if the merged dataset doesn't exist, create it from test data
    if (!exists("dataset")){
      dataset <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"")
      datasetactivity <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"")
      datasetsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"")
      dataset=cbind(datasetsubject,datasetactivity,dataset)
      rm(datasetactivity)
      rm(datasetsubject)
  
    }
    
    # if the merged dataset does exist, append to it train data
     if (exists("dataset")){
      temp_dataset <-read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"")
      temp_datasetactivity <-read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"")
      temp_datasetsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"")
      temp_dataset=cbind(temp_datasetsubject,temp_datasetactivity,temp_dataset)
      dataset<-rbind(dataset, temp_dataset)
      rm(temp_dataset)
      rm(temp_datasetactivity)
      rm(temp_datasetsubject)
    }

  #Get features names
  datasetcolumnlabels <- read.table("./UCI HAR Dataset/features.txt", quote="\"",stringsAsFactor=F)

  #Apply features names (4. Appropriately labels the data set with descriptive variable names.)
  colnames(dataset)=c("subject","activity_id",datasetcolumnlabels$V2)
  rm(datasetcolumnlabels)
  
  #Get Activity names
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", quote="\"",stringsAsFactor=F)
  colnames(activity_labels)=c("activity_id","activity")
  
  #Apply Activity names to dataset with merging (3.Uses descriptive activity names to name the activities in the data set)
  subsetdatasetactivityid=as.data.frame(dataset$activity_id)
  colnames(subsetdatasetactivityid)=c("id")
  mergedata=merge(subsetdatasetactivityid,activity_labels,by.x="id",by.y="activity_id",x.all=all,sort=F)
  dataset$activity=mergedata$activity
  rm(activity_labels)
  rm(mergedata)
  rm(subsetdatasetactivityid)
  

  #Find column names that have mean or std in it exclude Freq columns
  columnindexes= grep("mean()[^F]|std()[^F]",names(dataset))
  meanandstd=dataset[,columnindexes]
 
  #2. Extracts only the measurements on the mean and standard deviation for each measurement into new data set called newdata
  newdata=cbind(subject=dataset$subject,activity=dataset$activity,meanandstd)
  names(newdata[,1])="subject"
  names(newdata[,2])="activity"
  
  wd <- getwd()
  wd=paste(wd,"/newdata.txt",sep = "")
  
  write.csv(newdata,wd,row.names=F)

  rm(wd)
  rm(columnindexes)

  
  # 5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. Called final.
  
  melting=melt(newdata,id.vars=c("subject","activity"),measure.vars=3:68,factorsAsStrings=TRUE)
  
  wd <- getwd()
  wd=paste(wd,"/melting.csv",sep = "")
  
  write.csv(melting,wd,row.names=F)
  
  rm(wd)
  rm(columnindexes)
  

  #convert factor to character
  melting$variable=as.character(melting$variable)
  melting$activity=as.character(melting$activity)
 

  final=dcast(melting, subject + activity ~ variable, mean,drop=F)


  # Export the final data set into file called submission.txt into working directory
          
  wd <- getwd()
  wd=paste(wd,"/submission.txt",sep = "")

  write.csv(final,wd,row.names=F)
  
  rm(wd)
  rm(dataset)
  rm(meanandstd)
  rm(melting)
  rm(newdata)

  
  
