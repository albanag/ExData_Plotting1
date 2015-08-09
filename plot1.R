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


png(file="plot1.png", height=800, width=800)
gap = as.numeric(df3$Global_active_power)
hist(gap,col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()