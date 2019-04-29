library(lattice)
library(ggplot2)

# load data
hpc<-read.table("household_power_consumption.txt",sep=";",header = TRUE , na.strings="?",stringsAsFactors=FALSE )
hpc[["Date_time"]]<-strptime(paste(hpc[,1], hpc[,2]), "%d/%m/%Y  %H:%M:%S")

# filter on two dates 2007-02-01 and 2007-02-02

hpc_sub<-hpc[as.Date(hpc[,1], format="%d/%m/%Y")=='2007-02-01'|as.Date(hpc[,1], format="%d/%m/%Y")=='2007-02-02',]

### Plot 2
ggplot(hpc_sub, aes(x=as.POSIXct(hpc_sub$Date_time),y=hpc_sub$Global_active_power))+
  geom_line()+
  ylab("Global active power (kilowatts)") +xlab("")+
  scale_x_datetime(date_labels = "%a", date_breaks = "1 day")+
  theme_classic()

#### Create PNG
dev.copy(png,'plot2.png')
dev.off()