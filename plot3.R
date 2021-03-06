#
# ----- extract just the data we need
#
system("awk '/^0?[12]\\/0?2\\/2007;/{print}' household_power_consumption.txt > feb2007.txt")
#
# ----- load the abbreviated data
#
df <- read.table('feb2007.txt',
                 sep = ';',
                 col.names = c("date","time","global.active.power",
                     "global.reactive.power","voltage","global.intensity",
                     "sub.metering.1","sub.metering.2","sub.metering.3"),
                 colClasses = c("character","character","numeric",
                     "numeric","numeric","numeric",
                     "numeric","numeric","numeric")
                 )
#
# ----- convert date and time cols to a single date/time col
#
df$date <- paste(df$date,df$time)
df$date <- strptime(df$date,format="%d/%m/%Y %H:%M:%S")
#
# ----- write the line chart to a file (plot3.png)
#
png("plot3.png",width=480,height=480)
##
## calculate the overall range for the different sub meterings
##
g.range <- range(0,df$sub.metering.1,df$sub.metering.2,df$sub.metering.3)
##
## define the initial graph, without the data lines
##
plot(df$date,
     df$sub.metering.1,
     type="n",
     ylim=g.range,
     ylab="Energy sub metering",
     xlab="")
##
## add in the 3 sub-metering columns
##
lines(df$date,df$sub.metering.1,type="l",col="black")
lines(df$date,df$sub.metering.2,type="l",col="red")
lines(df$date,df$sub.metering.3,type="l",col="blue")
##
## display the legend in the top right
##
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       lty=1,
       cex=0.8)
dev.off()
