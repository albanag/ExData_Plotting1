
library(data.table)
df=fread("household_power_consumption.txt", sep=";", na.strings=c("?", ""))
df = as.data.frame(df)
library(dplyr)
head(df)

df2 = df %>% 
    mutate(
      date_and_time=as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S")
    )
df3 = df2 %>% 
     filter(
       date_and_time > as.POSIXct('2007-02-01'), date_and_time < as.POSIXct('2007-02-03')
       )
df3 = df3[,!(names(df3) %in% c("Date","Time"))]


png("plot2.png",height=800, width=800)
plot(df3$Global_active_power ~ df3$date_and_time, xlab="", ylab="Gloabl Active Power (kilowatts)", type="l")
dev.off()

