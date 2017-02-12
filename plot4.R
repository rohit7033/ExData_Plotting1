setwd("~/Documents/data_science_coursera/Lectures/exploratory_data_analysis/1stweek/")
download_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download_file <- "./household_power_consumption.zip"
unzipped_file <- "./household_power_consumption.txt"
##
if (!file.exists(unzipped_file)) {
  download.file(download_url, download_file)
  unzip(download_file, overwrite = TRUE)
}

## establish connection

file_address<-file(unzipped_file)
household_data<-read.table(text=grep("^[1,2]/2/2007",readLines(file_address)
                                     ,value=TRUE),
                           sep=";",col.names=c("Date", "Time",
                                               "Global_active_power",
                                               "Global_reactive_power",
                                               "Voltage", 
                                               "Global_intensity",
                                               "Sub_metering_1",
                                               "Sub_metering_2",
                                               "Sub_metering_3"),
                           colClasses = c('character',
                                          'character','numeric',
                                          'numeric','numeric','numeric',
                                          'numeric',
                                          'numeric','numeric'))

day_time_combined<-paste(household_data$Date,household_data$Time)
day_time_formatted<- strptime(day_time_combined,"%d/%m/%Y %H:%M:%S")

household_data<-cbind(household_data,day_time_formatted)

png("plot4.png")

par(mfrow=c(2,2))

with(household_data,plot(Global_active_power~day_time_formatted,
                         type="l",col="Black",xlab="",
                         ylab="Global Active Power"))
with(household_data,plot(Voltage~day_time_formatted,
                         type="l",col="Black",xlab="datetime",
                         ylab="Voltage"))

with(household_data,plot(Sub_metering_1~day_time_formatted,
                         type="l",col="Black",xlab="",
                         ylab="Energy Sub Metering"))
with(household_data,lines(Sub_metering_2~day_time_formatted,
                          type="l",col="Red"))

with(household_data,lines(Sub_metering_3~day_time_formatted,
                          type="l",col="Blue"))

legend("topright",legend=c("Sub_metering_1","Sub_metering_2",
                           "Sub_metering_3"), 
       col=c("Black","Red","Blue"),lty="solid")


with(household_data,plot(Global_reactive_power~day_time_formatted,
                         type="l",col="Black",xlab="datetime",
                         ylab="Global_reactive_power"))

dev.off()
