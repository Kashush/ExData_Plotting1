plot3<-function(){
    
    #library(lubrdate)
    library(utils)
    library(data.table)
    
    #set the working directory
    setwd("C:/Users/Corina/ExData_Plotting1")
    
    #Download the file
    zipFileName<-"Household Power Consumption.zip"
    fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, destfile=zipFileName, mode="wb")
    
    #Unzip the file and remove the zip file.
    unzip(zipFileName)
    file.remove(zipFileName)
    
    #Read the file into a table.
    filename<-"household_power_consumption.txt"
    initial <- read.table(filename, sep=";", na.strings ="?", header =TRUE, nrows = 100)
    classes <- sapply(initial, class)
    #Select the lines for the dates 2/1/2007 to 2/2/2007.
    powerDataframe <- read.table(filename, colClasses = classes, sep=";", na.strings ="?", skip=66638, nrows=2879)
    names(powerDataframe)<-names(initial)
    powerTable<-data.table(powerDataframe)
    
    file.remove(filename)
    rm(initial)
    
    #Add a new columns to hold dates and the days of the week.
    powerTable[,DateValue:=as.Date(Date, format = "%d/%m/%Y")]
    powerTable[,DateTime:=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")]

    #check that the png file doesn't exist yet.
    PNG_FileName = "./plot3.png"
    if (file.exists(PNG_FileName)) unlink(PNG_FileName, recursive = TRUE, force = TRUE)
    
    #Create a graph.
    png(PNG_FileName, width = 480, height = 480)
    with(powerTable, {
        plot(DateTime, Sub_metering_1, type="l", col="black", ylab="Energy sub metering")
        points(DateTime, Sub_metering_2, type="l", col="red")
        points(DateTime, Sub_metering_3, type="l", col="blue")
    })
    
    legend("topright", pch = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    #Turn off the png device.
    dev.off()
    
    
}