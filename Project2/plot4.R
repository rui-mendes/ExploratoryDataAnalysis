## Exploratory Data Analysys
## Rui Mendes (ruidamendes@ua.pt)
## Project2
## January 2015

## 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

source('helpers.R')

## Load NEI and SCC datasets
NEI <- loadRDSFile("summarySCC_PM25.rds")
SCC <- loadRDSFile("Source_Classification_Code.rds")

## Check the first elements an summary of the datasets
## print(head(NEI))
## print(summary(NEI))
## print(str(NEI))
## print(head(SCC))
## print(summary(SCC))
## print(str(SCC))

# Find coal combustion-related sources and create the dataframe with the sources
isCombustionCoal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
combustionCoalSources <- SCC[isCombustionCoal,]

# Find emissions from coal combustion-related sources
emissionsFromCoal <- NEI[(NEI$SCC %in% combustionCoalSources$SCC), ]

# group by year
emissionsByYear <- aggregate(Emissions ~ year, data=emissionsFromCoal, FUN=sum)

# plot
library(ggplot2)

## Create png file
png("plot4.png", height=500, width=700)

## Create the plot using ggplot library
emissionsPlot <- ggplot(emissionsByYear, aes(x=factor(year), y=Emissions))
## Heights of the bars to represent values
emissionsPlot <- emissionsPlot + geom_bar(stat="identity", fill="#CCCCCC", colour="black")
## Y and X axis labels
emissionsPlot <- emissionsPlot + xlab("Year")
emissionsPlot <- emissionsPlot + ylab(expression("Total PM"[2.5]*" emission"))
## Title of the graphic
emissionsPlot <- emissionsPlot + ggtitle("Emissions from coal combustion-related sources across USA")
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