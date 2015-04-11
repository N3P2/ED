# Question 2:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
# plot answering this question.

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

Baltimore <- subset(pm25, fips == "24510")

Baltimore_year <- aggregate(Emissions ~ year, Baltimore, sum)

png("plot2.png")

barplot(
        Baltimore_year$Emissions,
        names.arg=Baltimore_year$year,
        xlab="Year",
        ylab="PM2.5 Emissions (Tons)",
        main="Total PM2.5 Emissions From all Baltimore City Sources"
        )

dev.off()
