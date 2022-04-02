setwd("~/R/30DayChartChallenge/Day2-pictogram") 

library(tidyverse)
library(ggimage)
library(showtext)
library(ggh4x)
library(ggtext)

font_add_google("Bitter")
showtext_auto()




EPL <- read_tsv("EPL.txt")

EPL_win <- EPL[,c(1,3)] %>% 
  filter(Year > 1992) %>% 
  mutate(Year = Year-1)

EPL_win <- rbind(EPL_win,c(Year=2021,Winner="")) %>% 
  arrange(desc(Year)) %>%
  mutate(Year = as.numeric(Year),id = rep(10:1,3))


Teams <- unique(EPL$Winner)



EPL_df <- EPL_win %>% mutate(Year = as.character(case_when(
  Year < 2002 ~ 1992,
  Year < 2012 ~ 2002,
  TRUE ~ 2012)),
  logo = case_when(
    Winner == "Manchester United" ~ "~/R/30DayChartChallenge/Day2-pictogram/logos/Manchester_United_FC.png",
    Winner == "Manchester City" ~ "~/R/30DayChartChallenge/Day2-pictogram/logos/Manchester_City_FC.png",
    Winner == "Liverpool FC" ~ "~/R/30DayChartChallenge/Day2-pictogram/logos/Liverpool_FC.png",
    Winner == "Chelsea FC" ~ "~/R/30DayChartChallenge/Day2-pictogram/logos/Chelsea_FC.png",
    Winner == "Arsenal FC" ~ "~/R/30DayChartChallenge/Day2-pictogram/logos/Arsenal_FC.png",
    Winner == "Leicester City" ~ "~/R/30DayChartChallenge/Day2-pictogram/logos/Leicester_City.png",
    Winner == "Blackburn Rovers" ~ "~/R/30DayChartChallenge/Day2-pictogram/logos/Blackburn_Rovers.png",
    TRUE ~ "~/R/30DayChartChallenge/Day2-pictogram/logos/Premier_league_trophy.png"
  ))


asp_ratio <- 1.1 

EPL_df %>% ggplot(aes(id*asp_ratio,Year))+
  geom_image(aes(image=logo),size=.09) +
  labs(title="30 years of English Premier League",
       caption = "Source: English Premier League | Logos: Wikipedia | Graphic: Abhinav Malasi",
       subtitle = "<span style = 'color:#DA291C;'>Manchester United</span> had dominated the Premier League since its<br>inception, but in the last decade their derby rivals, <span style = 'color:#6CABDD;'>Manchester<br>City</span>, have been ruling the league table. The winner of each season<br>are represented by their logos. The trophy represents ongoing<br>season." )+
  xlab("")+ylab("") + xlim(0.8,11)+
  #scale_y_discrete(expand = c(0, 1.5))+
  scale_y_discrete(expand = expansion(mult = .9))+
  #coord_fixed(ratio=.5)+
  theme(panel.background = element_rect(color="#141414",fill="#141414"),
        plot.background = element_rect(color="#141414",fill="#141414"),
        aspect.ratio = 1/asp_ratio,
        plot.margin = margin(c(-10,20,0,10), unit = "mm"),
        plot.title = element_text(size=120,face="bold",margin = margin(t=15,b=-65)),
        plot.subtitle = element_markdown(lineheight=.35,size=70,margin = margin(t=120,b=-120,r=5)),
        plot.caption = element_text(size=40,margin = margin(t=-105,b=-60)),
        text = element_text(family = "Bitter",color="white"),
        panel.grid = element_blank(),
        axis.text = element_text(color="white",size=50, family="Bitter"),
        axis.ticks = element_blank(),
        axis.text.x = element_blank()) 


ggsave("EPL.png", last_plot(), width = 10*asp_ratio, height = 10, units = "in")
