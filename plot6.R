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

# extract Baltimore and L.A. data for type on-road
balt <- summarise(group_by(filter(NEI, fips == "24510"& type == 'ON-ROAD'), 
                           year), Emissions=sum(Emissions))
balt$County <- "Baltimore City"

lax <- summarise(group_by(filter(NEI, fips == "06037"& type == 'ON-ROAD'), 
                          year), Emissions=sum(Emissions))
lax$County <- "Los Angeles"

# combine data
losdos <- rbind(balt, lax)

## plot to screen
fig <- ggplot(losdos, aes(x=factor(year), y=(Emissions)/10^3, group=County,
         color=County)) + geom_line() +
         geom_point( size=3, shape=20) +
         xlab("Year") + ylab("PM2.5 Emissions (kilotons)") + 
         ggtitle("PM2.5 Emissions Baltimore vs L.A.")
print(fig)

# write to png file
ggsave(file="plot6.png")