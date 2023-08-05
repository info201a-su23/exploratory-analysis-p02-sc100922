library(dplyr)
library(ggplot2)
library(maps)
library(scales)
library(stringr)

# load data
gunshot <- read.csv("https://raw.githubusercontent.com/info201a-su23/exploratory-analysis-p02-sc100922/main/all_incidents.csv")

# Get the state borders data for the US
us_states <- map_data("state")

# Get the total number of incidents per state
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
state_shape <- state_shape %>%
  select(-subregion)

# Combines the two data sets
total_per_state <- total_per_state %>% 
  mutate(full_state_name = tolower(full_state_name))
total_incidents_shape <- left_join(total_per_state, state_shape, by = c("state" = "region"))

# Plot the map with filled polygons based on total_incidents variable
ggplot(data = total_incidents_shape) +
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