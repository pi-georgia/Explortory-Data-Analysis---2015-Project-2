# Project 2 : Exploratory Data Analysis 
#Plot4

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
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Subset for Source Codes related to emissions from coal combustion
# get the indexes of sectors starting with "Fuel Comb" and ending with "Coal"
index<-grep("^Fuel Comb -(.*)- Coal$", SCC$EI.Sector, ignore.case=T)
#subset SCC to keep only relevant Sectors
SCCset <- SCC[index,]

#Match in NEI dataset the relevant codes and subset
NEIset <- subset(NEI, SCC %in% SCCset$SCC  )
##SUMMARIZE BY YEAR 
df5<-aggregate(Emissions~year, data=NEIset, sum, na.rm=TRUE)

barplot(df5$Emissions, names.arg=df5$year, col= 37)
title(main= "Total PM2.5 Emissions per Year for coal combustion-related sources")
#Plot in png
dev.copy(png, file = "Plot4.png")
dev.off()