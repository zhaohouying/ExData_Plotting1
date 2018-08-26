if(!file.exists("plot2")){
      dir.create("plot2")
}

setwd("./plot2")
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


as.POSIXlt(paste(newdata$Date,newdata$Time))$wday -> newwday
as.POSIXlt(paste(newdata$Date,newdata$Time))$hour -> newhr
as.POSIXlt(paste(newdata$Date,newdata$Time))$min -> newmin

bind <- cbind(newdata,newwday,newhr,newmin)
agg <- aggregate(as.numeric(as.character(bind$Global_active_power)),by=list(dd=bind$newwday,hh=bind$newhr,mm=bind$newmin),max)
order <- agg[with(agg,order(dd,hh,mm)),][4]
newts <- ts(order,frequency = 1440,start=c(4),end=c(6))

png(filename="plot2.png")
plot(newts,xaxt="n",xlab="",ylab="Global Active Power (kilowatts)")
axis(side=1,at=c(4,5,6),labels = c("Thu","Fri","Sat"))
dev.off()

plot(newts,xaxt="n",xlab="",ylab="Global Active Power (kilowatts)")
axis(side=1,at=c(4,5,6),labels = c("Thu","Fri","Sat"))

setwd("../../")
print("The newly generated plot1.png file is under ./plot2/data")

