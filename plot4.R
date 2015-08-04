##The following commands reads the data directly from website, unzips it and extracts data from the txt file and stores in a data frame "cat".
##sep=";" is used because each element separated by ";" in the txt file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile= "exdata-data-household_power_consumption.zip")
cat<- read.csv(unz("exdata-data-household_power_consumption.zip","household_power_consumption.txt"),sep=";",header = TRUE,fill=FALSE,strip.white=TRUE, stringsAsFactors = FALSE)

##Date is converted into proper format using as.Date()function
cat[,1]<- as.Date(cat[,1],format='%d/%m/%Y')

##cat variable is filtered for the given dates and stored in a nre variable "mat"
mat<-cat[cat$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]

##All variables are converted into numeric for plotting
for(i in 3:9)
{
  mat[,i]=as.numeric(mat[,i])
}

##A separate Date and Time column is created and merged with "mat" variable
DT<-strptime(paste(as.character(mat$Date), as.character(mat$Time),sep = ":"), format = '%Y-%m-%d:%H:%M:%S')
mat<- cbind(mat,DT)

##Data is plotted and stored as a PNG file
png(file = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2), mar = c(4,4,1,4))
plot(mat$DT, mat$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(mat$DT, mat$Voltage, type = "l", xlab = "datetime", ylab = "voltage")
plot(mat$DT,mat$Sub_metering_1, type = "S", xlab = "", ylab = "Energy sub metering", ylim=c(0,40))
par(new=T)
plot(mat$DT,mat$Sub_metering_2, type = "S", xlab = "", ylab = "",col="red", ylim=c(0,40))
par(new=T)
plot(mat$DT,mat$Sub_metering_3, type = "S", xlab = "", ylab = "", col="blue", ylim=c(0,40))
legend('topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n", lty=1, col=c('black', 'red', 'blue'),pt.cex=1, cex=0.75)
plot(mat$DT, mat$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()