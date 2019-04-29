library(lattice)
library(ggplot2)

# load data
hpc<-read.table("household_power_consumption.txt",sep=";",header = TRUE , na.strings="?",stringsAsFactors=FALSE )
hpc[["Date_time"]]<-strptime(paste(hpc[,1], hpc[,2]), "%d/%m/%Y  %H:%M:%S")

# filter on two dates 2007-02-01 and 2007-02-02

hpc_sub<-hpc[as.Date(hpc[,1], format="%d/%m/%Y")=='2007-02-01'|as.Date(hpc[,1], format="%d/%m/%Y")=='2007-02-02',]

### Plot 1
pl1<-hist(hpc_sub$Global_active_power,col = "red",  main ="Global Active Power", xlab="Global active power (kilowatts)", ylab = "Frequency")

#### Create PNG
dev.copy(png,'plot1.png')
dev.off()