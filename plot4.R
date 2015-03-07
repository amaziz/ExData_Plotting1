# Read the firsk 100K lines. They include the data we are looking for
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, nrows = 100000,  stringsAsFactors = FALSE)

# Convert date and Time columns to POSIXlt format
data$FormattedDateTime <- strptime(paste(data$Date, " ", data$Time), format= "%d/%m/%Y %H:%M:%S")

# Filterout unneeded rows
data<- data[data$FormattedDateTime > strptime("2007-02-01", "%Y-%m-%d") & data$FormattedDateTime < strptime("2007-02-03", "%Y-%m-%d") , ]

#Convert characters into numeric values
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)

#Set the plotting area
par(mfrow = c(2,2))

# Draw the topleft plot
plot(y = data$Global_active_power, x =   data$FormattedDateTime, ylab = "Global Active Power", xlab="", type="l")

# Draw the topright plot
plot(y = data$Voltage, x =   data$FormattedDateTime, ylab = "Voltage", xlab="datetime", type="l")

# Draw the bottomleft plot
plot(y = data$Sub_metering_1 , x =   data$FormattedDateTime, ylab = "Energy sub metering", xlab="", type="l", col="black")
lines(y = data$Sub_metering_2 , x =   data$FormattedDateTime, col="red")
lines(y = data$Sub_metering_3 , x =   data$FormattedDateTime, col="blue")
legend("topright", col=c("black", "red", "blue"), legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"), lty=c(1,1,1),  bty = "n")

# Draw the bottomright plot
plot(y = data$Global_reactive_power, x =   data$FormattedDateTime, ylab = "Global_reactive_power", xlab="datetime", type="l")


# Save the plot to png. 
# NOTE: Copying the graph using dev.copy() rendered unexpected results with legend for the third plot. So I opted to recreate it as png
png(file="plot4.png")
par(mfrow = c(2,2))
plot(y = data$Global_active_power, x =   data$FormattedDateTime, ylab = "Global Active Power", xlab="", type="l")
plot(y = data$Voltage, x =   data$FormattedDateTime, ylab = "Voltage", xlab="datetime", type="l")
plot(y = data$Sub_metering_1 , x =   data$FormattedDateTime, ylab = "Energy sub metering", xlab="", type="l", col="black")
lines(y = data$Sub_metering_2 , x =   data$FormattedDateTime, col="red")
lines(y = data$Sub_metering_3 , x =   data$FormattedDateTime, col="blue")
legend("topright", col=c("black", "red", "blue"), legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"), lty=c(1,1,1),  bty = "n")
plot(y = data$Global_reactive_power, x =   data$FormattedDateTime, ylab = "Global_reactive_power", xlab="datetime", type="l")
dev.off()