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
png( 'plot4.png', width = 480, height = 480 )
par(mfcol=c(2,2))
# first graph from plot2
plot(hpc$Date_Time, hpc$Global_active_power, type='l', xlab = '', ylab = 'Global Active Power')
#second graph from plot 3
plot(hpc$Date_Time, hpc$Sub_metering_1, type = 'l', xlab = '', ylab = 'Energy sub metering')
lines(hpc$Date_Time, hpc$Sub_metering_2, type = 'l', col = 'red' )
lines(hpc$Date_Time, hpc$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', lty = c(1, 1, 1), col = c('black', 'blue', 'red'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3') )
#third graph
plot(hpc$Date_Time, hpc$Voltage, type='l', xlab = 'datetime', ylab = 'Voltage')
#fouth graph
plot(hpc$Date_Time, hpc$Global_reactive_power, type='l', xlab = 'datetime', ylab = 'Global_reactive_power')
dev.off()

## delete files from directory
unlink(fileName)
unlink(zipFileName)