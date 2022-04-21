setwd("~/R/Infographics/30daysChartChallenge/day21")

library(tidyverse)
library(countrycode)
library(showtext)

showtext_auto()

# "Metal Mania"                       "Metamorphous"     "Metrophobic" 

sysfonts::font_families_google()
sysfonts::font_add_google("Outfit","Outfit")

male_height <- read_csv("average-height-of-men-by-year-of-birth.csv")

female_height <- read_csv("average-height-of-women.csv")


male_height$continent <- countrycode(sourcevar = male_height$Entity,
                                     origin = "country.name",
                                     destination = "continent")

female_height$continent <- countrycode(sourcevar = female_height$Entity,
                                     origin = "country.name",
                                     destination = "continent")

colnames(male_height)[4] <- c("height")
colnames(female_height)[4] <- c("height")

female_height1 <- female_height %>% filter(!is.na(continent)) %>% mutate(gender = "Female")

height <- rbind(male_height %>% mutate(gender = "Male"), female_height1)

female_height %>% ggplot(aes(Year,height, group = Entity)) + 
  geom_line() + scale_x_continuous(limits = c(1900,NA))+
  theme(legend.position = "none")


height %>% ggplot(aes(Year,height, group = Entity)) + 
  geom_line(color = "#FF8C32") + scale_x_continuous(limits = c(1800,NA))+
  xlab("") + ylab("Height (cm)") +
  labs(title = "Evolution of Human Height",
       subtitle = "In the last 2 centuries, the average height of males has been steadily growing since mid 19th century. On the other hand,\nthe average height of females as taken a U turn or slowed down around 1970s.",
       caption = "Data: OurWorldInData | Graphic: Abhinav Malasi") +
  facet_grid(gender~continent) + 
  theme(legend.position = "none",
        plot.background = element_rect(color="#EEEEEE",fill="#EEEEEE"),
        panel.background = element_rect(color="#DDDDDD",fill="#DDDDDD"),
        panel.grid = element_blank(),
        plot.title = element_text(size = 60,face = "bold" ,margin = margin(b=10)),
        plot.subtitle = element_text(size=35, lineheight = .35),
        plot.caption = element_text(size = 20),
        plot.margin = margin(c(15,5,5,10)),
        axis.text = element_text(size = 20,color = "#06113C"),
        axis.title.y = element_text(size = 30),
        strip.text = element_text(size = 25,color = "#06113C"),
        strip.background = element_rect(color="#EEEEEE",fill="#EEEEEE"),
        text = element_text(color = "#06113C", family = "Outfit"))


ggsave("average_height.png", last_plot(), width = 10, height = 7, units = "in")

