### Create plot 2
# Load the data
data<-readRDS('summarySCC_PM25.rds')
# Subset the data for Baltimore City only
data_balt_city <- data[data$fips==24510,]
# Aggregate the data to show total emissions of PM25 by year
total_pm25_by_year<-setNames(aggregate(data_balt_city$Emissions,by=list(data_balt_city$year),FUN=sum),c('Year', 'PM25'))
# Generate the plot
png(file='plot2.png')
barplot(total_pm25_by_year$PM25,names=total_pm25_by_year$Year,main='Total PM25 Emissions by Year (Baltimore City)',ylim=c(0,3500),ylab='Emissions (tons)')
dev.off()