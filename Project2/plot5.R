## Exploratory Data Analysys
## Rui Mendes (ruidamendes@ua.pt)
## Project2
## January 2015

## 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

source('helpers.R')

## Load NEI dataset
NEI <- loadRDSFile("summarySCC_PM25.rds")

## Check the first elements an summary of the dataset
## print(head(NEI))
## print(summary(NEI))
## print(str(NEI))

## Get Baltimore emissions from motor vehicle sources
bmoreEmissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]

## Aggregate emission values by year 
bmoreEmissionsByYear <- aggregate(Emissions ~ year, data=bmoreEmissions, FUN=sum)

library(ggplot2)

## Create png file
png("plot5.png", height=400, width=500)

## Create the plot using ggplot library
emissionsPlot <- ggplot(bmoreEmissionsByYear, aes(x=factor(year), y=Emissions))
## Heights of the bars to represent values
emissionsPlot <- emissionsPlot + geom_bar(stat="identity", fill="#CCCCCC", colour="black")
## Y and X axis labels
emissionsPlot <- emissionsPlot + xlab("Year")
emissionsPlot <- emissionsPlot + ylab(expression("Total PM"[2.5]*" emission"))
## Title of the graphic
emissionsPlot <- emissionsPlot + ggtitle("Emissions from motor vehicle sources in Baltimore City")
## Add labels above each bar
emissionsPlot <- emissionsPlot + geom_text(aes(label=round(Emissions, 0)), position=position_dodge(width=0.9), vjust=-0.25, size=4)
## Add line
emissionsPlot <- emissionsPlot + geom_line(aes(group=1), colour="#000099")
## Add points above each bar
emissionsPlot <- emissionsPlot + geom_point(size=3, colour="#CC0000")

## Print to the file
print(emissionsPlot)

## Close the file
dev.off()