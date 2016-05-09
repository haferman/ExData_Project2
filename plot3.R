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

# get Baltimore City MD data (fips = "24510")
balt <- subset(NEI, fips == "24510")
balt_totals <- summarise(group_by(balt, year,type), 
                         Emissions=sum(Emissions))

## plot to screen (use GGPLOT2 plotting system)
fig <- ggplot(balt_totals, aes(x=factor(year), y=Emissions, group=type, 
         color=type)) + geom_line() + 
         geom_point( size=3, shape=20) +
         xlab("Year") + ylab("PM2.5 Emissions (tons)") + 
         ggtitle("Baltimore PM2.5 Emissions by Source")
print(fig)

# write to png file
ggsave(file="plot3.png")