setwd("~/R/Infographics/30daysChartChallenge/day25")

library(tidyverse)
library(forecast)
library(lubridate)
library(tidyr)
library(showtext)

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Mukta Vaani","Mukta Vaani")


emissions <- read_csv("Figure_4._Energy-related_carbon_dioxide_emissions_by_fossil_fuel.csv",skip=4) 

colnames(emissions)<- c("year","coal","natural_gas","petroleum","total")

emissions_long <- gather(emissions,type, emission,coal:total)

labels = c(`coal` = "Coal",
           `natural_gas` = "Natural Gas",
           `petroleum` = "Petroleum",
           `total` = "Total Emissions")

emissions_long %>% ggplot(aes(year,emission))+
  geom_point(color = "#1D5C63")+geom_smooth(color = "#1D5C63")+
  xlab("") + ylab("") +
  labs(title = "CO2 emissions from usage of fossil fuels in USA",
       subtitle = "During the pandemic, U.S. saw the least CO2 emissions in the past 2 decades.\nThe emissions are measured in million metric tons of CO2. The data\nsmoothening is done with loess method.",
       caption = "Data: U.S. Energy Information Administration | Graphic: Abhinav Malasi")+
  facet_wrap(~type, scales = "free_y", labeller = as_labeller(labels)) +
  theme(plot.background = element_rect(color="#EDE6DB", fill="#EDE6DB"),
        panel.background = element_rect(color="#1D5C63", fill="#EDE6DB"),
        panel.grid = element_blank(),
        plot.title = element_text(size = 50, hjust=.5,face="bold",margin = margin(b=10)),
        plot.subtitle = element_text(size = 30,lineheight = .35),
        #plot.title.position = "plot",
        plot.caption = element_text(size = 20),
        strip.background = element_rect(color="#EDE6DB", fill="#EDE6DB"),
        strip.text = element_text(size = 25),
        axis.text = element_text(size = 25),
        plot.margin = margin(c(15,20,10,0)),
        text= element_text(color="#1A3C40", family = "Mukta Vaani"))

ggsave("trend.png", last_plot(), width = 5, height = 5, dpi=300, units = "in")
