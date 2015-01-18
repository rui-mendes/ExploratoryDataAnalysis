## Exploratory Data Analysys
## Rui Mendes (ruidamendes@ua.pt)
## Project2
## January 2014

loadRDSFile <- function(filename, dataFolder = 'data') {
  dataset <- readRDS(paste(dataFolder, filename, sep = '/'))
  return(dataset)
}