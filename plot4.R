library(sqldf)

# Set directory
setwd("/Users/niko/Desktop/R/")

# Create Folder Data
if(!file.exists("data")){dir.create("data")}

# Download File
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./data/raw.zip", method = "curl")
unzip(zipfile = './data/raw.zip', exdir='./data')

# Select only date 1/2/2007 and 2/2/2007
power <- read.csv.sql("./data/household_power_consumption.txt","select * from file where Date='1/2/2007' or Date='2/2/2007'",sep=";")

# Create Plot 2x2
par(mfrow=c(2,2))

# Date
date <- strptime(paste(power$Date, power$Time),"%d/%m/%Y %T")

# subplot row 1 col 1
plot(date, power$Global_active_power, type="l", pch=".", xlab=" ", ylab = "Global Active Power")

# subplot row 1 col 2
plot(date, power$Voltage, type='l', xlab = "datetime", ylab = "Voltage")

# Subplot row 2 col 1
plot(date, power$Sub_metering_1, type="l", xlab = "", ylab="Energy Sub metering", col="black")
lines(date, power$Sub_metering_2, col='red')
lines(date, power$Sub_metering_3, col='blue')

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black","red","blue"), lty=1, pt.cex = 1,cex=0.50, bty="n")


# Subplot row 2 col 2
plot(date, power$Global_reactive_power, type='l', xlab="datetime", ylab="Global_reactive_power")


# Save Image 
dev.copy(png,file="plot4.png")
dev.off()



