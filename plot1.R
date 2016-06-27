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

#creating and saving plot as png
png(file="plot1.png")
with(plotdata,hist(Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", col="brown1"))
dev.off()
