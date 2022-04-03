setwd("~/R/Infographics/30daysChartChallenge/day3")

# how geo-political events shaped the generations in Europe 

library(tidyverse)
library(showtext)

font_add_google("Bitter")
showtext_auto()

population <- read_csv("population.csv")

colnames(population)[4] <- c("Population")

europe <- population %>% filter(Entity == "Europe")

asia <- population %>% filter(Entity == "Asia")

arrow <- data.frame(x1=c(1912,1925),
                    y1=c(300,200),
                    x2=c(1916,1919),
                    y2=c(225,275))

europe %>% 
  filter(Year >=1780) %>% 
  ggplot(aes(Year,Population/1e6))+
  geom_line(alpha=.5, color="#8B9A46",size=2) +
  xlab("")+ylab("")+ 
  coord_cartesian(clip="off")+
  labs(title = "Events shaping Europe's population",
       caption = "Source: OurWorldInData.org | Annotations: Wikipedia, Britannica, demographic-research.org | Graphic: Abhinav Malasi")+
  scale_y_continuous(limits = c(0,max(europe$Population/1e6)),expand = c(0, 0)) +
  scale_x_continuous(expand = c(0, 0)) +
  annotate(geom = "rect", xmin = 1780, xmax = 1849, ymin = -Inf, ymax = Inf,
           fill = "#2D4263", alpha = 0.5) +
  annotate(geom = "rect", xmin = 1870, xmax = 1914, ymin = -Inf, ymax = Inf,
           fill = "#2D4263", alpha = 0.5) +
  annotate(geom = "rect", xmin = 1914, xmax = 1918, ymin = -Inf, ymax = Inf,
           fill = "#C84B31", alpha = 0.5) +
  annotate(geom = "rect", xmin = 1918, xmax = 1920, ymin = -Inf, ymax = Inf,
           fill = "#ECDBBA", alpha = 0.5) +
  annotate(geom = "rect", xmin = 1939, xmax = 1945, ymin = -Inf, ymax = Inf,
           fill = "#C84B31", alpha = 0.5) +
  annotate(geom = "rect", xmin = 1990, xmax = 2000, ymin = -Inf, ymax = Inf,
           fill = "#2D4263", alpha = 0.5) +
  annotate(geom = "rect", xmin = 2020, xmax = 2021, ymin = -Inf, ymax = Inf,
           fill = "#ECDBBA", alpha = 0.5) +
  annotate("text", x = 1815, y = 100, label = "Industrial revolution",col="#ECDBBA",size=13) +
  annotate("text", x = 1892, y = 150, label = "2nd Industrial revolution",col="#ECDBBA",size=13) +
  annotate("text", x = 1895, y = 300, label = "World War I",col="#ECDBBA",size=13) +
  annotate("text", x = 1941, y = 200, label = "Spanish Flu",col="#ECDBBA",size=13) +
  annotate("text", x = 1942, y = 300, label = "World War II",col="#ECDBBA",size=13) +
  annotate("text", x = 1995, y = 350, label = "Women postponing\n1st birth",col="#ECDBBA",size=13,lineheight=.35) +
  annotate("text", x = 2020, y = 450, label = "COVID",col="#ECDBBA",size=13) +
  annotate("text", x = 1780, y = 730, label = "Population (in millions)",col="#ECDBBA",size=22,hjust=0) +
  geom_segment(data=arrow, aes(x = x1, y = y1, xend = x2, yend = y2),
               arrow = arrow(length = unit(0.08, "inch")),color="#ECDBBA",size=1) +
  theme(panel.grid = element_blank(),
        panel.background = element_rect(color="#191919",fill="#191919"),
        plot.background = element_rect(color="#191919",fill="#191919"),
        plot.title = element_text(size=110, margin = margin(b=25),hjust=0.5),
        plot.caption = element_text(size=30,margin = margin(t=15)),
        plot.margin = margin(c(40,60,40,40)),
        axis.ticks = element_blank(),
        axis.text = element_text(size=45, color="#ECDBBA"),
        text = element_text(family = "Bitter",color="#ECDBBA"))


ggsave("Europe4.png",last_plot(),width = 9,height = 8, units = "in")


