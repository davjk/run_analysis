## The aim of this code is to reconstruct given plots using the base plotting 
## system. The code file should include code for reading the data so that the plot
## can be fully reproduced. It should then Construct the plot and save it to a PNG 
## file with a width of 480 pixels and a height of 480 pixels.


## get data
dataAll <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                      na.strings = "?", colClasses = c("character", "character", rep("numeric", 7)))

## subset required dates
data <- dataAll[dataAll$Date == "1/2/2007" | dataAll$Date == "2/2/2007", ]

## create new column with date and time in correct format
data$Timestamp <- strptime(paste(data[,1],data[,2]), "%d/%m/%Y %H:%M")

## Create plot using matching parameters to given plot
plot(data$Timestamp, data$Sub_metering_1, type = "n", xlab = "",
     ylab = "Energy sub metering")
points(data$Timestamp,data$Sub_metering_1, type="l")
points(data$Timestamp,data$Sub_metering_2, type="l", col="red")
points(data$Timestamp,data$Sub_metering_3, type="l", col="blue")
legend("topright", pch="-", col = c("black", "red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## create png file to required specifications
dev.copy(png, file = "plot3.png", width=480, height=480)
dev.off() 

