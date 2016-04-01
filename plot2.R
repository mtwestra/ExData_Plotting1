# Creates a PNG plot of electricity usage of a household over a two day period on 1-2-2007 and 2-2-2007

# Part of the Exploratory Data Analysis
# source data:  UC Irvine Machine Learning Repository, “Individual household electric power consumption Data Set”

# read in data (assumed to be in folder /data)
elec = read.table("./data/household_power_consumption.txt", sep=";", header=TRUE, na.strings=c("?"),as.is = c("Date","Time"))

# select two days 
elecTwoDays <- subset(elec, Date == "1/2/2007" | Date == "2/2/2007" )

# combine date and time into single POSIXct datetime column
elecTwoDays <- within(elecTwoDays,{datetime = as.POSIXct(paste(elecTwoDays$Date, elecTwoDays$Time), format="%d/%m/%Y %H:%M:%S")})

# open PNG file
png(filename = "plot2.png",width = 480, height = 480)

# create datetime versus global active power plot
plot(elecTwoDays$datetime,elecTwoDays$Global_active_power,xlab = "",ylab="Global Active Power (kilowatts)",type="n")
lines(elecTwoDays$datetime,elecTwoDays$Global_active_power)

# close and write file
dev.off()
