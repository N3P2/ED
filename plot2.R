fileurl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("C:/Users/Qingyuan/Documents/R/Exploratory_Data_Analysis")){dir.create("C:/Users/Qingyuan/Documents/R/Exploratory_Data_Analysis")}
download.file(fileurl, destfile = "C:/Users/Qingyuan/Documents/R/Exploratory_Data_Analysis/power.zip")

getwd()
setwd("C:/Users/Qingyuan/Documents/R/Exploratory_Data_Analysis")
unzip("power.zip")

## Getting full dataset
power <- read.csv("C:/Users/Qingyuan/Documents/R/Exploratory_Data_Analysis/household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
power$Date <- as.Date(power$Date, format="%d/%m/%Y")

## Subsetting the data
power_07 <- subset(power, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
head(power_07, n=10)

## Converting dates
date_time <- paste(as.Date(power_07$Date), power_07$Time)
power_07$Datetime <- as.POSIXct(date_time)

## Plot 2
plot(power_07$Global_active_power~power_07$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()