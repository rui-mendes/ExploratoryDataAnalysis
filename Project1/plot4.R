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

## Set mfrow graphical parameter to be 2x2 dimension for plotting 4 graphics in the same window
par(mfrow=c(2,2))

## Plot 1st graphich (Global_active_power field)
plot(datetime, subsetData$Global_active_power, xlab="", ylab="Global Active Power", type="l")

## Plot 2nd graphich (Voltage field)
plot(datetime, subsetData$Voltage, ylab="Voltage", type="l")

## Plot 3rd graphich (Sub_metering_1 field)
plot(datetime, subsetData$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
## Add points to 3rd graphich (Sub_metering_2 field)
lines(datetime, subsetData$Sub_metering_2, xlab="", type="l", col="Red")
## Add points to 3rd graphich (Sub_metering_3 field)
lines(datetime, subsetData$Sub_metering_3, xlab="", type="l", col="Blue")
# Place the legend at the appropriate place and put text in it (in 3rd Graphic)
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("Black", "Red", "Blue"), cex = 0.5, lwd=c(1,1,1), bty="n", y.intersp = 0.9) 

## Plot 4th graphich (Global_reactive_power field)
plot(datetime, subsetData$Global_reactive_power, ylab="Global_reactive_power", type="l")

## Create the file with the graphics image (to png format)
dev.copy(png, file="plot4.png")
dev.off()
