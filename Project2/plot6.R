## Exploratory Data Analysys
## Rui Mendes (ruidamendes@ua.pt)
## Project2
## January 2015

## 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
## sources in Los Angeles County, California (fips == 06037).
## Which city has seen greater changes over time in motor vehicle emissions?

source('helpers.R')

## Load NEI dataset
NEI <- loadRDSFile("summarySCC_PM25.rds")

## Check the first elements an summary of the dataset
## print(head(NEI))
## print(summary(NEI))
## print(str(NEI))

# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips ==
# "06037"). Which city has seen greater changes over time in motor vehicle
# emissions?

normalize <- function(x) {(x-min(x)) / (max(x)-min(x))}

# Get Baltimore emissions from motor vehicle sources
bmoreEmissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
bmoreEmissionsByYear <- aggregate(Emissions ~ year, data=bmoreEmissions, FUN=sum)

# Get Los Angeles emissions from motor vehicle sources
laEmissions <- NEI[(NEI$fips=="06037") & (NEI$type=="ON-ROAD"),]
laEmissionsByYear <- aggregate(Emissions ~ year, data=laEmissions, FUN=sum)

bmoreEmissionsByYear$County <- "Baltimore City, MD"
laEmissionsByYear$County <- "Los Angeles County, CA"
AllEmissions <- rbind(bmoreEmissionsByYear, laEmissionsByYear)

library(ggplot2)

## Create png file
png("plot6.png", height=600, width=700)

## Create the plot using ggplot library
## Note: it is important to define ymax so the bars can be compared on the same scale
emissionsPlot <- ggplot(AllEmissions, aes(x=factor(year), y=Emissions, fill=County, ymax=max(Emissions)*1.05))
## Heights of the bars to represent values
emissionsPlot <- emissionsPlot + geom_bar(stat="identity")
## Make a grid separated by County
emissionsPlot <- emissionsPlot + facet_grid(County  ~ ., scales="free")
## Y and X axis labels
emissionsPlot <- emissionsPlot + xlab("Year")
emissionsPlot <- emissionsPlot + ylab(expression("Total PM"[2.5]*" emission"))
## Title of the graphic
emissionsPlot <- emissionsPlot + ggtitle("Motor vehicle emissions variation in Baltimore and Los Angeles")
## Add labels above each bar
emissionsPlot <- emissionsPlot + geom_text(aes(label=round(Emissions, 0)), position=position_dodge(width=0.9), vjust=-0.25, size=3)

## Print to the file
print(emissionsPlot)

## Close the file
dev.off()