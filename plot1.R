##The following commands reads the data directly from website, unzips it and extracts data from the txt file and stores in a data frame "cat".
##sep=";" is used because each element separated by ";" in the txt file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile= "exdata-data-household_power_consumption.zip")
cat<- read.csv(unz("exdata-data-household_power_consumption.zip","household_power_consumption.txt"),sep=";",header = TRUE,fill=FALSE,strip.white=TRUE, stringsAsFactors = FALSE)

##Date is converted into proper format using as.Date()function
cat[,1]<- as.Date(cat[,1],format='%d/%m/%Y')

##cat variable is filtered for the given dates and stored in a new variable "mat"
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
par(mfrow=c(1,1),  mar= c(4, 4, 2, 2) + 0.1)
png(file = "plot1.png", width = 480, height = 480)
hist(mat$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off()