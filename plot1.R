## For cousera "Exploratory Data Analysis" Project 2
## See full description at https://github.com/haferman/ExData_Project2
##
## move into working directory and download dataset

setwd("~/Z-R/ExData_Project2")
if(!file.exists('NEI_data.zip')){
  url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url,destfile = "NEI_data.zip")
}

## setup files for reading
if(!(file.exists("summarySCC_PM25.rds") && 
     file.exists("Source_Classification_Code.rds"))) { unzip("NEI_data.zip") }

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# aggregate total emissions by year
totals <- aggregate(Emissions ~ year, NEI, sum)

## plot to screen (use BASE plotting system)
barplot(
  (totals$Emissions)/10^6, names.arg=totals$year, xlab="Year",
  ylab="PM2.5 Emissions (Millions of Tons)", main="PM2.5 Emissions From All Sources"
)

# write to png file
png(filename='plot1.png',width=480,height=480,units='px')
barplot(
  (totals$Emissions)/10^6, names.arg=totals$year, xlab="Year",
  ylab="PM2.5 Emissions (Millions of Tons)", main="PM2.5 Emissions From All Sources"
)
dev.off()