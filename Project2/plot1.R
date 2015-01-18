## Exploratory Data Analysys
## Rui Mendes (ruidamendes@ua.pt)
## Project2
## January 2014

## 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
##    Using the base plotting system, make a plot showing the total PM2.5 emission from all 
##    sources for each of the years 1999, 2002, 2005, and 2008.

source('helpers.R')

## Load NEI dataset
NEI <- loadRDSFile("summarySCC_PM25.rds")

## Check the first elements of the dataset
print(head(NEI))

## Calculate the total emissions for each year
totalEmissions <- aggregate(Emissions ~ year, NEI, sum)

## Force R not to use exponential notation (e.g. e+10)
options("scipen"=100, "digits"=4)

## Create PNG file (for the plot)
png(file="plot1.png", height=400)

## Define Y axis limit
ylim <- c(0, 1.1*max(totalEmissions$Emissions))

## Create the barplot
emissionsPlot <- barplot(height=totalEmissions$Emissions, names.arg=totalEmissions$year,
        xlab="Years", ylab=expression('Total PM'[2.5]*' emission'), ylim = ylim, 
        main=expression('Total PM'[2.5]*' emissions for each year'), cex.names=1.5,)

## Add values above each bar
text(x = emissionsPlot, y = totalEmissions$Emissions, label = round(totalEmissions$Emissions, 0), pos = 3, cex = 0.8, col = "brown")
lines(x = emissionsPlot, y = totalEmissions$Emissions, col=4)
points(x = emissionsPlot, y = totalEmissions$Emissions, col=4, pch=16)
dev.off()
