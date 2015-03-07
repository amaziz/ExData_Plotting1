# Read the firsk 100K lines. They include the data we are looking for
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, nrows = 100000,  stringsAsFactors = FALSE)

# Convert date and Time columns to POSIXlt format
data$FormattedDateTime <- strptime(paste(data$Date, " ", data$Time), format= "%d/%m/%Y %H:%M:%S")

# Filterout unneeded rows
data<- data[data$FormattedDateTime > strptime("2007-02-01", "%Y-%m-%d") & data$FormattedDateTime < strptime("2007-02-03", "%Y-%m-%d") , ]

#Convert characters into numeric values
data$Global_active_power <- as.numeric(data$Global_active_power)

# Draw the Global_active_power on y-axis against the date on x-axis with y-label and empty x-label
plot(y = data$Global_active_power, x =   data$FormattedDateTime, ylab = "Global Active Power (kilowatts)", xlab="", type="l")

# Save the plot to png
dev.copy(png, file="plot2.png")
dev.off()