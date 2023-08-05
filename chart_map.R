library(dplyr)
library(ggplot2)
library(maps)
library(scales)
library(stringr)

gunshot <- read.csv("/Users/wendybu/Desktop/info201/groupproject/exploratory-analysis-p02-sc100922/all_incidents.csv")

us_states <- map_data("state")

total_per_state <- gunshot %>% 
  group_by(state) %>%
  summarise(total_incidents = n())

# Changes the abbreviations to state names
state_mapping <- setNames(state.name, state.abb)

# Adds the full state name from abbreviation
total_per_state$full_state_name <- state_mapping[total_per_state$state]
state_shape <- map_data("state")

# Capitalize the first letter of each word in the region column
state_shape$region <- str_to_title(state_shape$region)

# Combines the two data sets
total_per_state <- total_per_state %>% 
  mutate(full_state_name = tolower(full_state_name))
total_incidents_shape <- left_join(total_per_state, state_shape, by = c("full_state_name" = "region"))

# Convert total_incidents to numeric if needed
total_incidents_shape$total_incidents <- as.numeric(total_incidents_shape$total_incidents)

# Plot the map with filled polygons based on total_incidents variable
total_incidents_map <- ggplot(data = total_incidents_shape) +
  geom_polygon(mapping = aes(x = long,
                             y = lat,
                             group = group,
                             fill = total_incidents)) +
  geom_polygon(data = us_states, mapping = aes(x = long, y = lat, group = group), color = "black", fill = NA) +
  scale_fill_continuous(low = "green",
                        high = "red",
                        limits = c(0, 36000),
                        labels = scales::label_number(scale = 1e-3, accuracy = 0.1, suffix = "k")) +
  labs(title = "Total Gun Violence Incident Cases by State 2013 - 2022",
       fill = "Total Per State") +
  coord_fixed(1.3)

print(total_incidents_map)
