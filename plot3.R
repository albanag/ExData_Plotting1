library(data.table)
library(dplyr)

df = fread(unzip("exdata_data_household_power_consumption.zip"), sep=";", na.strings=c("?", ""))
df = as.data.frame(df)

df2 = df %>% 
    mutate(
      date_and_time=as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S")
    )
df3 = df2 %>% 
     filter(
       date_and_time > as.POSIXct('2007-02-01'), date_and_time < as.POSIXct('2007-02-03')
       )
df3 = df3[,!(names(df3) %in% c("Date","Time"))]



# calculate the ranges
png("plot3.png",height=800, width=800)
yrange.min = min( min(range(df3$Sub_metering_1, na.rm=TRUE)), min(range(df3$Sub_metering_2, na.rm=TRUE)), min(range(df$Sub_metering_3, na.rm=TRUE)))
yrange.max = max( max(range(df3$Sub_metering_1, na.rm=TRUE)), max(range(df3$Sub_metering_2, na.rm=TRUE)), max(range(df$Sub_metering_3, na.rm=TRUE)))
yrange=c(yrange.min, yrange.max)
xrange = range(df3$date_and_time)
plot(xrange, yrange, type="n", xlab="Time", ylab="Energy sub metering")

lines(x=df3$date_and_time, y=df3$Sub_metering_1, col="black")
lines(x=df3$date_and_time, df3$Sub_metering_2, col="red")
lines(x=df3$date_and_time, df3$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lwd=1)
dev.off()