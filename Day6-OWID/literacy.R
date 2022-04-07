setwd("~/R/Infographics/30daysChartChallenge/day6")

library(tidyverse)
library(tidyr)
library(showtext)

font_add_google("Fira Sans Extra Condensed","cond")


literacy <- read_csv("literate-and-illiterate-world-population.csv")

colnames(literacy)[4:5] <- c("literate","illiterate")

literacy_long <- gather(literacy, type, rate, literate, illiterate)

literacy_long %>% ggplot(aes(Year, rate/100, fill=type)) +
  geom_area() +
  xlab("") + ylab("") +
  scale_y_continuous(expand = c(0,0), labels = scales::percent) +
  scale_x_continuous(expand = c(0,0)) +
  annotate("text", x = 1875, y = .75, label = "Illiterate world population",col="#EEEEEE",size=8,family = "cond") +
  annotate("text", x = 1975, y = .25, label = "Literate world population",col="#EEEEEE",size=8,family = "cond") +
  scale_fill_manual(values = c("#541212","#8B9A46")) +
  labs(title = "Evolution of global literacy",
       subtitle = "The collected data is spanning between 1800 till 2016 for population 15 years or older.",
       caption = "Data: OurWorldInData | Graphic: Abhinav Malasi") +
  theme(panel.background = element_rect(color="#0F0E0E", fill = "#0F0E0E"),
        plot.background = element_rect(color="#0F0E0E", fill = "#0F0E0E"),
        panel.grid = element_blank(),
        plot.title = element_text(size=45, margin = margin(t=3,b=10)),
        plot.subtitle = element_text(size=22),
        plot.caption = element_text(size=13),
        plot.margin = margin(c(10,10,5,10)),
        axis.text = element_text(color = "#EEEEEE", size = 15),
        legend.position = "none",
        text = element_text(color = "#EEEEEE", family = "cond"))


ggsave("literacy2.png", last_plot(), width = 4, height = 3, units = "in")
