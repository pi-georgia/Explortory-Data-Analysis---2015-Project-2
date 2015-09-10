# Project 2 : Exploratory Data Analysis 
#Plot1

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
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

##SUMMARIZE BY YEAR
df2=aggregate(Emissions~year, data=NEI, sum, na.rm=TRUE)
#Plot in png
png("Plot1.png")
barplot(df2$Emissions, names.arg=df2$year, col= 26)
title(main= "Total PM2.5 Emissions per Year")
dev.off()