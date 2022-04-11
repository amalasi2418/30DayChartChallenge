# World's Languages in Danger
setwd("~/R/Infographics/30daysChartChallenge/day11")

library(tidyverse)
library(showtext)

#font_add_google("Open Sans","Roboto")

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Junge","Junge")


df <- data.frame(status = c("Endangered","Safe"), percent = c(43,57))


df %>% 
  arrange(desc(status)) %>%
  #mutate(y_pos = cumsum(percent)-0.56*percent) %>%
  mutate(y_pos = c(25,75)) %>%
  ggplot(aes(x=2,percent, fill=status)) + 
  geom_bar(stat="identity",color="#212121",size=1) + 
  coord_polar(theta = "y", start=0)+
  geom_text(aes(y = y_pos, label = paste0(percent,"%")), color = "#212121",size=10,family="Junge")+
  scale_fill_manual(values = c("#E94F64","#52D273"), name = "",labels = c("Endangered","Safe or data-deficient")) +
  theme_void() +
  xlim(0.5, 2.5) +
  labs(title = "World's languages in danger",
       subtitle = "Nearly 43% out of estimated 6000 spoken languages\nof the world are endangered. The term endangered\nrefers to languages that lie between the conservation\nstatus spectrum of extinct and vulnerable\n(including the bounds).",
       caption="Data: UNESCO | Graphic: Abhinav Malasi")+
  theme(legend.position = "top",
        legend.text = element_text(size=15),
        legend.margin = margin(t=10,b=-15),
        legend.key.height = unit(.5,"cm"),
        legend.key.width = unit(.5,"cm"),
        legend.spacing.x = unit(.05,"cm"),
        text = element_text(family = "Junge", color = "#EEEDDE"),
        panel.background = element_rect(color="#212121", fill = "#212121"),
        plot.background = element_rect(color="#212121", fill = "#212121"),
        plot.title = element_text(size = 45,hjust=.5, margin = margin(t=10)),
        plot.subtitle = element_text(size = 22,lineheight = .35,hjust = .5),
        plot.caption = element_text(size = 10, margin = margin(b=10)))


ggsave("languages3.png",last_plot(), width=3, height=3, units = "in")
