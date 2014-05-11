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
# ----- write the histogram to a file (plot1.png)
#
png("plot1.png",width=480,height=480)
hist(df$global.active.power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()
