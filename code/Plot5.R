# Project 2 : Exploratory Data Analysis 
#Plot5

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
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Subset for Source Codes related to emissions from motor vehicle sources
#Find which pattern for "motor vehicle sources" can be used to filter based on EI.Sector levels
levels(SCC$EI.Sector)
# pattern identified : Sectors starting with "Mobile" are according to the categorization the ones that describe the motor vehicle sources (on/off road etc)

#get the indexes of sectors starting with "Mobile" // From the EI.Sector
index2<-grep("^Mobile", SCC$EI.Sector, ignore.case=T)
#subset SCC to keep only relevant Sectors
SCCset2 <- SCC[index2,]

#Match in NEI dataset the relevant codes and subset
NEIset2 <- subset(NEI, fips == "24510" & SCC %in% SCCset2$SCC)
##SUMMARIZE BY YEAR 
df6<-aggregate(Emissions~year, data=NEIset2, sum, na.rm=TRUE)

barplot(df6$Emissions, names.arg=df6$year, col=34)
title(main= "Total PM2.5 Emissions per Year for motor vehicle sources in Baltimore City")
#Plot in png
dev.copy(png, file = "Plot5.png")
dev.off()