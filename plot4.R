# Calculate the size of memory needed (in bytes)
mem_bytes <- 2075259 * 9 * 8

# Calculating the size of memory needed (in MB)
mem_MB <- round(mem_bytes/2^(20),2)
print(paste0(mem_MB,"MB memory needed"))

# Read table from file
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = "./")
df <- read.table("household_power_consumption.txt", sep=";", header=T)
head(df)

# Convert Date column to Date Format
library(dplyr)
df <- df %>% mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
    filter(Date == "2007-02-01" | Date == "2007-02-02")


# Call png graphic device
png('plot4.png')

# Setup plots in a 2 x 2 arrangement
par(mfcol=c(2,2))


# Plot 1 =======================
# Convert characters to numeric
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Date <- as.POSIXct(paste(df$Date, df$Time))

# Plot graph
plot(df$Date, df$Global_active_power, type = "l",
     ylab = "Global Active Power",
     xlab = "", xaxt = "n")
axis.POSIXct(1, format = "%a")

# Plot 2 ======================
# Convert characters to numeric
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)

# Plot graph
plot(df$Date, df$Sub_metering_1, type = "l",
     ylab = "Energy sub metering",
     xlab = "", xaxt = "n")
axis.POSIXct(1, format = "%a")
lines(df$Date, df$Sub_metering_2, col="red")
lines(df$Date, df$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"),
       col=c("black", "red", "blue"), lty=1, cex=0.8)

# Plot 3 ====================
# Convert characters to numeric
df$Voltage <- as.numeric(df$Voltage)

# Plot graph
plot(df$Date, df$Voltage, type = "l",
     ylab = "Voltage",
     xlab = "datetime", xaxt = "n")
axis.POSIXct(1, format = "%a")

# Plot 4 ====================
# Convert characters to numeric
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)

# Plot graph
plot(df$Date, df$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime", xaxt = "n")
axis.POSIXct(1, format = "%a")

# Close graphic device
dev.off()
