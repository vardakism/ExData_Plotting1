########## Usage ######################################################
#R code for examining how household energy usage varies 
# over a 2-day period in February, 2007

########## Data #######################################################
#his assignment uses data from the UC Irvine Machine Learning Repository, 
# a popular repository for machine learning datasets. 

### Importing the data ###
# The dataset of the Individual household electric power consumption is rather
# large. This means that it requires a considerable amount of your computers 
# memory. Here I suggest two ways importing the data depending on your machine

# First way to import the data
# Save time by initializing only 100 lines of the data and determine the class
# of each row
initial<-read.table("household_power_consumption.txt",header=T,
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

########## Plot4 #######################################################
# If you have already loaded the dataset skip this step
load("~/ExData_Plotting1/RData/subData.RData")

# Create a new format of Datetime
days<-weekdays(as.Date(submyDat$Datenew))
submyDat$DateTime <- as.POSIXct( strptime(
        paste(submyDat$Date, submyDat$Time), "%d/%m/%Y %H:%M:%S"))   

png(file = "~/ExData_Plotting1/figure/plot4.png",height=480,width=480, 
    bg = "transparent")
        par(mfcol=c(2,2))

        #plot1
        plot(submyDat$DateTime,submyDat$Global_active_power,type="l",lty="solid", 
     xaxt="n",ylab='Global active power',xlab='')
        axis(1, at=c(min(submyDat$DateTime), min(submyDat$DateTime)+86400,
             min(submyDat$DateTime)+2*86400),
                labels=c("Thu", "Fri", "Sat"))

        #plot 2
        plot(submyDat$DateTime,submyDat$Sub_metering_1,type="l",lty="solid",
     col="black",xaxt="n",ylab='Energy sub metering',xlab='')
        lines(submyDat$DateTime,submyDat$Sub_metering_2,type="l",lty="solid",
      col="red",xaxt="n")
        lines(submyDat$DateTime,submyDat$Sub_metering_3,type="l",lty="solid",
      col="blue",xaxt="n")
        axis(1, at=c(min(submyDat$DateTime), min(submyDat$DateTime)+86400,
             min(submyDat$DateTime)+2*86400),
                labels=c("Thu", "Fri", "Sat"))
        legend("topright",lty="solid",
       legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),bty="n")
        
        #plot3
        plot(submyDat$DateTime,submyDat$Voltage,type="l",lty="solid", 
     xaxt="n",ylab='Voltage',xlab='datetime')
        axis(1, at=c(min(submyDat$DateTime), min(submyDat$DateTime)+86400,
             min(submyDat$DateTime)+2*86400),
        labels=c("Thu", "Fri", "Sat"))

        #plot 4
        plot(submyDat$DateTime,submyDat$Global_reactive_power,type="l",lty="solid", 
     xaxt="n",ylab='Global_reactive_power',xlab='datetime')
        axis(1, at=c(min(submyDat$DateTime), min(submyDat$DateTime)+86400,
             min(submyDat$DateTime)+2*86400),
        labels=c("Thu", "Fri", "Sat"))

dev.off()
