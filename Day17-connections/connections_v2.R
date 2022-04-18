setwd("~/R/Infographics/30daysChartChallenge/day17")

library(rgdal)
library(tidyverse)
library(sf)
library(showtext)

showtext_auto()

sysfonts::font_families_google()
font_add_google("Delius","Delius")


lakes <- readOGR("ne_10m_lakes_europe/ne_10m_lakes_europe.shp") %>%
  st_as_sf()

rivers <- readOGR("ne_10m_rivers_europe/ne_10m_rivers_europe.shp") %>%
  st_as_sf()

lakes %>% 
  ggplot() +
  geom_sf(fill="blue",color="NA",size=.2,alpha=.5) + 
  geom_sf(data=rivers,color="blue", size=.2)+
  xlab("") +ylab("")+
  labs(title = "Rivers and lakes of Europe",
       caption = "Data: Natural Earth | Graphic: Abhinav Malasi")+
  theme(panel.background = element_rect(color="#C8F2EF", fill="#C8F2EF"),
        plot.background = element_rect(color="#C8F2EF", fill="#C8F2EF"),
        panel.grid = element_blank(),
        text = element_text(family = "Delius"),
        plot.title = element_text(hjust = 0.5, size=40),
        plot.caption = element_text(size=15),
        #plot.margin = margin(c(-50,-5,-50,-5)),
        axis.text = element_blank(),
        axis.ticks = element_blank())

ggsave("water_bodies_eu.png", last_plot(), width = 3, height = 3, units = "in")
