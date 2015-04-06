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

## Converting dates
datetime <- paste(as.Date(power_07$Date), power_07$Time)
power_07$Datetime <- as.POSIXct(datetime)


## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(power_07, {
        plot(Global_active_power~Datetime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~Datetime, type="l",
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~Datetime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~Datetime, type="l",
             ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()