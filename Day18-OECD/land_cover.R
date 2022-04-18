setwd("~/R/Infographics/30daysChartChallenge/day18")

library(tidyverse)
library(countrycode)
library(tidyr)
library(showtext)
library(grid)
library(gtable)
library(gridExtra)
library(png)

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Junge","Junge")

land_cover <- read_csv("LAND_COVER_16042022181606344.csv")

land_cover$continent <- countrycode(sourcevar = land_cover$Country,
                                       origin = "country.name",
                                       destination = "continent")


land_cover_EU <- land_cover %>% 
  filter(Measure == "Square kilometers (000's)" & continent == "Europe") %>%
  select(Country, 'Land cover class', Year, Value)


land_cover_EU_df <- spread(land_cover_EU,Year,Value)

land_cover_EU_df<- land_cover_EU_df %>%  mutate(diff = (`2019`- `1992`)/`1992`,
                                 color = case_when(diff < 0 ~ "#E94F64",
                                                   TRUE ~ "#52D273"))

land_cover_EU_df$`Land cover class` <- as.factor(land_cover_EU_df$`Land cover class`)


remove = c("Faeroe Islands", "Gibraltar","Guernsey","Holy See", "Isle of Man","Jersey","Svalbard and Jan Mayen", 
           "Estonia","Luxembourg","Slovenia","Liechtenstein")

land_cover_EU_df %>% 
  filter(!(Country %in% remove)) %>% 
  mutate(Country = case_when(Country == "Bosnia and Herzegovina" ~ "B & H*",
                             TRUE ~ Country)) %>%
  ggplot(aes(diff,`Land cover class`)) +geom_col(aes(fill=color))+  
  scale_fill_manual(values = c("#52D273","#E94F64")) + 
  xlab("") + ylab("") +
  labs(title = "Europe's land cover change in last 3 decades",
       subtitle = "The land cover change is calculated for the period between 1992 to 2019. The horizontal axis corresponds to the ratio of\nchange in the land cover between 1992-2019 to the land cover in 1992.",
       caption = "*Bosnia and Herzegovina                     Data: OECD | Graphic: Abhinav Malasi") +
  #scale_x_continuous(labels = scales::percent) +
  facet_wrap(~Country, ncol=7) +
  theme(legend.position = "none",
        text = element_text(family = "Junge"),
        panel.grid = element_blank(),
        panel.background = element_rect(color = "white",fill="white"),
        plot.background = element_rect(color = "white",fill="white"),
        plot.title = element_text(size=55),
        plot.title.position = "panel",
        plot.subtitle = element_text(size=30, lineheight = .35),
        plot.caption = element_text(size=25),
        strip.background = element_rect(color = "white",fill="white"),
        strip.text.x = element_text(size=30),
        axis.text = element_text(size=30),
        axis.ticks.y = element_blank())



ggsave("land_coverv1.png", last_plot(), width = 10, height = 10, units = "in")

