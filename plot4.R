if(!file.exists("plot4")){
      dir.create("plot4")
}

setwd("./plot4")
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

#Global Active Power
aagg <- aggregate(as.numeric(as.character(bind$Global_active_power)),by=list(dd=bind$newwday,hh=bind$newhr,mm=bind$newmin),max)
aorder <- aagg[with(aagg,order(dd,hh,mm)),][4]
anewts <- ts(aorder,frequency = 1440,start=c(4),end=c(6))

#Voltage
vagg <- aggregate(as.numeric(as.character(bind$Voltage)),by=list(dd=bind$newwday,hh=bind$newhr,mm=bind$newmin),mean)
vorder <- vagg[with(vagg,order(dd,hh,mm)),][4]
vnewts <- ts(vorder,frequency = 1440,start=c(4),end=c(6))

#Energy Sub metering
eagg <- aggregate(as.numeric(as.character(bind$Sub_metering_1)),by=list(dd=bind$newwday,hh=bind$newhr,mm=bind$newmin),mean)
eorder <- eagg[with(eagg,order(dd,hh,mm)),][4]
enewts <- ts(eorder,frequency = 1440,start=c(4),end=c(6))

eagg2 <- aggregate(as.numeric(as.character(bind$Sub_metering_2)),by=list(dd=bind$newwday,hh=bind$newhr,mm=bind$newmin),mean)
eorder2 <- eagg2[with(eagg2,order(dd,hh,mm)),][4]
enewts2 <- ts(eorder2,frequency = 1440,start=c(4),end=c(6))

eagg3 <- aggregate(as.numeric(as.character(bind$Sub_metering_3)),by=list(dd=bind$newwday,hh=bind$newhr,mm=bind$newmin),mean)
eorder3 <- eagg3[with(eagg3,order(dd,hh,mm)),][4]
enewts3 <- ts(eorder3,frequency = 1440,start=c(4),end=c(6))

#Global Reactive Power

ragg <- aggregate(as.numeric(as.character(bind$Global_reactive_power)),by=list(dd=bind$newwday,hh=bind$newhr,mm=bind$newmin),max)
rorder <- ragg[with(ragg,order(dd,hh,mm)),][4]
rnewts <- ts(rorder,frequency = 1440,start=c(4),end=c(6))




png(filename="plot4.png")
par(mfrow=c(2,2))
#Global Active Power
plot(anewts,xaxt="n",xlab="",ylab="Global Active Power (kilowatts)")
axis(side=1,at=c(4,5,6),labels = c("Thu","Fri","Sat"))
#Voltage
plot(vnewts,xaxt="n",xlab="datetime",ylab="Voltage")
axis(side=1,at=c(4,5,6),labels = c("Thu","Fri","Sat"))

#Energy Sub metering
plot(enewts,xaxt="n",xlab="",ylab="Energy Sub metering")
axis(side=1,at=c(4,5,6),labels = c("Thu","Fri","Sat"))
lines(enewts2,xaxt="n",xlab="",col="red")
lines(enewts3,xaxt="n",xlab="",col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)

#Global Reactive Power
plot(rnewts,xaxt="n",xlab="datetime",ylab="Global Reactive Power")
axis(side=1,at=c(4,5,6),labels = c("Thu","Fri","Sat"))
par(mfrow=c(1,1))
dev.off()

par(mfrow=c(2,2))
#Global Active Power
plot(anewts,xaxt="n",xlab="",ylab="Global Active Power (kilowatts)")
axis(side=1,at=c(4,5,6),labels = c("Thu","Fri","Sat"))
#Voltage
plot(vnewts,xaxt="n",xlab="datetime",ylab="Voltage")
axis(side=1,at=c(4,5,6),labels = c("Thu","Fri","Sat"))

#Energy Sub metering
plot(enewts,xaxt="n",xlab="",ylab="Energy Sub metering")
axis(side=1,at=c(4,5,6),labels = c("Thu","Fri","Sat"))
lines(enewts2,xaxt="n",xlab="",col="red")
lines(enewts3,xaxt="n",xlab="",col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)

#Global Reactive Power
plot(rnewts,xaxt="n",xlab="datetime",ylab="Global Reactive Power")
axis(side=1,at=c(4,5,6),labels = c("Thu","Fri","Sat"))



par(mfrow=c(1,1))
setwd("../../")
print("The newly generated plot1.png file is under ./plot4/data")

