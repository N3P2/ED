# Question 5:
# How have emissions from motor vehicle sources changed from 1999-–2008 in Baltimore City?

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


if(!exists("pm25_class")){
        pm25_class <- merge(pm25, class_code, by="SCC")
}

library(ggplot2)

# Assuming "Motor Vehicles" refers to "ON-ROAD"
subsetpm25_MV <- pm25[pm25$fips=="24510" & pm25$type=="ON-ROAD",  ]

aggregatedTotal <- aggregate(Emissions ~ year, subsetpm25_MV, sum)


png("plot5.png", width=840, height=480)
g <- ggplot(aggregatedTotal, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(g)
dev.off()
