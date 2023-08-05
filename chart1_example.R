
## the following code is Chart 1 which is the total shooting case over years (scatterplot)
library(dplyr)
library(tidyverse)
library(ggplot2)
gunshot <- read.csv("/Users/shipei/Desktop/info201/exploratory-analysis-p02-sc100922/all_incidents.csv")
gunshot
names(gunshot) # 7 columns
nrow(gunshot) # 472820 rows

Lastesd_case <- gunshot %>%
  arrange(desc(as.Date(date))) %>%
  slice(1)
Lastesd_case
# 2022-05-28

Earliest_case <- gunshot %>%
  arrange(as.Date(date)) %>%
  head(1)
# 2013-01-01
Earliest_case

year_table <- table(format(as.Date(gunshot$date), "%Y"))
print(year_table)
# 2013  2014  2015  2016  2017  2018  2019  2020  2021  2022 
# 278 51854 53579 58763 61401 55839 53752 62330 56794 18230 
# Proof: sum of the numbers above equal to nrow(gunshot) # 472820 rows

# Data from 2022 is incomplete because no more data after 2022-05-28
# Thus, here I used its history data to estimate the sum of year 2022 
# I replaced the estimated value for 2022 in my array.
new_value <- 18230 / 5 * 12
year_table[10] <- new_value
print(year_table)

# Make a plot data in which I converted the year to Variable x and Total case as Varaible y 
plot_data <- data.frame(x = as.numeric(names(year_table)), y = as.numeric(year_table))

# Plot the graph
plot(plot_data$x , plot_data$y, ann = FALSE, type = 'l', col = 'red', ylim = c(0,70000)) +
  geom_line() +
  geom_point()
title(main= "Gunshooting Cases from 2013 to 2022", sub = "Gunshooting cases over years",xlab = "Years", ylab = "Total Cases", font.axis = 2)

# What the graph tells us:
# After plotting out the graph, our group found that the data have a few outliers.
# For example, we found that the data from 2013 and 2022 are not complete. And unluckily, we can
# not estimated the total cases of 2013 because its data was not beening continuously recorded. But we can
# estimate the shooting case of 2022 because it reliable and can be estimated on continuous historical
# data. 

# We believe that the shooting cases increased from 2014 to 2016. However, since government is imposing strict
# policy on gun control, we do see some gun shooting case decrease from 2017 to 2019. However, because of
# covid, the shooting cases increased quickly once the pandemic started. This is reasonable because there
# was high unemployment during the Covid, meaning that the society was not safe as before.  However, as the
# pandemic ended and governments' policy on encouraging firms to develop and provide jobs for people, we do see
# the shooting cases decline in recent 2 years.

