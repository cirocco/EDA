# Creating Plot2 - a line plot charting time against global active power in kilowatts.

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

# The meat of making the line graph.
png(filename="plot2.png", width=480, height=480)
with(house, plot(Date, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()