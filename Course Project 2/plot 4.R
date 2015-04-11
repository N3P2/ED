# Question 4:
# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999-–2008?


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
# pm25_class = 6,497,651 observations of 20 variables

library(ggplot2)

coalMatches  <- grepl("coal", pm25_class$Short.Name, ignore.case=TRUE)
subsetpm25_class<- pm25_class[coalMatches, ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetpm25_class, sum)

png("plot4.png")
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()
