setwd("~/R/Infographics/30daysChartChallenge/day24")

library(tidyverse)
library(showtext)

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Outfit","Outfit")


working_age <- read_csv("DP_LIVE_24042022165057633.csv")


subset <- c("G20","WLD","EU27","OECD")


imp <- working_age %>% filter(LOCATION %in% subset)


# function for adding black bar 
# ref: https://stackoverflow.com/questions/64656234/how-does-the-economist-make-these-lines-near-the-title-using-using-ggplot
# OPTION 2
annotate_npc <- function(x, y, height, width, ...) {
  grid::grid.draw(grid::rectGrob(
    x = unit(x, "npc"), y = unit(y, "npc"), height = unit(height, "npc"), width = unit(width, "npc"),
    gp = grid::gpar(...)
  ))
}

png("working_age.png", width=5, height=5,unit='in', res = 300)


working_age %>% ggplot(aes(TIME, Value, group=LOCATION)) +
  geom_line( color="#C3BBB3",size=1, alpha=.5) +
  geom_line(data = imp, aes(TIME, Value, group=LOCATION, color =LOCATION ), size=1) +
  xlab("")+ ylab("")+
  labs(title = "Working age population",
       subtitle = "The population between the ages of 15 and 64 is defined as working\nage population.",
       caption = "Data: OECD | Graphic: Abhinav Malasi") +
  annotate(geom = "text", x=1955, y=66.25, label="EU", size=10,color="#008AD7",family = "Outfit")+
  annotate(geom = "text", x=1955, y=61.25, label="G20", size=10,color="#B82D5C",family = "Outfit")+
  annotate(geom = "text", x=1955, y=63.5, label="OECD", size=10,color="#8EC359",family = "Outfit")+
  annotate(geom = "text", x=1955, y=58, label="World", size=10,color="#FF9F24",family = "Outfit")+
  #annotate(geom = "text", x=1955, y=72, label="Percent Population", size=10,color="#FF9F24",family = "Outfit")+
  scale_color_manual(values = c("#008AD7","#B82D5C","#8EC359","#FF9F24"))+
  scale_y_continuous(breaks = seq(50,70,5), labels = seq(50,70,5), expand = c(0,0)) +
  scale_x_continuous(expand = c(0,0)) +
  coord_cartesian(clip = "off") +
  theme(panel.grid.major.y = element_line(color="#D9D0CD"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(color="#FFF0E6", fill="#FFF0E6"),
        plot.background = element_rect(color="#FFF0E6", fill="#FFF0E6"),
        plot.margin = margin(c(15,15,10,10)),
        legend.position = "none",
        plot.title.position = "plot",
        plot.title = element_text(size=55,color="#191919"),
        plot.subtitle = element_text(size=30, lineheight = .35,margin = margin(t=10,b=-10)),
        plot.caption = element_text(size=20),
        axis.text = element_text(size=30),
        axis.ticks.y = element_blank(),
        text=element_text(color="#68625D", family = "Outfit"))

annotate_npc(x = 0.1, y = 1, height = 0.02, width = 0.15, fill = "#191919", col = NA)

dev.off()

#ggsave("working_age.png", last_plot(), width = 5, height = 5, units = "in")
