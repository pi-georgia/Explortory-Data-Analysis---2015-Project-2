### Create plot 3
# Load ggplot2 library
require(ggplot2)
# Load the data
data<-readRDS('summarySCC_PM25.rds')
# Subset the data for Baltimore City only
data_balt_city <- data[data$fips==24510,]
# Aggregate the data by year and type
data_balt_city_by_type<-setNames(aggregate(data_balt_city$Emissions,by=list(data_balt_city$year, data_balt_city$type),FUN=sum),c('Year','Type','Emissions'))
# Generate the plot
png(file='plot3.png')
g<-ggplot(data_balt_city_by_type,aes(x=factor(Year),y=Emissions/1000))
print(g + geom_bar(stat='identity') + facet_wrap(~Type) + xlab('Year') + ylab('Emissions (thousands of tons)') + ggtitle('Baltimore City PM25 Emissions by Type'))
dev.off()