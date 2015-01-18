## Exploratory Data Analysys
## Rui Mendes (ruidamendes@ua.pt)
## Project1
## January 2014

## Load dataset (in my case the dataset is on the data folder)
data <- read.table("data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

## Check the first 6 rows of teh dataset
#head(data)

## Subset the original dataset from the dates 2007-02-01 and 2007-02-02.
subsetData <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

## Convert the Date and Time variables to Date/Time classes in R
aux <- as.Date(subsetData$Date, format="%d/%m/%Y")
datetime <- strptime(paste(aux, subsetData$Time), format="%Y-%m-%d %H:%M:%S")

## Create the plot with the Sub_metering_1 field
plot(datetime, subsetData$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")

## Add values of Sub_metering_2 field to the graphic 
lines(datetime, subsetData$Sub_metering_2, xlab="", ylab="Energy sub metering", type="l", col="Red")

## Add values of Sub_metering_3 field to the graphic 
lines(datetime, subsetData$Sub_metering_3, xlab="", ylab="Energy sub metering", type="l", col="Blue")

# Place the legend at the appropriate place and put text in it
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("Black", "Red", "Blue"), cex = 0.75, lwd=c(1,1,1), text.col=c("black")) 

## Create the file with the graphic image (to png format)
dev.copy(png, file="plot3.png")
dev.off()