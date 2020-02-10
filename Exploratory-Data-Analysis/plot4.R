png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
plot(Power_consumption$Global_active_power ~ Power_consumption$Timing, xlab = ""
       ,ylab = "Global Active Power", type = "l")
plot(Power_consumption$Voltage ~ Power_consumption$Timing, xlab = "datetime", ylab = "Voltage",
       type = "l")
plot(Power_consumption$Sub_metering_1 ~ Power_consumption$Timing, type = "l", xlab = "", ylab = "Energy sub metering")
lines(Power_consumption$Sub_metering_2 ~ Power_consumption$Timing, col = "red")
lines(Power_consumption$Sub_metering_3 ~ Power_consumption$Timing, col = "blue")
legend("topright", bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2, col = c("black", "red", "blue"), cex = 0.75)
plot(Power_consumption$Global_reactive_power ~ Power_consumption$Timing, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
dev.off()
