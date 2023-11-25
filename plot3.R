
# Calculate the size of memory needed (in bytes)
mem_bytes <- 2075259 * 9 * 8

# Calculating the size of memory needed (in MB)
mem_MB <- round(mem_bytes/2^(20),2)
print(paste0(mem_MB,"MB memory needed"))

# Download file and Read table from file
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = "./")
df <- read.table("household_power_consumption.txt", sep=";", header=T)
head(df)

# Convert Date column to Date Format
library(dplyr)
df <- df %>% mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
    filter(Date == "2007-02-01" | Date == "2007-02-02")

# Convert characters to numeric
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
df$Date <- as.POSIXct(paste(df$Date, df$Time))

# Call png graphic device
png('plot3.png')

# Plot graph
plot(df$Date, df$Sub_metering_1, type = "l",
         ylab = "Energy sub metering",
         main = "Energy Sub Metering Trend",
         xlab = "", xaxt = "n")
axis.POSIXct(1, format = "%a")
lines(df$Date, df$Sub_metering_2, col="red")
lines(df$Date, df$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"),
       col=c("black", "red", "blue"), lty=1, cex=0.8)

# Close graphic device
dev.off()