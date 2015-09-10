### Create plot 6
# Load dplyr and ggplot2 libraries
require(dplyr)
require(ggplot2)
# Read in the data and source classification files
scc <- readRDS('Source_Classification_Code.rds')
data <- readRDS('summarySCC_PM25.rds')
# Subset scc by choosing only rows containing " Vehicles"
# This grabs all the sources within the Mobile category
# that refer to motor vehicles. See the Basic Information page
# for the data set: http://www.epa.gov/air/emissions/basic.htm
scc_vehicles <- scc[grepl(" Vehicles", scc$EI.Sector), ]
# Convert SCC column in Sources to character, to match the column
# type in the data file. This prevents a warning over automatic coercion.
scc_vehicles$SCC <- as.character(scc_vehicles$SCC)
# Now merge the scc_coal and data files
mdata <- inner_join(data, scc_vehicles)
# Subset the data by choosing only rows with fips==24510 (Baltimore City)
# or fips==06037 (Los Angeles County)
mdata <- mdata[mdata$fips == '24510' | mdata$fips == '06037', ]
# Aggregate the total emissions by year and fips
mdata_vehicles <- setNames(aggregate(mdata$Emissions, by=list(mdata$year, mdata$fips), FUN=sum), c('Year', 'Location', 'Emissions'))
# Replace the FIPS code with the name for each of the two locations 
mdata_vehicles$Location <- replace(mdata_vehicles$Location, mdata_vehicles$Location == '06037', 'Los Angeles County')
mdata_vehicles$Location <- replace(mdata_vehicles$Location, mdata_vehicles$Location == '24510', 'Baltimore City')
# Normalize the Emissions data by Location in a new column, so the emphasis
# of the plot is on the change over time, rather than on the order-of-
# magnitude difference in Emissions levels between these two locations.
# The method used is called normalizing with the norm, which is dicussed
# in this paper: https://www.utdallas.edu/~herve/abdi-Normalizing2010-pretty.pdf
mdata_vehicles <- mdata_vehicles %>% group_by(Location) %>% mutate(norm_Emissions = Emissions / sqrt(sum(Emissions ^ 2)))
# Finally, generate the plot
png('plot6.png')
g <- ggplot(mdata_vehicles, aes(x=factor(Year), y=norm_Emissions))
print(g + geom_bar(stat='identity') + facet_wrap(~ Location) + xlab('Year') + ylab('Emissions (normalized)') + ggtitle('Change in Motor Vehicle PM25 Emissions Over Time'))
dev.off()