# Creating Plot 4 - 4 Plots in 2 columns, 2 rows.

# Download the file and unzip it.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "file.zip", mode="wb")
unzip("file.zip")

# Get the column names.
colNames <-names(read.table("household_power_consumption.txt", nrow=1, header=TRUE, sep=";"))
house <- read.table("household_power_consumption.txt", 
                    header = FALSE, sep = ";", na.strings = "?", col.names = colNames,
                    skip = grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"))-1,
                    nrow = grep("3/2/2007", readLines("household_power_consumption.txt"))[1]-grep("1/2/2007", readLines("household_power_consumption.txt"))[1]-1
                    # Have to subtract 1 from nrows! Was originally messy because 
                    # the number of desired entries wass hardcoded to the 
                    # number of minutes in 2 days (2880-1) unless done programmatically.
)

# Adjust the date/time. 
house$Date <- with(house, strptime(paste(Date, Time, sep=" "), format="%d/%m/%Y %H:%M:%S"))

# Graph [1,1] Date vs Global Active Power
with(house, plot(Date, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

#Graph [1,2] Date vs Voltage - labeled in the x axis
with(house, plot(Date, Voltage, type="l", xlab="datetime", ylab="Voltage"))

# Graph [2,1] Date vs Energy sub metering, w/a legend
with(house, plot(Date, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(house, lines(Date, Sub_metering_2, col="red"))
with(house, lines(Date, Sub_metering_3, col="blue"))
legend("topright", pch = "-", lwd=2, cex=0.75, col = c("black", "blue", "red"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Graph [2,2] datetime vs Global reactive power
with(house, plot(Date, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
