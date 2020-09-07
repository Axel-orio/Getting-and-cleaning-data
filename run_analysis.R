##############################Proyecto final########################################  


##########Preparacion###############
rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
gc() #free up memrory and report the memory usage.
### Setup ----
Sys.setlocale("LC_ALL", "es_ES.UTF-8") # Cambiar locale para prevenir problemas con caracteres especiales
options(scipen=999) # Prevenir notacion cientifica

#Definimos el directorio
setwd("~/Coursera/Getting and cleaning data/Proyecto")

#Bajamos los archivos
filename <- "Coursera_Proyecto_Final.zip"


# Verificamos la existencia del archivo zip
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Lo mismo para el folder
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#Cargamos las librerías que vamos a utilizar
library(dplyr)


#Cargamos las bases que vamos a utilizar
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


#Juntamos las bases que nos interesan
observations <- rbind(x_train, x_test)
labels <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
complete_data <- cbind(subject, observations, labels)

#Extraemos las variables que nos interesan, mean y sd
provisional <- complete_data %>% 
    select(subject, code, contains("mean"), contains("std"))


#Cambiamos el codigo por el nombre de la actividad
provisional$code <- activities[provisional$code, 2]

#Le ponemos nombres entendibles a las variables
names(provisional)[2] = "activity"
names(provisional)<-gsub("Acc", "Accelerometer", names(provisional))
names(provisional)<-gsub("Gyro", "Gyroscope", names(provisional))
names(provisional)<-gsub("BodyBody", "Body", names(provisional))
names(provisional)<-gsub("Mag", "Magnitude", names(provisional))
names(provisional)<-gsub("^t", "Time", names(provisional))
names(provisional)<-gsub("^f", "Frequency", names(provisional))
names(provisional)<-gsub("tBody", "TimeBody", names(provisional))
names(provisional)<-gsub("-mean()", "Mean", names(provisional), ignore.case = TRUE)
names(provisional)<-gsub("-std()", "STD", names(provisional), ignore.case = TRUE)
names(provisional)<-gsub("-freq()", "Frequency", names(provisional), ignore.case = TRUE)
names(provisional)<-gsub("angle", "Angle", names(provisional))
names(provisional)<-gsub("gravity", "Gravity", names(provisional))

#Preparamaos base final
final <- provisional %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(final, "grouped_data.txt", row.name=FALSE)

