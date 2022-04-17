setwd("~/R/30DayChartChallenge/Day15-multivariate")

library(tidyverse)
library(countrycode)
library(ggthemes)
library(ggtext)
library(showtext)

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Varta","Varta")

mobile <- read_csv("mobile-phone-subscriptions-vs-gdp-per-capita.csv")

colnames(mobile)[4:6]<- c("cellular_subscription","gdp_per_capita","population")

mobile_2019 <- mobile %>% 
  filter(Year == 2019) %>% 
  dplyr::select(-Continent) %>%
  filter(!is.na(Code) & !is.na(cellular_subscription) & !is.na(gdp_per_capita))


# assign continents to countries
mobile_2019$continent <- countrycode(sourcevar = mobile_2019$Entity,
                            origin = "country.name",
                            destination = "continent")

mobile_2019 %>% 
  filter(!is.na(continent))%>% 
  ggplot() + 
  geom_point(aes(gdp_per_capita,cellular_subscription,size=population,color=as.factor(continent)), alpha=.5) +
  scale_x_log10(label = scales::comma) +
  #scale_y_continuous(expand = c(0,0)) +
  xlab("GDP per capita (adjusted US $, log scale)") + 
  ylab("Mobile subscription per 100 person")+
  labs(title = "Mobile technology adoption in 2019",
       subtitle = "The mobile subscription per 100 person has a positive correlation<br>with the GDP per capita of the country. Hong Kong has the highest<br>mobile subscription per 100 person.<br>*Bubbles are sized by population*.",
       caption = "Data: Our World In Data | Graphic: Abhinav Malasi",
       size = NULL,
       color = NULL) +
  guides(size = "none") +
  annotate(geom="text", x=59586, y=300,label="Hong Kong", family="Varta",size=5)+
  annotate(geom="text", x=751, y=70,label="Burundi", family="Varta",size=5)+
  annotate(geom="text", x=6713.932, y=85,label="India", family="Varta",size=5)+
  annotate(geom="text", x=16092.3, y=122,label="China", family="Varta",size=5)+
  annotate(geom="text", x=62630.8, y=150,label="USA", family="Varta",size=5)+
  scale_color_manual(values = c(
    "Africa" = "#355070", "Americas" = "#6d597a", "Asia" = "#b56576",
    "Europe" = "#e56b6f", "Oceania" = "#eaac8b")) + 
  theme(text=element_text(family = "Varta"),
        legend.position = "top",
        axis.text = element_text(size = 28),
        axis.title = element_text(size = 30),
        legend.key = element_rect(color="#FFFFFF",fill="#FFFFFF"),
        legend.text = element_text(size = 20),
        legend.justification = "left",
        plot.margin = margin(c(10,10,5,10)),
        plot.title = element_text(size=50),
        plot.title.position = "plot",
        plot.subtitle = element_markdown(size=30, lineheight = .35, margin=margin(t=10)),
        plot.caption = element_text(size=20, margin = margin(t=10)),
        panel.background = element_rect(color="#FFFFFF",fill="#FFFFFF"),
        plot.background = element_rect(color="#FFFFFF",fill="#FFFFFF")) 
  #facet_wrap(~Year, ncol=6) 


ggsave("mobile.png",last_plot(), width = 4, height = 4, units = "in")

