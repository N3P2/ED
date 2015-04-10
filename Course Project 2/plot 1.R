# Question 1:
# Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Check working folder location and set the correct one
getwd()
setwd("C:/Users/Qingyuan/Documents/R/Exploratory_Data_Analysis/Course Project 2")

# Check if you have the listed files in the folder
list.files()

# Read the data file
pm25 <- readRDS("summarySCC_PM25.rds")
class_code <- readRDS("Source_Classification_Code.rds")
# pm25 = 6,497,651 observations of 6 variables
# class_code = 11,717 observation of 15 variables


pm25_year <- tapply(pm25$Emissions, pm25$year, sum)

png("plot1.png")
plot(names(pm25_year), pm25_year, type="l",
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main=expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()
