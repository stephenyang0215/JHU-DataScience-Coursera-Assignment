Power_consumption <- read.csv("/Users/apple/Downloads/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
Power_consumption$Date <- as.Date(Power_consumption$Date, "%d/%m/%Y")
Power_consumption <- Power_consumption[(Power_consumption$Date=="2007-02-01")|(Power_consumption$Date=="2007-02-02"),]
#1
png("plot1.png", width = 480, height = 480)
hist(Power_consumption$Global_active_power, main = "Global Active Power"
     , xlab = "Global Active Power (kilowatts)", col = "red", xlim = c(0, 6))
dev.off()
