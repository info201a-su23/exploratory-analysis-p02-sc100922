## the following code is Chart 1 which is the total shooting case over years (scatterplot)
gunshot <- read.csv("https://raw.githubusercontent.com/info201a-su23/exploratory-analysis-p02-sc100922/main/all_incidents.csv")

library(dplyr)
library(tidyverse)
library(ggplot2)

Lastesd_case <- gunshot %>%
  arrange(desc(as.Date(date))) %>%
  slice(1)
# 2022-05-28

Earliest_case <- gunshot %>%
  arrange(as.Date(date)) %>%
  head(1)
# 2013-01-01

year_table <- table(format(as.Date(gunshot$date), "%Y"))
# 2013  2014  2015  2016  2017  2018  2019  2020  2021  2022 
# 278 51854 53579 58763 61401 55839 53752 62330 56794 18230 
# Proof: sum of the numbers above equal to nrow(gunshot) # 472820 rows

# Data from 2022 is incomplete because no more data after 2022-05-28
# Thus, here I used its history data to estimate the sum of year 2022 
# I replaced the estimated value for 2022 in my array.
new_value <- 18230 / 5 * 12
year_table[10] <- new_value

# Make a plot data in which I converted the year to Variable x and Total case as Varaible y 
plot_data <- data.frame(x = as.numeric(names(year_table)), 
                        y = as.numeric(year_table))

# Plot the graph
plot(plot_data$x , plot_data$y, ann = FALSE, type = 'l', 
     col = 'red', ylim = c(0,70000)) +
  geom_line() +
  geom_point()
title(main= "Gunshooting Cases from 2013 to 2022", 
      sub = "Gunshooting cases over years",xlab = "Years", 
      ylab = "Total Cases", font.axis = 2)