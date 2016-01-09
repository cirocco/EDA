colNames <-names(read.table("household_power_consumption.txt", nrow=1, header=TRUE, sep=";"))
data <- read.table("household_power_consumption.txt", 
        header = FALSE, sep = ";", na.strings = "?", col.names = colNames,
        skip = grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"))-1,
        nrow = grep("3/2/2007", readLines("household_power_consumption.txt"))[1]-grep("1/2/2007", readLines("household_power_consumption.txt"))[1]-1
        # Have to subtract 1 from nrows! Also is 
        # messy because he number of desired entries is hardcoded to the 
        # number of minutes in 2 days (2880) unless we do it programmatically.
        )
data$Date <- as.Date(data$Date)