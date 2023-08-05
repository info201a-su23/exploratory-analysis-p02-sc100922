# Load raw data.
gun_violence_us <- read.csv("https://raw.githubusercontent.com/info201a-su23/exploratory-analysis-p02-sc100922/main/all_incidents.csv")

# Load libraries for chart drawing and date manipulation
library(ggplot2)
library(dplyr)

# The sum of number of people injured and killed from 31 Dec 2012 to 27 May 2022
# of the each state of the US.
gun_violence_states <- gun_violence_us %>% 
  mutate(n_injured_killed = n_injured + n_killed) %>%
  group_by(., state) %>%
  summarize(n_injured_killed = sum(n_injured_killed))

# Present the plot.
ggplot(gun_violence_states, aes(x = state, y = n_injured_killed)) +
  geom_segment(aes(x = state, xend = state, y = 0, 
                   yend = n_injured_killed), color = "black") +
  geom_point(color = "red", size = 1, alpha = 0.6) +
  theme_light() + coord_flip() +
  labs(title =
       "The Number of Injured / Killed in Gun Violence of 51 States of the U.S.
       Dec 31, 2012 - May 27, 2022", y = "Number of Injured / Killed", 
       x = "States") +
  theme(plot.title = element_text(hjust = 0.4),
        panel.border = element_blank(),
        axis.ticks.y = element_blank()
        )