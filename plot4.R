install.packages("dplyr")
Sys.setlocale("LC_TIME", "C")

consumptiondata <- read.delim("./data/household_power_consumption.txt", sep = ";")

consumptiondata[consumptiondata == "?"] <- NA

consumptiondata$Date <- as.Date(consumptiondata$Date, format= "%d/%m/%Y")
consumptiondata$Datetime <- strptime(paste(consumptiondata$Date, consumptiondata$Time), format= "%Y-%m-%d %H:%M:%S")

library(dplyr)
twodaysdata <- filter(consumptiondata, Date >= as.Date("2007-02-01"), Date <= as.Date("2007-02-02"))
twodaysdata <- subset(twodaysdata, select = -c(Date, Time))


png(filename = "plot4.png", width = 480, height = 480)

par(mfrow= c(2,2))

plot(twodaysdata$Datetime, twodaysdata$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
plot(twodaysdata$Datetime, twodaysdata$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
with(twodaysdata, plot(Datetime, Sub_metering_1, type="l", xlab = "",ylab = "Energy sub metering"))
with(twodaysdata, lines(Datetime, Sub_metering_2, col= "red"))
with(twodaysdata, lines(Datetime, Sub_metering_3, col= "blue"))
legend("topright", col = c("black", "red", "blue"), bty= "n", lty = 1, cex = 0.75, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(twodaysdata$Datetime, twodaysdata$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()