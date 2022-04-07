setwd("~/R/Infographics/30daysChartChallenge/day7")

library(tidyverse)
library(showtext)


showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Oxygen","OXygen")
sysfonts::font_add_google("Ovo","Ovo")

birds <- read_csv("Jirinec_etal_morphometrics.csv")

birds %>% filter(species == "Hylophilus_ochraceiceps")%>% group_by(year) %>% 
  summarise(avg_mass = mean(mass), avg_wing = mean(wing)) %>%
  ggplot(aes(year,avg_wing)) +geom_point()+
  theme(legend.position = "none")


birds %>% filter(species == "Hylophilus_ochraceiceps")%>% group_by(year) %>% 
  summarise(avg_mass = mean(mass), avg_wing = mean(wing)) %>%
  ggplot(aes(year,avg_mass)) +geom_point()+
  theme(legend.position = "none")


tt =birds %>% group_by(guild,species) %>% summarise(ct = n())


birds %>% filter(guild %in% c("MI","MF")) %>% mutate(species = gsub("_"," ", species)) %>%
  ggplot(aes(year,mw)) +geom_point(shape = 20, size = .5, color = "#D8B6A4")+
  geom_smooth(method = "lm", se = TRUE,
              color = "#630000", size = .5) +
  labs(title = "Effect of climate change on resident birds of Amazonian rainforest",
       subtitle = "A study conducted over four decades on the non-migratory birds within the Amazonian primary forest showed\nmorphological consequences of climate change. The birds showed decreased mean mass and one-third of the\nbirds showed increased wing length since 1980, causing the mass to wing ratio decrease.",
       caption = "Data: Jirinec et al., Sci. Adv. 7, eabk1743 (2021) | Graphic: Abhinav Malasi") +
  xlab("") + ylab("Mass to Wing ratio") +
  theme(panel.background = element_rect(color="black",fill="#EEEBDD"),
        plot.background = element_rect(color="#EEEBDD",fill="#EEEBDD"),
        plot.title = element_text(size =52, face = "bold",margin = margin(b =10)),
        plot.subtitle = element_text(size =30, lineheight = .35,margin = margin(b =5)),
        plot.caption = element_text(size =20, margin = margin(t =15)),
        axis.text = element_text(size =20),
        axis.title.y = element_text(size =25),
        plot.margin = margin(c(20,25,20,20)),
        legend.position = "none",
        strip.text.x = element_text(size = 25),
        strip.background = element_rect(color="#EEEBDD",fill="#EEEBDD"),
        panel.grid = element_blank(),
        text = element_text(family = "Ovo")) +
  scale_y_continuous(labels = scales::number_format(accuracy = 0.01)) +
  facet_wrap(~species, ncol = 5,scales = "free_y") 
  


ggsave("climate_change_effect_birds3.png",last_plot(), width = 8, height = 5,units = "in")

