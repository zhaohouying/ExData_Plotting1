if(!file.exists("plot1")){
      dir.create("plot1")
}

setwd("./plot1")
getwd()

print("Please wait for the zip file to be downloaded......")
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile="./power_consumption.zip")


unzip(zipfile = "./power_consumption.zip",exdir = "./data")

setwd("./data")

mytable <- read.table("household_power_consumption.txt",sep=";",header=TRUE)
mytable$Date <- as.Date(mytable$Date,"%d/%m/%Y")
startdate <- as.Date("2007-02-01")
enddate <- as.Date("2007-02-02")
newdata <- mytable[which(mytable$Date>=startdate & mytable$Date<=enddate),]
png(filename="plot1.png")
hist(as.numeric(as.character(newdata$Global_active_power)),col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()
hist(as.numeric(as.character(newdata$Global_active_power)),col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")

setwd("../../")
print("The newly generated plot1.png file is under ./plot1/data")
