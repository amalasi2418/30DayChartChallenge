setwd("~/R/30DayChartChallenge/Day8-mountains")

library(tidyverse)
library(patchwork)
library(ggridges)
library(showtext)


showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Oregano","Oregano")

#pop <- read_csv("population_density.csv")

global_rank <- read_csv("csvData.csv")

beer <- read_csv("beer-consumption-per-person.csv")
spirit <- read_csv("spirits-consumption-per-person.csv")
wine <- read_csv("wine-consumption-per-person.csv")

colnames(beer)[4] =c("Amount")
colnames(wine)[4] =c("Amount")
colnames(spirit)[4] =c("Amount")

beer <- beer %>% mutate(Alcohol = "Beer")
wine <-  wine %>% mutate(Alcohol = "Wine")
spirit <- spirit %>% mutate(Alcohol = "Spirit")

consumption <- rbind(beer, wine, spirit) 

consumption %>% filter(Entity == "Belgium") %>% 
  ggplot(aes(Year, Amount,fill=Alcohol)) + 
  geom_area() + 
  ylab("Average annual per capita alcohol consumption") + 
  coord_cartesian(clip = "off") +
  scale_fill_manual(values = c("#f28e1c","#fbf0d7","#722F37"), name = "Alcohol: ") +
  scale_x_continuous(expand = c(0,0))+
  scale_y_continuous(expand = c(0,0))+
  labs(title = "Alcohol consumption habits of Belgians",
       subtitle = "According to the average annual per capita alcohol consumption, measured in liters of pure alcohol, Belgium ranked 28\nin 2022. The global average being 5.7.",
       caption = "Data: Our World In Data | Graphic: Abhinav Malasi") +
  #geom_text(data = annotate_country,aes (label =label))+
  #facet_wrap(~Alcohol, ncol=1) +
  #geom_text(data =annotate_country ,aes(label = consumption_2022, x=x,y=y),  size = 15, family="Oregano") +
  theme(panel.grid = element_blank(),
        panel.background = element_rect(color="#212121",fill="#212121"),
        plot.background = element_rect(color="#212121",fill="#212121"),
        plot.title = element_text(size = 50),
        plot.subtitle = element_text(size = 30, lineheight = .35),
        plot.caption = element_text(size = 20),
        legend.position = "top",
        legend.background = element_rect(color="#212121",fill="#212121"),
        legend.key = element_rect(color="#212121",fill="#212121"),
        legend.text = element_text(size = 18),
        legend.title = element_text(size = 20),
        legend.spacing.x = unit(.06, 'cm'),
        legend.key.size = unit(3,"mm"),
        axis.ticks = element_blank(),
        axis.text = element_text(size = 25,color="#fbf0d7"),
        axis.title = element_text(size = 25),
        plot.margin = margin(c(20,20,10,20)),
        #strip.background = element_blank(),
        #strip.placement = element_text(vjust = -2),
        #strip.text.x = element_text(size = 15,vjust = -1.5,hjust = .75),
        text = element_text(family="Oregano",color = "#fbf0d7")) 



ggsave("Belgium_ alcohol_consumption.png", last_plot(), width = 6, height = 4, units = "in")
