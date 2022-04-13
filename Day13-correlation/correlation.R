setwd("~/R/Infographics/30daysChartChallenge/day13")

library(tidyverse)
library(ggtext)
library(showtext)

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Varta","Varta")


# data extracted from https://www.tylervigen.com/spurious-correlations

df <- data.frame(time = 1999:2009, 
                 suicide = c(5427,5688,6198,6462,6635,7336,7248,7491, 8161,8578,9000), 
                 science = c(18.079,18.594,19.753,20.734,20.831,23.029, 23.597,23.584,25.525,27.731,29.449))


cor(df$suicide,df$science)



df %>% ggplot(aes(time, suicide/310)) + geom_line(color="#0072B2", size=1) +
  geom_point(color="#0072B2", size=2) +
  geom_line(aes(time,science),color="#C91D42", size=1)+
  geom_point(aes(time,science),color="#C91D42", size=2) +
  annotate(geom = "text", x= 2000, y =29,label="The budget is in billion $\nand is scaled down by a\nfactor of 310.", lineheight=.35,family="Varta",size=5) +
  labs(title = "Correlation doesnot imply causation",
       subtitle = "The correlation between US spending on science and suicides\nby hanging is 99.21%. ",
       caption = "Inspiration: https://www.tylervigen.com\nData: U.S. Office of Management and Budget, Centers for Disease Control & Prevention\nGraphic: Abhianv Malasi") +
  xlab("") + ylab("<span style = 'color:#0072B2;'>US spending on science</span> / <span style = 'color:#C91D42;'>Suicides by hanging</span>") +
  scale_x_continuous(breaks = 1999:2009, labels = 1999:2009)+
  theme(text=element_text(family = "Varta"),
        panel.background = element_rect(colour = "white",fill="white"),
        plot.background = element_rect(colour = "white",fill="white"),
        plot.title = element_text(size=40, margin = margin(t=10)),
        plot.subtitle = element_text(lineheight = .35,size=25, margin = margin(t=10,b=15)),
        plot.caption = element_text(size=15,lineheight = .35,hjust = 0),
        axis.text = element_text(size=18),
        axis.title.y = element_markdown(size=20))


ggsave("correlation.png", last_plot(), width = 4, height=3, units="in")


