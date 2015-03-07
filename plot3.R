# Read the firsk 100K lines. They include the data we are looking for
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, nrows = 100000,  stringsAsFactors = FALSE)

# Convert date and Time columns to POSIXlt format
data$FormattedDateTime <- strptime(paste(data$Date, " ", data$Time), format= "%d/%m/%Y %H:%M:%S")

# Filterout unneeded rows
data<- data[data$FormattedDateTime > strptime("2007-02-01", "%Y-%m-%d") & data$FormattedDateTime < strptime("2007-02-03", "%Y-%m-%d") , ]

#Convert characters into numeric values
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)


# Draw the sub_metering_1 on y-axis against the date on x-axis with y-label and empty x-label
plot(y = data$Sub_metering_1 , x =   data$FormattedDateTime, ylab = "Energy sub metering", xlab="", type="l", col="black")

# Add a red line with the sub_metering_2 on y-axis against the date on x-axis with y-label
lines(y = data$Sub_metering_2 , x =   data$FormattedDateTime, col="red")

# Add a red line with the sub_metering_3 on y-axis against the date on x-axis with y-label
lines(y = data$Sub_metering_3 , x =   data$FormattedDateTime, col="blue")

#Add the legend on the top right with extended lines
legend("topright", col=c("black", "red", "blue"), legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"), lty=c(1,1,1))

# Save the plot to png. 
# NOTE: Copying the graph using dev.copy() rendered unexpected results with the legend. So I opted to recreate it as png
png(file="plot3.png")
plot(y = data$Sub_metering_1 , x =   data$FormattedDateTime, ylab = "Energy sub metering", xlab="", type="l", col="black")
lines(y = data$Sub_metering_2 , x =   data$FormattedDateTime, col="red")
lines(y = data$Sub_metering_3 , x =   data$FormattedDateTime, col="blue")
legend("topright", col=c("black", "red", "blue"), legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"), lty=c(1,1,1))
dev.off()