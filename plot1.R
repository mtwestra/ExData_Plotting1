# Plots histogram of electricity consumption of a household
# Part of the Exploratory Data Analysis
# source data:  UC Irvine Machine Learning Repository, “Individual household electric power consumption Data Set”

# read in data (assumed to be in folder /data)
elec = read.table("./data/household_power_consumption.txt", sep=";", header=TRUE, na.strings=c("?"),as.is = c("Date","Time"))

# select two days 
elecTwoDays <- subset(elec, Date == "1/2/2007" | Date == "2/2/2007" )

# combine date and time into single POSIXct datetime column
elecTwoDays <- within(elecTwoDays,{datetime = as.POSIXct(paste(elecTwoDays$Date, elecTwoDays$Time), format="%d/%m/%Y %H:%M:%S")})

# create histogram plot
png(filename = "plot1.png",width = 480, height = 480)
hist(elecTwoDays$Global_active_power,col="red", xlab="Global Active Power (kilowatts)",main="Global Active Power",ylab="Frequency")
dev.off()
