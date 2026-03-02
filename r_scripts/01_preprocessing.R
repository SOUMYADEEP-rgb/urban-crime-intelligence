# 01_preprocessing.R
install.packages("dplyr")
install.packages("lubridate")
install.packages("caret")
install.packages("httr")
install.packages("jsonlite")
library(dplyr)
library(lubridate)
library(caret)
cat("Loading raw dataset...\n")

data <- read.csv("data/raw/crime_data.csv")
colnames(data)
# Convert Date column
data$Date <- as.POSIXct(data$Date, format="%m/%d/%Y %I:%M:%S %p")

# Temporal Features
data$Hour    <- hour(data$Date)
data$Month   <- month(data$Date)
data$Weekday <- wday(data$Date, label=TRUE)
data$Weekend <- ifelse(data$Weekday %in% c("Sat","Sun"),1,0)
data$Night   <- ifelse(data$Hour >= 20 | data$Hour <= 5,1,0)

# Convert logical to numeric
data$Arrest   <- ifelse(data$Arrest == TRUE,1,0)
data$Domestic <- ifelse(data$Domestic == TRUE,1,0)

# Remove missing geo
data <- data %>%
  filter(!is.na(Latitude), !is.na(Longitude))

# Select 13 meaningful columns
clean_data <- data %>%
  select(Latitude,
         Longitude,
         Beat,
         District,
         Ward,
         Community.Area,
         Hour,
         Month,
         Weekend,
         Night,
         Arrest,
         Domestic,
         Primary.Type)

# Save processed dataset
write.csv(clean_data, "data/processed/clean_data.csv", row.names=FALSE)

cat("Preprocessing completed successfully.\n")