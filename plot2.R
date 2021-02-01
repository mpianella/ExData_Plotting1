install.packages("dplyr")
Sys.setlocale("LC_TIME", "C")

consumptiondata <- read.delim("./data/household_power_consumption.txt", sep = ";")

consumptiondata[consumptiondata == "?"] <- NA

consumptiondata$Date <- as.Date(consumptiondata$Date, format= "%d/%m/%Y")
consumptiondata$Datetime <- strptime(paste(consumptiondata$Date, consumptiondata$Time), format= "%Y-%m-%d %H:%M:%S")

library(dplyr)
twodaysdata <- filter(consumptiondata, Date >= as.Date("2007-02-01"), Date <= as.Date("2007-02-02"))
twodaysdata <- subset(twodaysdata, select = -c(Date, Time))

png(filename = "plot2.png", width = 480, height = 480)

plot(twodaysdata$Datetime, twodaysdata$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()