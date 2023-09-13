# Building a data visualization project - Uber Data Analysis

# Loading required packages
library(tidyr)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(RColorBrewer)
library(lubridate)
library(scales)

# Retrieve and display data
setwd("/Users/akshatbokdia/R/Uber Data Analysis/00_raw_data")
data_apr <- read.csv("uber-raw-data-apr14.csv")
data_may <- read.csv("uber-raw-data-may14.csv")
data_jun <- read.csv("uber-raw-data-jun14.csv")
data_jul <- read.csv("uber-raw-data-jul14.csv")
data_aug <- read.csv("uber-raw-data-aug14.csv")
data_sep <- read.csv("uber-raw-data-sep14.csv")

data <- rbind(data_apr,data_may,data_jun,data_jul,data_aug,data_sep)
str(data)

# Overview the summary and head and tail of data
summary(data)
head(data)
tail(data)

# Data Pre-processing - lubridate and tidyr
data$Base <- as.factor(data$Base)
data$Date.Time <- as.POSIXct(data$Date.Time, format = "%m/%d/%Y %H:%M:%S")
data$Time <- format(data$Date.Time, format = "%H:%M:%S")

data$Date.Time <- ymd_hms(data$Date.Time)
data$Weekday <-  as.factor(wday(data$Date.Time, label = T))
data$Day <- as.factor(day(data$Date.Time))
data$Month <- as.factor(month(data$Date.Time, label = T))
data$Hour <- as.factor(hour(hms(data$Time)))
data$Minute <- as.factor(minute(hms(data$Time)))
data$Second <- as.factor(second(hms(data$Time)))

data <- fill(data, 0:(dim(data)[2] - 1), .direction = "down")

# Writing tidy data to a new CSV File
setwd("/Users/akshatbokdia/R/Uber Data Analysis/01_tidy_data")
write.csv(data, "uber-tidy-data.csv", row.names = F)

# Data Processing - dplyr & Data Visualization - ggplot2, ggthemes & scales 
palette(brewer.pal(8, "Set3"))
div_colors <- palette()

palette(brewer.pal(8,"BuPu"))
seq_colors <- palette()

data_day <- data %>% count(Day)
colnames(data_day) <- c("Day", "Total")
ggplot(data_day, aes(Day, Total)) + 
    geom_col(fill = div_colors[6], color = div_colors[4], size = 0.8, alpha = 0.9) +
      ggtitle("Trips Every Day") +
        theme(legend.position = "none") +
          scale_y_continuous(labels = comma)

data_month_day <- data %>% group_by(Day,Month) %>% summarise(Total = n())
ggplot(data_month_day, aes(Day, Total, fill = Month)) + 
    geom_col() + ggtitle("Trips By Day and Month") + 
      theme_grey() + scale_y_continuous(labels = comma) +
        scale_fill_manual(values = div_colors)

data_hour <- data %>% count(Hour)
colnames(data_hour) <- c("Hour", "Total")
ggplot(data_hour, aes(Hour, Total)) + 
    geom_col(fill = div_colors[3], color = div_colors[4]) + 
      ggtitle("Trips Every Hour") + 
        theme_grey() + theme(legend.position = "none") + 
           scale_y_continuous(labels = comma)

data_month_hour <- data %>% group_by(Hour,Month) %>% summarise(Total = n())
ggplot(data_month_hour, aes(Hour, Total, fill = Month)) + 
    geom_col() + ggtitle("Trips By Hour and Month") + 
        theme_grey() + scale_y_continuous(labels = comma) +
          scale_fill_manual(values = div_colors)

data_month <- data %>% count(Month)
colnames(data_month) <- c("Month", "Total")
ggplot(data_month, aes(Month, Total, fill = Month)) + 
    geom_col() + ggtitle("Trips Every Month") + 
        theme_grey() + theme(legend.position = "none") +         
          scale_y_continuous(labels = comma) + 
            scale_fill_manual(values = seq_colors)

data_month_weekday <- data %>% group_by(Month,Weekday) %>% summarise(Total = n())
ggplot(data_month_weekday, aes(Month, Total, fill = Weekday)) + 
    geom_col(position = "dodge", color = "black", size = 0.3) + 
      ggtitle("Trips By Days of Week and Month") + theme_grey() + 
        scale_y_continuous(labels = comma) + scale_fill_manual(values = div_colors)
ggplot(data_month_weekday, aes(Weekday, Total, fill = Weekday)) +
    geom_col(color = "black", size = 0.3) + facet_grid(cols = vars(Month)) +
      ggtitle("Trips By Days of Week and Month") + theme_grey() +
        scale_y_continuous(labels = comma) + scale_fill_manual(values = seq_colors)
ggplot(data_month_weekday, aes(Weekday, Total, fill = Month)) +
    geom_col(color = "black", size = 0.3) + facet_grid(cols = vars(Month)) +
      ggtitle("Trips By Days of Week and Month") + theme_grey() +
        scale_y_continuous(labels = comma) + scale_fill_manual(values = div_colors)

data_weekday <- data %>% count(Weekday)
colnames(data_weekday) <- c("Weekday", "Total")
ggplot(data_weekday, aes(Weekday, Total, fill = Weekday)) + 
    geom_col() + ggtitle("Trips Every Days of Week") + 
      theme_grey() + theme(legend.position = "none") +         
        scale_y_continuous(labels = comma) + 
          scale_fill_manual(values = seq_colors)

data_bases <- data %>% count(Base)
colnames(data_bases) <- c("Base", "Total")
ggplot(data_bases, aes(Base, Total)) + 
    geom_col(fill = div_colors[1]) + ggtitle("Trips By Bases") + 
      theme_grey() + theme(legend.position = "none") +         
        scale_y_continuous(labels = comma)

data_month_bases <- data %>% group_by(Month,Base) %>% summarise(Total = n())
ggplot(data_month_bases, aes(Base, Total, fill = Month)) +
    geom_col(position = "dodge", color = "black", size = 0.3) +
      ggtitle("Trips By Bases and Month") + theme_grey() +
        scale_y_continuous(labels = comma) + scale_fill_manual(values = div_colors)
ggplot(data_month_bases, aes(Base, Total, fill = Base)) +
    geom_col(color = "black", size = 0.3) + facet_grid(cols = vars(Month)) +
      ggtitle("Trips By Bases and Month") + theme_grey() +
        scale_y_continuous(labels = comma) + scale_fill_manual(values = seq_colors)
ggplot(data_month_bases, aes(Base, Total, fill = Month)) +
    geom_col(color = "black", size = 0.3) + facet_grid(cols = vars(Month)) +
      ggtitle("Trips By Bases and Month") + theme_grey() +
        scale_y_continuous(labels = comma) + scale_fill_manual(values = div_colors)

data_weekday_bases <- data %>% group_by(Weekday,Base) %>% summarise(Total = n())
ggplot(data_weekday_bases, aes(Base, Total, fill = Weekday)) +
    geom_col(position = "dodge", color = "black", size = 0.3) +
      ggtitle("Trips By Days of Week and Bases") + theme_grey() + 
        scale_y_continuous(labels = comma) + scale_fill_manual(values = div_colors)

data_day_hour <- data %>% group_by(Day,Hour) %>% summarise(Total = n())
ggplot(data_day_hour, aes(Day, Hour, fill = Total)) +
    geom_tile(color = "black", size = 0.1) + ggtitle("Heat Map by Hour and Day") +
      theme(legend.box.background = element_rect(color = "black")) + scale_fill_gradientn(colors = seq_colors)

ggplot(data_month_day, aes(Day, Month, fill = Total)) +
    geom_tile(color = "black", size = 0.1) + ggtitle("Heat Map by Month and Day") +
      theme(legend.box.background = element_rect(color = "black")) + scale_fill_gradientn(colors = seq_colors)

ggplot(data_month_weekday, aes(Weekday, Month, fill = Total)) +
    geom_tile(color = "black", size = 0.1) + geom_text(aes(label = Total), color = "white", size = 4) +
      ggtitle("Heat Map by Month and Days of Week") +
        theme(legend.box.background = element_rect(color = "black")) + scale_fill_gradientn(colors = seq_colors[3:7])

ggplot(data_month_bases, aes(Base, Month, fill = Total)) +
    geom_tile(color = "black", size = 0.1) + geom_text(aes(label = Total), color = "white", size = 4) +
      ggtitle("Heat Map by Month and Bases") +
        theme(legend.box.background = element_rect(color = "black")) + scale_fill_gradientn(colors = seq_colors[3:7])

ggplot(data_weekday_bases, aes(Base, Weekday, fill = Total)) +
    geom_tile(color = "black", size = 0.1) + geom_text(aes(label = Total), color = "white", size = 4) +
      ggtitle("Heat Map by Days of Week and Bases") +
        theme(legend.box.background = element_rect(color = "black")) + scale_fill_gradientn(colors = seq_colors[3:7])

min_lat <- min(data$Lat)
max_lat <- max(data$Lat)
min_lon <- min(data$Lon)
max_lon <- max(data$Lon)
ggplot(data, aes(Lon, Lat)) + geom_point(color = "black", size = 1) + 
    scale_x_continuous(limits = c(min_lon, max_lon)) +
      scale_y_continuous(limits = c(min_lat, max_lat)) +
        theme_map() +
          ggtitle("NYC MAP BASED ON UBER RIDES DURING 2014 (APR-SEP)")

ggplot(data, aes(Lon, Lat, color = Base)) + geom_point(size = 1) + 
    scale_x_continuous(limits = c(min_lon, max_lon)) +
      scale_y_continuous(limits = c(min_lat, max_lat)) +
        theme_map() +
          ggtitle("NYC MAP BASED ON UBER RIDES DURING 2014 (APR-SEP) BY BASE")