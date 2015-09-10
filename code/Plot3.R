# Project 2 : Exploratory Data Analysis 
#Plot3

# Data Dictionary

# fips: A five-digit number (represented as a string) indicating the U.S. county
# SCC: The name of the source as indicated by a digit string (see source code classification table)
# Pollutant: A string indicating the pollutant
# Emissions: Amount of PM2.5 emitted, in tons
#type: The type of source (point, non-point, on-road, or non-road)
#year: The year of emissions recorded


#read RDS data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)
##  Questions
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.


# Subset for Baltimore City, Maryland
BLT <- subset(NEI, fips == "24510" )
##SUMMARIZE BY YEAR and point
df4<-aggregate(Emissions~year+type, data=BLT, sum, na.rm=TRUE)

ggplot(data = df4, aes(x=year, y=Emissions), ylab="Emissions") + geom_bar(stat="identity") + facet_grid(type ~ .)

                                                                                                        
                                                                                                        #Plot in png
 dev.copy(png, file = "Plot3.png")
dev.off()