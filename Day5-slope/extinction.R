setwd("~/R/Infographics/30daysChartChallenge/day5")

library(tidyverse)
library(tidyr)
library(sysfonts)
library(showtext)


showtext_auto()

sysfonts::font_families_google()
#sysfonts::font_add_google("Junge","Junge")
font_add_google(name="Hind Madurai",family="Hind Madurai")

df <- data.frame(species = c("Birds","Mammals","Amphibians"),
                 pre_1900 = c(51,74,85), 
                 post_1900 = c(132,183,587))

df_long <- gather(df, time, extinct_rate, pre_1900:post_1900)

df_long %>% mutate(time = case_when(
                          time == "pre_1900" ~ "Pre-1900",
                          TRUE ~ "Post-1900"
                        )) %>% 
  ggplot(aes(time, extinct_rate, color=species))+
  geom_line(aes(group = species),color="black",size=1)+geom_point(size=4) +
  scale_x_discrete(limits = c("Pre-1900", "Post-1900"),expand = c(0,0.5)) +
  xlab("") + ylab("") +
  #scale_y_continuous(expand = c(0,0)) +
  scale_color_manual(values = c("#4E8D7C","#045762","#EA97AD")) +
  annotate(geom = "text", x = 2.15, y  = 587, label = "587", size = 15, family="Hind Madurai")+
  annotate(geom = "text", x = 2.15, y  = 183, label = "183", size = 15, family="Hind Madurai")+
  annotate(geom = "text", x = 2.15, y  = 132, label = "132", size = 15, family="Hind Madurai")+
  annotate(geom = "text", x = 0.85, y  = 51, label = "51", size = 15, family="Hind Madurai")+
  annotate(geom = "text", x = 0.85, y  = 80, label = "74", size = 15, family="Hind Madurai")+
  annotate(geom = "text", x = 0.85, y  = 105, label = "85", size = 15, family="Hind Madurai")+
  annotate(geom = "label", x = 2.1, y = 300, label = "183 means the number\nof mammals extinct per\n1 million species per\nyear since 1900.", 
           lineheight = .35, size = 10, family="Hind Madurai", fill = "#F3F2DA") +
  annotate(geom = "label", x = .85, y = 250, label = "85 means the number\nof amphibians extinct per\n1 million species per\nyear before 1900.", 
           lineheight = .35, size = 10, family="Hind Madurai", fill = "#F3F2DA") +
  labs(title = "Is current species extinction rate alarming?",
       subtitle = "The species extinction rate is defined as extinctions per million species per\nyear. This means for rate to be 1, 1 species will get extinct each year per\n1 million species. The current extinct rate for mammals is 183, which is 1000\ntimes higher than the natural background extinction rate of 0.1.",
       caption = "Data: OurWorldInData & Pimm et al Science 344, 1246752(1-10) | Graphic: Abhinav Malasi") +
  theme(panel.background = element_rect(color="#F3F2DA",fill="#F3F2DA"),
        plot.background = element_rect(color="#F3F2DA",fill="#F3F2DA"),
        plot.title = element_text(size = 55, lineheight = .35,margin = margin(b=15, l=-5)),
        plot.subtitle = element_text(size = 30, lineheight = .35),
        #plot.title.position = "plot",
        plot.caption = element_text(size = 20, margin = margin(t= 15)),
        plot.margin = margin(c(20,20,20,15)),
        axis.ticks = element_blank(),
        legend.spacing.y = unit(.05, 'cm'),
        legend.key.size = unit(3, 'mm'),
        axis.text = element_text(size = 40, color = "black"),
        axis.text.y = element_blank(),
        legend.position = c(.28,.8),
        legend.title = element_blank(),
        legend.text = element_text(size = 25),
        legend.key = element_rect(color="#F3F2DA",fill="#F3F2DA"),
        legend.background = element_rect(color="#F3F2DA",fill="#F3F2DA"),
        panel.grid = element_blank(),
        text = element_text(family = "Hind Madurai"))


ggsave("extinction_v6.png", last_plot(),width = 5, height = 6, units = "in")  

