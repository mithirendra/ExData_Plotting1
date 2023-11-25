
# Calculate the size of memory needed (in bytes)
mem_bytes <- 2075259 * 9 * 8

# Calculating the size of memory needed (in MB)
mem_MB <- round(mem_bytes/2^(20),2)
print(paste0(mem_MB,"MB memory needed")) # Not an issue as my computer has more than enough memory

# Read table from file
df <- read.table("household_power_consumption.txt", sep=";", header=T)
head(df)

# Convert Date column to Date Format
library(dplyr)
df <- df %>% mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
    filter(Date == "2007-02-01" | Date == "2007-02-02")

# Plot1
df$Global_active_power <- as.numeric(df$Global_active_power)
png('plot1.png')
hist(df$Global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power")
dev.off()

