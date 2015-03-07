# Read the firsk 100K lines. They include the data we are looking for
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, nrows = 100000,  stringsAsFactors = FALSE)

# Convert date and Time columns to POSIXlt format
data$FormattedDateTime <- strptime(paste(data$Date, " ", data$Time), format= "%d/%m/%Y %H:%M:%S")

# Filterout unneeded rows
data<- data[data$FormattedDateTime > strptime("2007-02-01", "%Y-%m-%d") & data$FormattedDateTime < strptime("2007-02-03", "%Y-%m-%d") , ]

#Convert characters into numeric values
data$Global_active_power <- as.numeric(data$Global_active_power) 

# Draw a histogram for Global Active Power, color is red, add main title and x-label
hist(x = data$Global_active_power, xlab = "Global Active Power (kilowatts)", col="red", main="Global Active Power")

# Save the plot to png
dev.copy(png, file="plot1.png")
dev.off()