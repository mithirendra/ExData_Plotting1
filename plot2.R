
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

df$Global_active_power <- as.numeric(df$Global_active_power)
df$Date <- as.POSIXct(paste(df$Date, df$Time))

# Call png graphic device
png('plot2.png')

# Plot graph
plot(df$Date, df$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "", xaxt = "n")
axis.POSIXct(1, format = "%a")

# Close graphic device
dev.off()