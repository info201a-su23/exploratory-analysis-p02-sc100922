# Load raw data.
gunshot <- read.csv("https://raw.githubusercontent.com/info201a-su23/exploratory-analysis-p02-sc100922/main/all_incidents.csv")

# Load nessarary library.
library(dplyr)
library(ggplot2)

# Group_by: group the data by the 'state' column.
# Ranked: Ranked by date (ascending)
wa_cases <- gunshot %>%
  group_by(state) %>%
  filter(state == "Washington") %>%
  arrange(as.Date(date))%>%
  ungroup()

print(wa_cases)

# Rounded: get the ratio of n_killed over n_injured, and rounded by 2 digits
wa_case_ratios <- wa_cases %>%
  mutate(ratio = round(n_killed / n_injured, digits = 2))

print(wa_case_ratios)