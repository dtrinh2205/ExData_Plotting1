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
png(file="plot2.png")
with(plotdata, plot(x=DateTime,y=Global_active_power,
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab=""))
dev.off()
