## Exploratory Data Analysys
## Rui Mendes (ruidamendes@ua.pt)
## Project2
## January 2015

## 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these 
## four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

source('helpers.R')

## Load NEI dataset
NEI <- loadRDSFile("summarySCC_PM25.rds")

## Check the first elements of the dataset
## print(head(NEI))

## Filter dataset for Baltimore (fips="24510")
bmoreEmissions <- NEI[NEI$fips=="24510",]

# Group emissions by year and type of the source
bmoreEmissionsByYearAndType <- aggregate(Emissions ~ year + type, bmoreEmissions, sum)

library(ggplot2)

## Create png file
png("plot3.png", height=500, width=700)

## Create the plot using ggplot library
emissionsPlot <- ggplot(bmoreEmissionsByYearAndType, aes(x=factor(year), y=Emissions, fill=type))
## Heights of the bars to represent values
emissionsPlot <- emissionsPlot + geom_bar(stat="identity")
## Make a grid separated by type
emissionsPlot <- emissionsPlot + facet_grid(. ~ type)
## Y and X axis labels
emissionsPlot <- emissionsPlot + xlab("Year")
emissionsPlot <- emissionsPlot + ylab(expression("Total PM"[2.5]*" emission"))
## Title of the graphic
emissionsPlot <- emissionsPlot + ggtitle(expression("PM"[2.5]*" emissions in Baltimore City by source types (point, nonpoint, onroad, nonroad)"))
## Change legend title
emissionsPlot <- emissionsPlot + scale_fill_discrete(name = "Source type")
## Print to the file
print(emissionsPlot)

## Close the file
dev.off()