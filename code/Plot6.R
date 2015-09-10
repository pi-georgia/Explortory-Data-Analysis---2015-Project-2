# Project 2 : Exploratory Data Analysis 
#Plot6

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
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

# Subset for Source Codes related to emissions from motor vehicle sources
#Find which pattern for "motor vehicle sources" can be used to filter based on EI.Sector levels
levels(SCC$EI.Sector)
# pattern identified : Sectors starting with "Mobile" are according to the categorization the ones that describe the motor vehicle sources (on/off road etc)

#get the indexes of sectors starting with "Mobile" // From the EI.Sector
index2<-grep("^Mobile", SCC$EI.Sector, ignore.case=T)
#subset SCC to keep only relevant Sectors
SCC2 <- SCC[index2,]

#Match in NEI dataset the relevant codes and subset. Have decided to split per City, so that I can later on plot % Diff 3Year on 3Year
N_LA <- subset(NEI, fips == "06037" & SCC %in% SCC2$SCC)
N_BA <- subset(NEI, fips == "24510" & SCC %in% SCC2$SCC)


##SUMMARIZE Emissions BY YEAR 
LA_tot<-aggregate(Emissions~year, data=N_LA, sum, na.rm=TRUE)
BA_tot<-aggregate(Emissions~year, data=N_BA, sum, na.rm=TRUE)

#Calculating 3 Year percentage differences, so that I can undestand the relative change for each city ...

i<-length(LA_tot[,1])
LA_tot$Pcnt_Diff[1]<-0
BA_tot$Pcnt_Diff[1]<-0
for (j in 2:i)
  { 
  LA_tot$Pcnt_Diff[j] <-LA_tot$Emissions[j]/LA_tot$Emissions[j-1]-1
  BA_tot$Pcnt_Diff[j]<-BA_tot$Emissions[j]/BA_tot$Emissions[j-1]-1
  j<-j+1
}
#adding one more dimension in each table to mention the City, because I am planning to group them back together and plot with city factor
BA_tot$city <-"BA"
LA_tot$city <-"LA"
#grouping back together by building a new data.frame 
data<-LA_tot
for (j in 5:8)
{ 
data[j,]<-BA_tot[j-4,]
j<-j+1
}

# Plot the % difference over 3 years period per city
qplot(year, Pcnt_Diff, data = data,    color = factor(city),geom = c("point", "line"), main= "%Change in PM2.5 Emissions per 3Year for motor vehicle sources in Baltimore and LA")
#Plot in png
dev.copy(png, file = "Plot6.png")
dev.off()