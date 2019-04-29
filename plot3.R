library(lattice)
library(ggplot2)

# load data
hpc<-read.table("household_power_consumption.txt",sep=";",header = TRUE , na.strings="?",stringsAsFactors=FALSE )
hpc[["Date_time"]]<-strptime(paste(hpc[,1], hpc[,2]), "%d/%m/%Y  %H:%M:%S")

# filter on two dates 2007-02-01 and 2007-02-02

hpc_sub<-hpc[as.Date(hpc[,1], format="%d/%m/%Y")=='2007-02-01'|as.Date(hpc[,1], format="%d/%m/%Y")=='2007-02-02',]

### Plot 3
xyplot(Sub_metering_1+Sub_metering_2 +
              Sub_metering_3 ~ Date_time,hpc_sub,type="l",
            col=c("black","red","blue"),
            xlab="",
            ylab="Energy sub metering",
            auto.key = list(points = FALSE, lines = TRUE,corner=c(1,1)),
            scales=list(x=list(format="%a",tick.number=3)))


#### Create PNG
dev.copy(png,'plot3.png')
dev.off()