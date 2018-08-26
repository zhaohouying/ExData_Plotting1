if(!file.exists("plot3")){
      dir.create("plot3")
}

setwd("./plot3")
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
agg <- aggregate(as.numeric(as.character(bind$Sub_metering_1)),by=list(dd=bind$newwday,hh=bind$newhr,mm=bind$newmin),mean)
order <- agg[with(agg,order(dd,hh,mm)),][4]
newts <- ts(order,frequency = 1440,start=c(4),end=c(6))

agg2 <- aggregate(as.numeric(as.character(bind$Sub_metering_2)),by=list(dd=bind$newwday,hh=bind$newhr,mm=bind$newmin),mean)
order2 <- agg2[with(agg2,order(dd,hh,mm)),][4]
newts2 <- ts(order2,frequency = 1440,start=c(4),end=c(6))

agg3 <- aggregate(as.numeric(as.character(bind$Sub_metering_3)),by=list(dd=bind$newwday,hh=bind$newhr,mm=bind$newmin),mean)
order3 <- agg3[with(agg3,order(dd,hh,mm)),][4]
newts3 <- ts(order3,frequency = 1440,start=c(4),end=c(6))

png(filename="plot3.png")
plot(newts,xaxt="n",xlab="",ylab="Energy Sub metering")
axis(side=1,at=c(4,5,6),labels = c("Thu","Fri","Sat"))
lines(newts2,xaxt="n",xlab="",col="red")
lines(newts3,xaxt="n",xlab="",col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
dev.off()

plot(newts,xaxt="n",xlab="",ylab="Energy Sub metering")
axis(side=1,at=c(4,5,6),labels = c("Thu","Fri","Sat"))
lines(newts2,xaxt="n",xlab="",col="red")
lines(newts3,xaxt="n",xlab="",col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)

setwd("../../")
print("The newly generated plot1.png file is under ./plot3/data")
