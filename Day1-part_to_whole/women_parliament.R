setwd("~/R/30DayChartChallenge/Day1-part_to_whole")

library(tidyverse)
library(tidyr)
library(showtext)


showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Junge","Junge")

women_parl <- read_csv("women-averages-regional.csv",skip=6)

parliament <- women_parl[,c(1,5)] %>% 
  filter(!is.na(Region)) 

colnames(parliament) <- c("region","Female")

parliament %>% 
  mutate(Female = as.numeric(str_sub(Female,1,nchar(Female)-1)), 
         Male = 100-Female, 
         grp = 1:nrow(parliament)) %>%
  gather(gender,percent,Female:Male) %>% 
  group_by(grp) %>%
  ggplot(aes(percent, y=reorder(region,percent)))+
  geom_line(aes(group=grp),size=1)+
  geom_point(aes(color=gender),size=4)+
  xlab("")+ylab("")+xlim(c(0,100))+
  labs(title = "Women in world parliaments", subtitle = "As per the latest election results.",
       caption = "Source: Inter-Parliamentary Union (IPU) | Graphic: Abhinav Malasi") +
  theme(legend.position = "top",
        panel.background = element_rect(fill="white",color="white"),
        axis.ticks = element_blank())


parliament %>% 
  mutate(Female = as.numeric(str_sub(Female,1,nchar(Female)-1)),
         total = 100) %>%
  ggplot() +
  geom_col(aes(Female,fct_reorder(region, Female)),fill="black") +
  geom_col(aes(total,region),fill="NA",color="black") +
  xlab("")+ylab("")+
  #xlim(c(0,100))+
  labs(title = "Women in world parliaments", subtitle = "As per the latest election results.",
       caption = "Source: Inter-Parliamentary Union (IPU) | Graphic: Abhinav Malasi") +
  theme(legend.position = "top",
        panel.background = element_rect(fill="white",color="white"),
        axis.ticks = element_blank())


parliament %>% 
  mutate(Female = as.numeric(str_sub(Female,1,nchar(Female)-1)),
         total = 100) %>%
  ggplot(aes(Female,fct_reorder(region, Female))) +
  geom_col(fill="#F7BBDB") +
  geom_text(aes(label=paste0(Female,"%")), hjust=-0.25,color="#F7BBDB")+
  geom_col(aes(total,region),fill="NA",color="#F7BBDB") +
  xlab("")+ylab("")+
  scale_x_continuous(labels = function(x) paste0(x, "%"),breaks=seq(0,100,20))+
  labs(title = "Women in world parliaments", 
       caption = "Source: Inter-Parliamentary Union (IPU) | Graphic: Abhinav Malasi") +
  theme(legend.position = "top",
        plot.title = element_text(size=30,hjust = 1,margin = margin(b=15)),
        plot.caption = element_text(size=8),
        text = element_text(color="#F7BBDB"),
        plot.margin = margin(c(5,10,5,0),unit = "mm"),
        panel.background = element_rect(fill="#3F6D3C",color="#3F6D3C"),
        plot.background = element_rect(fill="#3F6D3C",color="#3F6D3C"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.text = element_text(size=12,color="#F7BBDB"),
        axis.ticks = element_blank())


ggsave("women_in_parliament.png",last_plot(),width = 6, height=4, units = "in")




parliament %>% 
  mutate(Female = as.numeric(str_sub(Female,1,nchar(Female)-1)),
         total = 100) %>%
  ggplot(aes(Female,fct_reorder(region, Female))) +
  geom_col(fill="#F7BBDB") +
  geom_text(aes(label=paste0(Female,"%")),size=8,family="Junge" ,hjust=-0.25,color="#F7BBDB")+
  geom_col(aes(total,region),fill="NA",color="#F7BBDB") +
  xlab("")+ylab("")+
  scale_x_continuous(labels = function(x) paste0(x, "%"),breaks=seq(0,100,20))+
  labs(title = "Women representation in world parliaments", 
       caption = "Source: Inter-Parliamentary Union (IPU) | Graphic: Abhinav Malasi") +
  theme(legend.position = "top",
        plot.title = element_text(size=60,face="bold",hjust = .9,margin = margin(t=5,b=20)),
        plot.caption = element_text(size=16),
        text = element_text(family="Junge",color="#F7BBDB"),
        plot.margin = margin(c(5,10,5,0),unit = "mm"),
        panel.background = element_rect(fill="#3F6D3C",color="#3F6D3C"),
        plot.background = element_rect(fill="#3F6D3C",color="#3F6D3C"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.text = element_text(size=24,color="#F7BBDB"),
        axis.ticks = element_blank())


ggsave("women_in_parliament.png",last_plot(),width = 6, height=4, units = "in")
