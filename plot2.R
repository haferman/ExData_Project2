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

# get Baltimore City MD data (fips = "24510")
balt <- subset(NEI, fips == "24510")
balt_totals <- aggregate(Emissions ~ year, balt, sum)

## plot to screen (use BASE plotting system)
barplot(
  (balt_totals$Emissions)/10^3, names.arg=balt_totals$year, xlab="Year",
  ylab="PM2.5 Emissions (Thousands of Tons)", main="PM2.5 Emissions Baltimore City MD"
)

# write to png file
png(filename='plot2.png',width=480,height=480,units='px')
barplot(
  (balt_totals$Emissions)/10^3, names.arg=balt_totals$year, xlab="Year",
  ylab="PM2.5 Emissions (Thousands of Tons)", main="PM2.5 Emissions Baltimore City MD"
)
dev.off()