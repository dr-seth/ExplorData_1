## install necessary packages

## load necessary packages

## URL for data on course repository
fileURL <- c("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")

if (!file.exists("~/R-wd/ExploratoryDataAnalysis/Week1/household_power_consumption.txt")) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, destfile = "/Users/ssdobr/R-wd/ExploratoryDataAnalysis/Week1/household_power_consumption.zip")
  unzip("~/R-wd/ExploratoryDataAnalysis/Week1/household_power_consumption.zip")
  date = Sys.Date()
}

## store filename and path as varriable
fileName <- "~/R-wd/ExploratoryDataAnalysis/Week1/household_power_consumption.txt"
zipFileName <- "~/R-wd/ExploratoryDataAnalysis/Week1/household_power_consumption.zip"

#read the data into R, save, and remove source file
hpc <- read.table(fileName, header = TRUE, sep = ';', na.strings = '?')

# recode dates and times
hpc$Date <- as.Date (hpc$Date, '%d/%m/%Y' )
hpc <- subset( hpc, Date == '2007-02-01' | Date == '2007-02-02' ) 
hpc$Date_Time <- strptime(paste(hpc$Date, hpc$Time), format="%Y-%m-%d %H:%M:%S")

## save plot to png
png( 'plot2.png', width = 480, height = 480 )
plot(hpc$Date_Time, hpc$Global_active_power, type='l', xlab = '', ylab = 'Global Active Power (kilowatts)')
dev.off()

## delete files from directory
unlink(fileName)
unlink(zipFileName)