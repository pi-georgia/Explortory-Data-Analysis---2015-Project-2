# Project 2 : Exploratory Data Analysis 
#Plot2

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

##  Questions
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

# Subset for Baltimore City, Maryland
BLT <- subset(NEI, fips == "24510" )
##SUMMARIZE BY YEAR
df3<-aggregate(Emissions~year, data=BLT, sum, na.rm=TRUE)
#Plot in png
png("Plot2.png")
barplot(df3$Emissions, names.arg=df3$year, col= 28)
title(main= "Total PM2.5 Emissions per Year in Baltimore City")
dev.off()