setwd("~/R/Infographics/30daysChartChallenge/day16")

library(tidyverse)
library(showtext)

showtext_auto()

sysfonts::font_families_google()
font_add_google(name="Noto Sans",family="notosans")

land_cover <- read_csv("LAND_COVER_16042022181606344.csv")

Bel <- land_cover %>% filter(Country == "Belgium" & Measure == "Percent of total country area")


emissions <- read_csv("per-capita-co2-food-deforestation.csv")


emissions %>% 
  ggplot() + 
  geom_col(aes(per_capita_embodied_emissions,fct_reorder(Entity,per_capita_embodied_emissions)), fill = "#066163") +
  geom_text(aes(x =per_capita_embodied_emissions,y = Entity, label = paste0(round(per_capita_embodied_emissions,2)," t")), size = 7,hjust = -0.2,color="#EDE6DB",family = "notosans")+
  xlab("") + ylab("") +
  geom_text(aes(x=3, y=1, label=""), vjust=-1)+
  labs(title = "Carbon footprint linked to deforestation for food production",
       subtitle = "Average per capita CO??? emissions for the period from 2010 to 2014 linked to\ndeforestation for food production. It reflects the carbon footprint of country's diet.",
       caption = "Data: Our World In Data | Graphic: Abhinav Malasi") +
  scale_x_continuous(expand = c(-0.1,.35)) +
  theme(panel.background = element_rect(color = "#141414", fill="#141414"),
        plot.background = element_rect(color = "#141414", fill="#141414"),
        panel.grid = element_blank(),
        plot.margin = margin(c(15,30,10,20)),
        plot.title = element_text(size = 40),
        plot.subtitle = element_text(size = 28, lineheight = .35, margin = margin(t=5, b=10)),
        plot.title.position = "plot",
        plot.caption = element_text(size = 20),
        axis.ticks = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_text(color = "#EDE6DB", size=20),
        text = element_text(family = "notosans", color = "#EDE6DB"))


ggsave("emissions2.png", last_plot(), width = 5.5, height = 6.5, units = "in")

