setwd("~/R/Infographics/30daysChartChallenge/day27")

library(tidyverse)
library(ggtext)
library(showtext)

showtext_auto()

sysfonts::font_add_google("Junge","Junge")


macroplastic <- read_csv("macroplastics-in-ocean.csv")

colnames(macroplastic)[4] <- c("macro_plastic")


#image <- jpeg::readJPEG("naja-bertolt-jensen-oxntvdNJb9o-unsplash.jpg")

subtitle = "Bouyant plastics with size greater than 0.5 centimeter\ndiameter are macroplastics. With inevitable\ngeneration of plastic waste that ends up in\noceans via rivers has led to accumulation of plastics on ocean\nsurface. Three scenarios are projected for plastic\naccumulation: 1) waste entering the oceans stop in 2020,\n2) waste enter at the rate generated for 2020,\n3) follows the historical waste generation till 2050."

(plot<-macroplastic %>% 
    mutate(Entity = case_when(Entity == "Emissions growth to 2050" ~ "3",
                              Entity == "Emissions level to 2020" ~ "2",
                              TRUE ~ "1")) %>%
  ggplot(aes(Year,macro_plastic, group=Entity, color=Entity)) + 
  geom_line(size=1) +
  xlab("") + ylab("") +
  scale_color_manual(values = c("#F8CB2E","#EE5007","#B22727")) +
  scale_y_continuous(position = "right",labels = c("0 t",paste0(seq(1,4,1)," million t"))) +
  annotate(geom = "text", x=2030,y=750000, label="Emissions stop in 2020",size=15,color="#F8CB2E")+
  annotate(geom = "text", x=2038,y=1.5e6, label="Emissions level to 2020",size=15,color="#EE5007")+
  annotate(geom = "text", x=2025,y=2.5e6, label="Emissions growth to 2050",size=15,color="#B22727")+
  annotate(geom="text", x=1950, y=1e6,label = subtitle,hjust=0,lineheight=.15,size=20,color="#FAF5E4")+
  labs(title = "Macroplastics on the ocean surface",
       caption = "Data: OurWorldInData.org | Photo: Naja Bertolt Jensen on Unsplash | Graphic: Abhinav Malasi")+
  theme(panel.grid = element_blank(),
        panel.background = element_rect(color="#212121", fill="#212121"),
        plot.background = element_rect(color="#212121", fill="#212121"),
        plot.title = element_text(size=120, hjust = .6,margin = margin(t=10,b=-5)),
        plot.caption = element_text(size=35),
        axis.text = element_text(size=50, color = "white",face = "bold"),
        axis.ticks = element_line(color="white"),
        legend.position = "none",
        plot.margin = margin(l=20),
        text = element_text(family="Junge", color="white")))


final_plot <- ggimage::ggbackground(plot, "naja-bertolt-jensen-oxntvdNJb9o-unsplash.jpg")

ggsave("macroplastics.png", final_plot, width = 4032, height=3024, dpi = 600, units = "px")

