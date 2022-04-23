setwd("~/R/Infographics/30daysChartChallenge/day23")

library(tidyverse)
library(showtext)
library(RColorBrewer)

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("News Cycle","News Cycle")


child <- read_csv("child-mortality-vs-share-of-children-immunized-against-diphtheria-pertussis-and-tetanus.csv")

colnames(child)[4] <- c("mortality")


child$Continent <- countrycode(sourcevar = child$Entity,
                                     origin = "country.name",
                                     destination = "continent")


child %>% filter(!is.na(Continent)) %>% filter(!is.na(mortality)) %>% #filter(Year>1999) %>%
  ggplot() +
  geom_tile(aes(Year,Entity,fill=mortality)) + 
  # geom_dl(aes(label = country), method = list(dl.trans(x = x + 0.2),
  #                                                        "last.points", cex = 0.8)) +
  #geom_label_repel(aes(label = as.factor(country)),nudge_x = 1, na.rm = TRUE) +
  xlab("") + ylab("")+
  labs(title = "Immunization of children against DPT",
       #subtitle = "Visualized the mortality rate of children under 5 per 1000 live births.",
       caption = "Data: OurWorldInData | Graphic: Abhinav Malasi") +
  #scale_fill_gradientn(colours = c("green","yellow","orange","red"), name = "Mortality rate for children\nunder 5 per 1000 live births", limits =c(0,41), labels = paste0(seq(0,40,10),"%"))+
  scale_fill_distiller(palette = "Reds", na.value = "#de2d26",
                       direction = 1,name = "Mortality rate for children\nunder 5 per 1000 live births", limits =c(0,41), labels = paste0(seq(0,40,10),"%"))+
  theme(panel.background = element_rect(color="#EEEDDE",fill = "#EEEDDE"),
        plot.background = element_rect(color="#EEEDDE",fill = "#EEEDDE"),
        panel.grid = element_blank(),
        plot.margin = margin(c(20,20,10,20)),
        plot.title = element_text(size=80, face="bold", hjust = 0.5),
        plot.title.position = "plot",
        #plot.subtitle = element_text(size = 60,hjust = 0.5, margin = margin(t=10,b=5)),
        plot.caption = element_text(size=30),
        axis.text = element_text(size=35),
        legend.position = "top",
        legend.title = element_text(size=40, lineheight = .35),
        legend.background = element_rect(color="#EEEDDE",fill = "#EEEDDE"),
        legend.key = element_rect(color="#EEEDDE",fill = "#EEEDDE"),
        legend.margin = margin(t=10, b=-10),
        legend.text = element_text(size=35),
        legend.spacing.y = unit(0.3, 'cm'),
        strip.background = element_rect(color="#EEEDDE",fill = "#EEEDDE"),
        strip.text = element_text(size=40),
        text = element_text(family = "News Cycle",color = "#3A3845")) +
  guides(fill = guide_colorbar(barwidth = 15,
                               barheight = 1.25)) +
  facet_wrap(~Continent, scales = "free", nrow = 1)

ggsave("DPT_immunization1.png", last_plot(), width = 16, height = 10, units = "in")

