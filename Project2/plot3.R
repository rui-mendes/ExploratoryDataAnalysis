## Exploratory Data Analysys
## Rui Mendes (ruidamendes@ua.pt)
## Project2
## January 2015

## 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these 
## four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

source('helpers.R')

## Load NEI and SCC datasets
NEI <- loadRDSFile("summarySCC_PM25.rds")
SCC <- loadRDSFile("Source_Classification_Code.rds")

## Check the first elements of the dataset
## print(head(NEI))