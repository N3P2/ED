# Question 6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == 06037).
# Which city has seen greater changes over time in motor vehicle emissions?


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
subsetpm25_MV_2 <- pm25[(pm25$fips=="24510"|pm25$fips=="06037"),  ]

aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetpm25_MV_2, sum)
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
g <- ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()
