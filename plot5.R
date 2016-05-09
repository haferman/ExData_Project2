## See full description at https://github.com/haferman/ExData_Project2
##
## move into working directory and download dataset

require(ggplot2)
require(dplyr)

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

# extract Baltimore City data for type on-road
balt1 <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
balt2 <- summarise(group_by(balt1, year), Emissions=sum(Emissions))

## plot to screen
barplot(
  (balt2$Emissions), names.arg=balt2$year, xlab="Year",
  ylab="PM2.5 Emissions (Tons)", main="Baltimore Coal PM25 Emissions"
)

# write to png file
png(filename='plot5.png',width=480,height=480,units='px')
barplot(
  (balt2$Emissions), names.arg=balt2$year, xlab="Year",
  ylab="PM2.5 Emissions (Tons)", main="Baltimore Coal PM25 Emissions"
)
dev.off()