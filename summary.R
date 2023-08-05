# Total incidents per state
total_per_state <- gunshot %>% 
  group_by(state) %>%
  summarise(total_incidents = n())

# The average total incidents across all states
avg_total <- mean(total_per_state$total_incidents, na.rm = TRUE)

# The maximum total incidents across all states
max_total <- max(total_per_state$total_incidents, na.rm = TRUE)
# The state with the maximum value of incidents
state_with_max_incidents <- total_per_state %>%
  filter(total_incidents == max_total)
print(state_with_max_incidents$state)

# The minimum total incidents across all states
min_total <- min(total_per_state$total_incidents, na.rm = TRUE)
# The state with the minimum value of incidents
state_with_min_incidents <- total_per_state %>%
  filter(total_incidents == min_total)
print(state_with_min_incidents$state)

