library(data.table)

df=fread("household_power_consumption.txt", sep=";", na.strings=c("?", ""), colClasses=c("character","character","numeric", "numeric","numeric","numeric","numeric","numeric","numeric"))
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


png(file="plot1.png", height=800, width=800)
gap = as.numeric(df3$Global_active_power)
hist(gap,col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()