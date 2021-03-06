##R script to reproduce the sample charts for Wk 1 assignment
##Script 1) downloads data, 2) reads txt, 4) converts dates, 5) creates subset for specified dates, 6) then makes the Plot
##Note the first steps 1-5 are same across all the 4 scripts so would only need to be run once

##First set wd to this script's location (the repo 'ExData_Plotting1' root)


##Download zip file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="household_power_consumption.zip", method="auto")
zipfile <- "household_power_consumption.zip"

##Unzip file
unzip("household_power_consumption.zip")


##Read txt file into data frame (converting ? to NA).
#Note Date + POSIXct do not convert the Date/Time columns correctly so read as character then convert
data_all <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                       na.strings="?",
                       colClasses=c("character","character","numeric","numeric",
                                    "numeric","numeric","numeric","numeric","numeric"))


##Convert Data/Time variables (and add datetime field)
data_all$Date2 <- strptime(data_all$Date,"%d/%m/%Y")
data_all$Time2 <- strptime(data_all$Time,"%H:%M:%S")
data_all$datetime <- strptime(paste(data_all$Date,data_all$Time, sep = " "),
                              "%d/%m/%Y %H:%M:%S")


##Subset for relevant dates (01/02/2007 & 02/02/2007)
#creates a table of 2881 rows and 12 columns
data_part <- subset(data_all, datetime >= "2007-02-01 00:00:00" & 
                            datetime <= "2007-02-03 00:00:00")


##write subset of data out (and read back in)
#note needed for assignment but good to save a tidy data set
#write.table(data_part,file="data_part.txt",row.names=FALSE)
#data_part <- read.table("data_part.txt", header=TRUE, sep=" ")


##Plot1 - histogram
png(filename = "plot1.png",
    width = 480, height = 480, units = "px")

hist(data_part$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col="red")

dev.off()