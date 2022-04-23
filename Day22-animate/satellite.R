setwd("~/R/Infographics/30daysChartChallenge/day22")

library(tidyverse)
library(lubridate)
library(gganimate)
library(countrycode)
library(showtext)

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("News Cycle","News Cycle")


satellites <- readxl::read_xls("UCS-Satellite-Database-1-1-2022.xls")

sat_data <-  data.frame(country = satellites$`Country of Operator/Owner`, year = year(satellites$`Date of Launch`))

launch <- sat_data %>% group_by(country, year)  %>%
  summarise(satellite = n()) %>% 
  filter(!is.na(country))

unique(launch$country)

# replacing collaborations with multinational

for (i in as.numeric(grep("/", launch$country))) {
  launch$country[i] = "Multinational"
}


country <-launch %>% group_by(country) %>% summarise(total = sum(satellite)) %>% arrange(desc(total))

sum(country$total)



# continents

launch$continent <- countrycode(sourcevar = launch$country,
                                     origin = "country.name",
                                     destination = "continent")

# focusing on countries launched more than 50 satellites

launch <- launch %>% 
  #filter(year >= 1990) %>% 
  mutate(continent = case_when(country == "USA" ~ "USA",
                               country =="China"~"China",
                               country =="United Kingdom"~"United Kingdom",
                               country =="Russia"~"Russia",
                               country =="Japan"~"Japan",
                               country =="India"~"India",
                               country =="Canada"~ "Canada",
                               country %in% c("ESA","Multinational")~"Multinational",
                               TRUE ~continent)) 


n_distinct(launch$continent)
max(launch$satellite)


tt=launch %>% group_by(continent,year) %>% 
  summarise(total = sum(satellite)) %>%
  mutate(tot = cumsum(total))



secd_axis <- "As of 31st December 2021, a total of 4852 satellites have been launched. USA\ntopping the chart with 2944 of them (including collaborative). The data is shown\nfor countries with 50+ satellites. Multinational refers to collaborative satellites,\nand the remaining satellites are aggregated according to the continent."

anim <- launch %>%
  group_by(continent,year) %>% 
  summarise(total = sum(satellite)) %>%
  mutate(tot = cumsum(total)) %>%
  ggplot(aes(year, tot, group = continent)) +
  geom_line(size=1,color = "#A2B38B") +
  labs(title = "Who has satellites?",
       subtitle = "Out of 4852 satellites launched till 31st December 2021, the USA has 2944.",
       caption = "Data: www.ucsusa.org | Graphic: Abhinav Malasi") +
  xlab("") + ylab("Total satellites") +
  geom_text(aes(x=year,y=tot), label = "|-o-|", size=8,color="#A2B38B") +
  geom_text(aes(x=year-5,y=tot, label = continent), family="News Cycle",size=8,color="#A2B38B", vjust = 0.6) +
  #geom_text(aes(x=1980, y = 500),lineheight=.35,size=5,color="#A2B38B",label= "As of 31st December 2021, a total of 4852 satellites have been\nlaunched. USA topping the chart with 2944 of them (including\ncollaborative). The data is shown for countries with 50+ satellites.\nMultinational refers to collaborative satellites, and the remaining\nsatellites are aggregated according to the continent.")+
  #scale_x_continuous(sec.axis = sec_axis( trans=~.*1, name=secd_axis)) +
  theme(legend.position = "none",
        #legend.background = element_rect(color = "#191919", fill = "#191919"),
        plot.background = element_rect(color = "#191919", fill = "#191919"),
        panel.background = element_rect(color = "#191919", fill = "#191919"),
        panel.grid = element_blank(),
        plot.title = element_text(size = 35, hjust = 0.5),
        #plot.title.position = "panel",
        plot.subtitle = element_text(size = 20, lineheight = .35, margin = margin(b=15)),
        plot.caption = element_text(size = 15),
        plot.margin = margin(c(15, 5,5,5)),
        text = element_text(color="#A2B38B", family = "News Cycle"),
        axis.title.y = element_text(size=25),
        #axis.title.x = element_text(size=15,lineheight = .35),
        #axis.text.x.bottom = element_blank(),
        axis.text = element_text(size = 18,color="#A2B38B"),
        axis.ticks = element_line(color="#A2B38B")) +
  transition_reveal(year) +
  view_follow(fixed_x = TRUE, fixed_y = c(0, NA))


anim
ggsave("sat1.png",anim, width = 1200, height = 1200,dpi=200, units = "px")

animate(anim, 100, fps = 10,  width = 1000, height = 1000,
        renderer = gifski_renderer("gganim.gif"))

