setwd("~/R/30DayChartChallenge/Day30-UN_population")

library(tidyverse)
library(rnaturalearth)
library(rnaturalearthdata)
library(sf)
library(countrycode)
library(RColorBrewer)
library(showtext)

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Eczar","Eczar")

pop_density <- readxl::read_xlsx("WPP2019_POP_F06_POPULATION_DENSITY.xlsx", sheet = "ESTIMATES", skip = 16) %>%
    select(3,5,78)

colnames(pop_density) <- c("name","code","pop_density")

pop_density$pop_density <- as.numeric(pop_density$pop_density)

pop_density$code<-countrycode(pop_density$name, origin = 'country.name', destination = 'iso3c') 

countrycode('Holy See', origin = 'country.name', destination = 'iso3c')

# tutorial for world map
# https://r-spatial.org/r/2018/10/25/ggplot2-sf.html

world <- ne_countries(scale = "medium", returnclass = "sf")


df <- merge(world, pop_density, by.x="adm0_a3",by.y="code")

df %>% mutate(range = case_when(pop_density<=25 ~"0-25",
                                pop_density<=75 ~"25-75",
                                pop_density<=150 ~"75-150",
                                pop_density<=300 ~"150-300",
                                pop_density<=500 ~"300-500",
                                pop_density<=700 ~"500-700",
                                pop_density<=1500 ~"700-1500",
                                TRUE ~ "1500-9000")) %>%
  mutate(range = fct_relevel(factor(range, levels = c("0-25","25-75","75-150","150-300","300-500","500-700","700-1500","1500-9000")))) %>%
  ggplot() +
  geom_sf(aes(fill=fct_relevel(range)),size=.1,color="#141414") +
  scale_fill_brewer(palette = "Reds", na.value = "NA",direction=1, name="Persons per\nsquare km",
                    guide = guide_legend(
                      label.position = "bottom",
                      label.vjust = 5,
                      nrow = 1))+
  xlab("") +ylab("")+
  labs(title = "World Population Density",
       caption = "Data: United Nations | Graphic: Abhinav Malasi")+
  theme_void()+
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(size=60, hjust=.5,margin=margin(b=10)),
        plot.caption = element_text(size=20),
        legend.position = "top",
        legend.text = element_text(size=20, hjust=-.5),
        legend.title = element_text(size=20,vjust=.9,lineheight = .35, margin = margin(b=-10)),
        legend.key.size = unit(.3,"cm"),
        legend.key = element_rect(color="#141414"),
        plot.margin = margin(t=-5,b=-10,r=10),
        legend.background = element_rect(color="#141414",fill="#141414"),
        plot.background = element_rect(color="#141414",fill="#141414"),
        panel.background = element_rect(color="#141414",fill="#141414"),
        text = element_text(family = "Eczar",color="white"))


ggsave("UN_data3.png",last_plot(), width=6,height = 3.5, dpi=300, units = "in")

