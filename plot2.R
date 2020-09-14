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


# Modify Date Format
date <- strptime(paste(power$Date, power$Time),"%d/%m/%Y %T")

# Plot data
plot(date, power$Global_active_power, type='l', xlab="", ylab = "Global Active Power(kilowatts)")


# Save Image 
dev.copy(png, file="plot2.png")
dev.off()
