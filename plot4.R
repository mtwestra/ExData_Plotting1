# Creates a PNG plot of electricity usage of a household over a two day period on 1-2-2007 and 2-2-2007
# Figures inluced are:
# * datetime versus global active power
# * datetime versus submetering
# * datetime versus voltage
# * datatime versus Global reactive power
#
# Part of the Exploratory Data Analysis Coursera course
# source data:  UC Irvine Machine Learning Repository, “Individual household electric power consumption Data Set”

# donwload and load in data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
elec = read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE, na.strings=c("?"),as.is = c("Date","Time"))
unlink(temp)

# select two days 
elecTwoDays <- subset(elec, Date == "1/2/2007" | Date == "2/2/2007" )

# combine date and time into single POSIXct datetime column
elecTwoDays <- within(elecTwoDays,{datetime = as.POSIXct(paste(elecTwoDays$Date, elecTwoDays$Time), format="%d/%m/%Y %H:%M:%S")})

# open PNG file
png(filename = "plot4.png",width = 480, height = 480)

# specify grid of 2 by 2, to be filled col first
par(mfcol=c(2,2))

# plot 1
plot(elecTwoDays$datetime,elecTwoDays$Global_active_power,xlab = "",ylab="Global Active Power (kilowatts)",type="n")
lines(elecTwoDays$datetime,elecTwoDays$Global_active_power)

# plot 2
plot(elecTwoDays$datetime,elecTwoDays$Sub_metering_1,xlab = "",ylab="Energy sub metering",type="n")
lines(elecTwoDays$datetime,elecTwoDays$Sub_metering_1)
lines(elecTwoDays$datetime,elecTwoDays$Sub_metering_2,col="red")
lines(elecTwoDays$datetime,elecTwoDays$Sub_metering_3,col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))

# plot 3
plot(elecTwoDays$datetime,elecTwoDays$Voltage,xlab = "datetime",ylab="Voltage",type="n")
lines(elecTwoDays$datetime,elecTwoDays$Voltage)

# plot 4
plot(elecTwoDays$datetime,elecTwoDays$Global_reactive_power,xlab = "datetime",ylab="Global_reactive_power",type="n")
lines(elecTwoDays$datetime,elecTwoDays$Global_reactive_power)

# close and write file
dev.off()
