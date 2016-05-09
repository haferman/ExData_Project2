## For cousera "Exploratory Data Analysis" Project 2
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

# extract coal data from SCC
coal1 <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
coal2 <- SCC[coal1,]
coal3 <- NEI[(NEI$SCC %in% coal2$SCC), ]
coal4 <- summarise(group_by(coal3, year), Emissions=sum(Emissions))

## plot to screen
barplot(
  (coal4$Emissions)/10^6, names.arg=coal4$year, xlab="Year",
  ylab="PM2.5 Emissions (Millions of Tons)", main="U.S. Coal PM25 Emissions"
)

# write to png file
png(filename='plot4.png',width=480,height=480,units='px')
barplot(
  (coal4$Emissions)/10^6, names.arg=coal4$year, xlab="Year",
  ylab="PM2.5 Emissions (Millions of Tons)", main="U.S. Coal PM25 Emissions"
)
dev.off()