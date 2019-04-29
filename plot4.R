library(lattice)
library(ggplot2)

# load data
hpc<-read.table("household_power_consumption.txt",sep=";",header = TRUE , na.strings="?",stringsAsFactors=FALSE )
hpc[["Date_time"]]<-strptime(paste(hpc[,1], hpc[,2]), "%d/%m/%Y  %H:%M:%S")

# filter on two dates 2007-02-01 and 2007-02-02

hpc_sub<-hpc[as.Date(hpc[,1], format="%d/%m/%Y")=='2007-02-01'|as.Date(hpc[,1], format="%d/%m/%Y")=='2007-02-02',]

### global active power
pl2<-ggplot(hpc_sub, aes(x=as.POSIXct(hpc_sub$Date_time),y=hpc_sub$Global_active_power))+
  geom_line()+
  ylab("Global active power (kilowatts)") +xlab("")+
  scale_x_datetime(date_labels = "%a", date_breaks = "1 day")+
  theme_classic()


### energy sub metering
pl3<-xyplot(Sub_metering_1+Sub_metering_2 +
              Sub_metering_3 ~ Date_time,hpc_sub,type="l",
            col=c("black","red","blue"),
            xlab="",
            ylab="Energy sub metering",
            auto.key = list(points = FALSE, lines = TRUE,corner=c(1,1)),
            scales=list(x=list(format="%a",tick.number=3)))


### global reactive power

pl4<-ggplot(hpc_sub, aes(x=as.POSIXct(hpc_sub$Date_time),y=hpc_sub$Global_reactive_power))+
  geom_line()+
  ylab("Global_reactive_power") +xlab("datetime")+
  scale_x_datetime(date_labels = "%a", date_breaks = "1 day")+
  theme_classic()

## voltage
pl5<-ggplot(hpc_sub, aes(x=as.POSIXct(hpc_sub$Date_time),y=hpc_sub$Voltage))+
  geom_line()+
  ylab("Voltage") +xlab("datetime")+
  scale_x_datetime(date_labels = "%a", date_breaks = "1 day")+
  theme_classic()

# multiple graphs
library(gridExtra)
require(gridExtra)
grid.arrange(pl2,pl5,pl3,pl4,ncol=2,nrow=2)


#### Create PNG
dev.copy(png,'plot4.png')
dev.off()