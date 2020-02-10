Timing <- paste(Power_consumption$Date, Power_consumption$Time)
Power_consumption <- Power_consumption[ ,!(names(Power_consumption) %in% c("Date","Time"))]
Power_consumption <- cbind(Timing, Power_consumption)
Power_consumption$Timing <- as.POSIXct(Timing)
png("plot2.png", width = 480, height = 480)
plot(Power_consumption$Global_active_power ~ Power_consumption$Timing, xlab = ""
     ,ylab = "Global Active Power(kilowatts)", type = "l")
dev.off()
