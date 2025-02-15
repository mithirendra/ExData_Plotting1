
# Calculate the size of memory needed (in bytes)
mem_bytes <- 2075259 * 9 * 8

# Calculating the size of memory needed (in MB)
mem_MB <- round(mem_bytes/2^(20),2)
print(paste0(mem_MB,"MB memory needed"))

# # Download file and Read table from file
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
df$Global_active_power <- as.numeric(df$Global_active_power)

# Call png graphic device
png('plot1.png')

# Plot graph
hist(df$Global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power")

# Close graphic device
dev.off()

