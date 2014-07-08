########## Usage ######################################################
#R code for examining how household energy usage varies 
# over a 2-day period in February, 2007

########## Data #######################################################
#his assignment uses data from the UC Irvine Machine Learning Repository, 
# a popular repository for machine learning datasets. 

### Importing the data ###
# The dataset of the Individual household electric power consumption is rather
# large. This means that it requires a considerable amount of your computers 
# memory. Here I suggest two ways iomporting the data depending on your machine
# Download the data and unzip them from the location given by the README.md file

# First way to import the data
# Save time by initializing only 100 lines of the data and determine the class
# of each row
initial<-read.table("~/InternetCourses/specialization/4.Exploratory_Data_Analysis/check/household_power_consumption.txt",header=T,
                    na.strings="?",nrows=100,sep=";")
classes<-sapply(initial, class)

# Load the whole dataset using the colClasses to determine the column variable
# classes
myDat<-read.table("household_power_consumption.txt",header=T,
                  na.strings="?",colClasses=classes,sep=";")
# Select the focus dates  by transforming them to class Date
datc<-as.character(myDat$Date)
datD<-strptime(datc,"%d/%m/%Y")
myDat$Datenew<-format(datD,"%Y-%m-%d")
submyDat<-subset(myDat,
                 myDat$Datenew=="2007-02-01"|myDat$Datenew=="2007-02-02")
# You can save the subset data in RData format which requires less time every 
# time you would like to load it.
save(submyDat,file="subData.RData")

## Second way to import the data

library(sqldf) # Install and load the sqldf library

# Preselection of the focus dates before importing the dataset Use .csv suffix 
# by changing in your directory the suffix from .txt to .csv

submyDat<-read.csv.sql(file="household_power_consumption.csv",header=T,sep=";",                       
                       sql="select * from file 
                  where Date ='1/2/2007' or Date ='2/2/2007'")
save(submyDat,file="subData.RData")

########## Plot1 #######################################################
# If you have already loaded the date skip this step
load("~/ExData_Plotting1/RData/subData.RData")

png(file = "~/ExData_Plotting1/figure/plot1.png",height=480,width=480, bg = "transparent")
hist(submyDat$Global_active_power,col="red",
     xlab="Global active power (kilowatts)",
     main="Global Active Power")
dev.off()

