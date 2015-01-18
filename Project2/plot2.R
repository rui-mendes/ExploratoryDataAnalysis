## Exploratory Data Analysys
## Rui Mendes (ruidamendes@ua.pt)
## Project2
## January 2015

## 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
## Use the base plotting system to make a plot answering this question.

source('helpers.R')

## Load NEI dataset
NEI <- loadRDSFile("summarySCC_PM25.rds")

## Check the first elements of the dataset
## print(head(NEI))

## Filter dataset for Baltimore (fips="24510")
bmoreEmissions <- NEI[NEI$fips=="24510",]
# group emissions by year
bmoreEmissionsByYear <- aggregate(Emissions ~ year, bmoreEmissions, sum)

## Force R not to use exponential notation (e.g. e+10)
options("scipen"=100, "digits"=4)

## Create PNG file (for the plot)
png(file="plot2.png", height=400)

## Define Y axis limit
ylim <- c(0, 1.1*max(bmoreEmissionsByYear$Emissions))

## Create the barplot
emissionsPlot <- barplot(height=bmoreEmissionsByYear$Emissions, names.arg=bmoreEmissionsByYear$year,
                         xlab="Years", ylab=expression('Total PM'[2.5]*' emissions'), ylim = ylim, 
                         main=expression('Total PM'[2.5]*' emissions for each year in Baltimore City'), cex.names=1.5,)

## Add values, line and points above each bar
text(x = emissionsPlot, y = bmoreEmissionsByYear$Emissions, label = round(bmoreEmissionsByYear$Emissions, 0), pos = 3, cex = 0.8, col = "brown")
lines(x = emissionsPlot, y = bmoreEmissionsByYear$Emissions, col=4)
points(x = emissionsPlot, y = bmoreEmissionsByYear$Emissions, col=4, pch=16)

## Close file writing
dev.off()
