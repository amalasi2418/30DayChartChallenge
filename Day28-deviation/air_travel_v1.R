setwd("~/R/Infographics/30daysChartChallenge/day28")

library(tidyverse)
library(tidyr)
library(showtext)
library(ggforce)
library(ggtext)

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Bitter","Bitter")

travel <- read_csv("API_IS.AIR.PSGR_DS2_en_csv_v2_3919086.csv",skip = 4)  %>% select(-X66)

travel_long <- gather(travel, year, passenger, `1960`:`2020`) %>% filter(!is.na(passenger))


spiral <- travel_long %>% 
  filter(`Country Name`=="World") %>% 
  select(year,passenger) %>% mutate(passenger=passenger/1e9) 

theta = seq(0,8*pi,length = nrow(spiral))

spiral$x = cos(theta+3*pi/4)
spiral$y = sin(theta+3*pi/4)


circle = data.frame(x0 = 0,y0=0,r=1:4)

circle %>% ggplot() + 
  geom_circle(aes(x0=x0,y0=y0,r=r),color="#035397",size=1) + 
  xlab("") +ylab("") +
  annotate(geom="text",x = 0,y=3.8, label="4 billion", color= "#035397",size=12, family="Bitter")+
  annotate(geom="text",x = 0,y=2.8, label="3 billion", color= "#035397",size=12, family="Bitter")+
  annotate(geom="text",x = 0,y=1.8, label="2 billion", color= "#035397",size=12, family="Bitter")+
  annotate(geom="text",x = 0,y=.8, label="1 billion", color= "#035397",size=12, family="Bitter")+
  annotate(geom="text",x = 0.2,y=0.2, label="1970", color= "#CDBE78",size=15, family="Bitter")+
  annotate(geom="text",x = -1.7,y=4.4, label="2019", color= "#CDBE78",size=15, family="Bitter")+
  annotate(geom="text",x = -1.25,y=1, label="2020", color= "#CDBE78",size=15, family="Bitter")+
  geom_path(data=spiral, aes(passenger*x,passenger*y),color="#FCD900",size=1) +
  geom_point(data=spiral, aes(passenger*x,passenger*y),color="#FCD900",size=4) +
  geom_path(data=spiral[-50,], aes(passenger*x,passenger*y),color="#E8630A",size=1) +
  geom_point(data=spiral[-50,], aes(passenger*x,passenger*y),color="#E8630A",size=4) +
  scale_x_continuous(expand = c(0,0)) +
  scale_y_continuous(expand = c(0,.1)) +
  coord_equal() +
  labs(title = "Air industry in peril",
       subtitle = "2020 was the worst year for the air industry, as the industry saw about 60%<br>decline in air travel due to COVID-19. Before 2020, the air industry saw a<br>continous increase in air travel. The data is for the total passengers travelled<br>in the last 5 decades (1970-2020). Each point represents total passengers<br>travelled in the year, with 1970 as inner most point spiraling outwards<br>till 2019, before it crashes below 2 billion passenger threshold in 2020.<br>The passenger count is in billions.",
       caption = "Data: WorldBank | Graphic: Abhinav Malasi")+
  theme(legend.position = "none",
        plot.background = element_rect(color="#001E6C",fill="#001E6C"),
        panel.background = element_rect(color="#001E6C",fill="#001E6C"),
        panel.grid = element_blank(),
        plot.title.position = "plot",
        plot.title = element_text(size=100,face = "bold", margin = margin(t=10,b=15)),
        plot.subtitle = element_markdown(size=45,lineheight = .35,margin = margin(b=15)),
        plot.caption = element_text(size=30),
        plot.margin = margin(c(20,-15,15,-15)),
        axis.text = element_blank(),
        text = element_text(family = "Bitter",color="#F2F2F2"))


ggsave("deviation_v1_7.png", last_plot(), width = 9, height = 10, dpi=300, units = "in")