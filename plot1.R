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
,value=TRUE),sep=";",col.names=c("Date", "Time", "Global_active_power",
"Global_reactive_power", "Voltage", "Global_intensity","Sub_metering_1",
"Sub_metering_2", "Sub_metering_3"),colClasses = c('character',
'character','numeric','numeric','numeric','numeric','numeric',
'numeric','numeric'))

png("plot1.png")

hist(household_data$Global_active_power,col="Red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

dev.off()
        

