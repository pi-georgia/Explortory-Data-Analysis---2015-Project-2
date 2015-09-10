### Create plot 1
# Load the data
data<-readRDS('summarySCC_PM25.rds')
# Aggregate the data to show total emissions by year
total_pm25_by_year<-setNames(aggregate(data$Emissions,by=list(data$year),FUN=sum),c('Year', 'PM25'))
# Generate the plot
png(file='plot1.png')
barplot(total_pm25_by_year$PM25/1000000,names=total_pm25_by_year$Year,main='Total US PM25 Emissions by Year',ylim=c(0,8),ylab='Emissions (millions of tons)')
dev.off()