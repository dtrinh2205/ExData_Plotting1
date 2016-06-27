#setting up inputs and loading libraries
input <- "~/Desktop/Coursera/Exploratory Data Analysis/Course Project 1"
library(dplyr)
library(lubridate)

setwd(input)
#Reading in data
data <- read.table("household_power_consumption.txt", header=TRUE, 
                   na.strings="?", sep=";")

#limit data to 2007-02-01 and 2007-02-02
data$Date <- as.Date(data$Date, "%d/%m/%Y")
plotdata <- filter(data, Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))

#converting to date time
plotdata$DateTime <- paste(as.character(plotdata$Date), plotdata$Time)
plotdata$DateTime <- parse_date_time(plotdata$DateTime, "Ymd HMS")

#creating and saving plot as png
png(file="plot4.png")
par(mfrow=c(2,2))
#plot1
with(plotdata, plot(x=DateTime,y=Global_active_power,
                    type="l",
                    ylab="Global Active Power",
                    xlab=""))

#plot2
with(plotdata, plot(x=DateTime,y=Voltage,
                    type="l",
                    ylab="Voltage",
                    xlab="datetime"))

#plot3
with(plotdata,plot(x=DateTime,
                   y=Sub_metering_1,
                   type="n",
                   ylab="Energy sub metering",
                   xlab=""))
with(plotdata, lines(x=DateTime,
                     y=Sub_metering_1, col=1))
with(plotdata, lines(x=DateTime,
                     y=Sub_metering_2, col=2))
with(plotdata, lines(x=DateTime,
                     y=Sub_metering_3, col=4))
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1),
       col=c(1,2,4))

#plot4
with(plotdata, plot(x=DateTime,y=Global_reactive_power,
                    type="h",
                    ylab="Global_reactive_power",
                    xlab="datetime"))
with(plotdata, points(x=DateTime, y=Global_reactive_power, pch=21, cex=0.15))
dev.off()
