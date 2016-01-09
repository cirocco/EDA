# Creating Plot1 - a red-barred histogram.

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

# The meat of making the histogram.
png(filename="plot1.png")
with(house, hist(Global_active_power, Voltage, breaks="Sturges", xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power"))
dev.off()
