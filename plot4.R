## Exploratory Data Analysis / Course Project 1
## @author Erick J. Elizalde Figueroa
## IMPORTANT: To run this script correctly you must have downloaded
## and unziped the txt dataset at the working directory.

## Plot 4

## Constants
fds = "household_power_consumption.txt" 
fncols = 9
fnrows = 2075259
meml = memory.limit()
mems = memory.size()

## Calculate memory required for the dataset in MB
fmem = ((fncols*fnrows)*8)/2^20
avlmem = meml - mems

## Get the memory size of enviroment
if(avlmem < fmem ) {  stop("The data file is too big for the available memory!") } 

## Load the data
dt <- read.table(	fds, 
                  header = TRUE, 
                  sep = ";", 
                  na.strings = "?", 
                  nrows = fnrows, 
                  comment.char="")

## Subset obs. with dates 2007-02-01 and 2007-02-02
dt <- dt[grep("^[1-2]/2/2007", dt$Date),]

## Create a new variable with the Date and Time variables
dt$DateTime <- strptime(paste(dt$Date,dt$Time), "%d/%m/%Y %H:%M:%S")

## Format Date variable
dt$Date <- as.Date(dt$Date , "%d/%m/%Y")

## Generate the plot
par(mar=c(2,2,2,2))
par(mfrow=c(2,2))
plot(	dt$DateTime, 
      dt$Global_active_power, 
      type="l", 
      xlab= "", 
      ylab = "Global Active Power (kilowatts)")

plot(dt$DateTime, 
     dt$Voltage, type="l", 
     xlab= "datetime", ylab = "Voltage")

plot(	dt$DateTime, 
      dt$Sub_metering_1, 
      type="l", xlab= "", 
      ylab = "Energy sub metering")
lines(dt$DateTime, dt$Sub_metering_2, type="l", col="red")
lines(dt$DateTime, dt$Sub_metering_3, type="l", col="blue")
legend("topright", 
       c("Sub_metering_1",
         "Sub_metering_2",
         "Sub_metering_3"), 
       col=c("black", "red", "blue"), box.col=NA, 
       lty=1, cex=0.5)

plot(dt$DateTime, 
           dt$Global_reactive_power, 
           type="l", xlab= "datetime", 
           ylab = "Global_reactive_power")

## Save the plot as a png file.
dev.copy(png,'plot4.png', width=480, height=480)
dev.off()
