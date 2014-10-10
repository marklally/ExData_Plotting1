#may want to set your working dir here to find the input file
#setwd(<input dir>)

hpc <- read.table("household_power_consumption.txt", sep = ";", skip = 1,
                  na.strings = c("?"), 
                  col.names = c("DateStr", "TimeStr", "Global_active_power", 
                                "Global_reactive_power", "Voltage", "Global_intensity",
                                "Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
                  colClasses = c(rep("character", 2), rep("numeric", 7)))

#subset hpc data to two dates of interest
hpcFilt <- subset(hpc, DateStr == "1/2/2007" | DateStr == "2/2/2007" )
hpcFilt$Date <- as.Date(hpcFilt$DateStr, format = "%d/%m/%Y")
hpcFilt$datetime <- strptime(paste(hpcFilt$DateStr, hpcFilt$TimeStr), 
                         format = "%d/%m/%Y %H:%M:%S")

#may want to set your working dir here to direct the graphics file to a convenient location
#setwd(<output dir>)

with(hpcFilt, plot(datetime, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="" ) )
with(hpcFilt, lines(datetime, Sub_metering_2, col = "red" ))
with(hpcFilt, lines(datetime, Sub_metering_3, col = "blue" ))
legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

dev.copy(png, file="plot3.png")
dev.off()
