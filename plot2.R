##############
# Problem 1 course Exploratory Analysis John Hopkins University - Coursera Course
##############

#NOTE: Execute this script on the same directory where you have extracted the household_power_consumption.txt file.
#Source to download data file: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

#Introduction

#This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. In particular, we will be using the “Individual household electric power consumption Data Set” which I have made available on the course web site:

#Dataset: Electric power consumption [20Mb]

#Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.

#The following descriptions of the 9 variables in the dataset are taken from the UCI web site:

#Date: Date in format dd/mm/yyyy
#Time: time in format hh:mm:ss
#Global_active_power: household global minute-averaged active power (in kilowatt)
#Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#Voltage: minute-averaged voltage (in volt)
#Global_intensity: household global minute-averaged current intensity (in ampere)
#Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
#Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.



##"The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will require in memory before reading into R":
#Supposing all columns are numeric data (probably true, since electric consumption), roughly this amount of memory would be necessary:
	#memBytes <- (2075259 * 9 * 8) # 8 bytes/numeric
	#memGB <- memBytes / (2^30)
	#> memGB
	#[1] 0.139157  #(GB), feasable
	
	#"We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates."

#Reading whole file since the memory utilization is not significant	
#data <- read.table("household_power_consumption.txt", nrow = 5)
#classes <- sapply(data, class)
tabAll <- read.table("household_power_consumption.txt", header=TRUE, na.strings = "?", sep=";", check.names=FALSE, quote='\"', comment.char="", stringsAsFactors=FALSE )
#Notes: #Source: http://cran.r-project.org/doc/contrib/Paradis-rdebuts_en.pdf
	#nrow - the maximum number of lines to read (negative values are ignored)
	#header - a logical (FALSE or TRUE) indicating if the file contains the names of the variables on its first line
	#colClasses - a vector of mode character giving the classes to attribute to the columns
	#na.strings - the value given to missing data
	#sep - the field separator used in the file, for instance sep="\t" if it is a tabulation
	#check.names - if TRUE, checks that the variable names are valid for R
	#quote - the characters used to cite the variables of mode character
	#comment.char - a character defining comments in the data file, the rest of the line after 
		#this character is ignored (to disable this argument, use comment.char = "")
	#quote - the characters used to cite the variables of mode character
 
#Subsetting dates 2007-02-01 and 2007-02-02
dateString <- tabAll$Date
tabAll$Date <- strptime(dateString, "%d/%m/%Y")
data <- tabAll[tabAll$Date >= "2007-02-01" & tabAll$Date <= "2007-02-02", ]
rm(tabAll) #Clear memory

#Create a new column that integrates date + Hours - continuous
datePlusTime <- paste(as.Date(data$Date), data$Time)
data$DatePlusTime <- as.POSIXct(datePlusTime)

#Plot it
#plot(data$Global_active_power~data$Time, type="l", ylab="Global Active Power (kilowatts)", xlab="")
plot(data$Global_active_power~data$DatePlusTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

###"For each plot you should
	#Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
	#Name each of the plot files as plot1.png, plot2.png, etc.
	
#Save it to png
if (!file.exists("plot2.png")) {
	dev.copy(png, file="plot2.png", height=480, width=480)
	dev.off()
}

