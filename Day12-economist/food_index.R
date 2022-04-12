setwd("~/R/Infographics/30daysChartChallenge/day12")

library(tidyverse)
library(countrycode)
library(ggthemes)
library(showtext)
library(lubridate)

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Varta","Varta")

index <- read_csv("Food_price_indices_data_apr861.csv", skip = 2)




index$Date <- parse_date_time(index$Date, "ym")

index_ym <- index[,1:2] %>% mutate(month = month(Date),
                             year = year(Date)) %>% filter(year > 2016)

colnames(index_ym)[2] <- c("index")

# index_ym$month <- month.abb[as.numeric(index_ym$month)]

# function for adding red bar 
# ref: https://stackoverflow.com/questions/64656234/how-does-the-economist-make-these-lines-near-the-title-using-using-ggplot
# OPTION 2
annotate_npc <- function(x, y, height, width, ...) {
  grid::grid.draw(grid::rectGrob(
    x = unit(x, "npc"), y = unit(y, "npc"), height = unit(height, "npc"), width = unit(width, "npc"),
    gp = grid::gpar(...)
  ))
}

png("food_price_index.png", width=4, height=4,unit='in', res = 300)

index_ym %>% ggplot(aes(month,index, group=year))+
  geom_line(aes(color=as.factor(year)),size=1) +
  ylab("") + xlab("") +
  coord_cartesian(clip = "off") +
  geom_hline(yintercept = 80, color = "#B3B3B3")+
  geom_hline(yintercept = 100, color = "#B3B3B3")+
  geom_hline(yintercept = 120, color = "#B3B3B3")+
  geom_hline(yintercept = 140, color = "#B3B3B3")+
  geom_hline(yintercept = 160, color = "#B3B3B3")+
  annotate(geom = "text", x=3.05, y=150, label = "2022", family="Varta", color="#C91D42", size=8)+
  annotate(geom = "text", x=12, y=137, label = "2021", family="Varta", color="#E2365B", size=8)+
  annotate(geom = "text", x=12, y=110, label = "2020", family="Varta", color="#F9A1CA", size=8)+
  annotate(geom = "text", x=1.5, y=90, label = "2019", family="Varta", color="#333333", size=8)+
  annotate(geom = "text", x=12, y=90, label = "2018", family="Varta", color="#595959", size=8)+
  annotate(geom = "text", x=7, y=102, label = "2017", family="Varta", color="#B3B3B3", size=8)+
  annotate(geom = "text", x=1, y=80, label = "80",vjust=-.5,hjust=1.5, family="Varta", color="#595959", size=8)+
  annotate(geom = "text", x=1, y=100, label = "100",vjust=-.5,hjust=1.3, family="Varta", color="#595959", size=8)+
  annotate(geom = "text", x=1, y=120, label = "120",vjust=-.5,hjust=1.3, family="Varta", color="#595959", size=8)+
  annotate(geom = "text", x=1, y=140, label = "140",vjust=-.5,hjust=1.3, family="Varta", color="#595959", size=8)+
  annotate(geom = "text", x=1, y=160, label = "160",vjust=-.5,hjust=1.3, family="Varta", color="#595959", size=8)+
  labs(title = "Food price index", 
       subtitle = "There has been a surge in the index since the start of war between\nRussia and Ukraine.\nGlobal food prices, 2014-16 = 100",
       caption = "Data: Food and Agriculture Organisation | Graphic: Abhinav Malasi") +
  scale_color_manual(values = c("#B3B3B3","#595959","#333333","#F9A1CA","#E2365B","#C91D42")) +
  scale_x_continuous(breaks = 0:12,labels = c("","J","F","M","A","M","J","J","A","S","O","N","D"), expand = c(0.05,0))+
  scale_y_continuous(limits = c(80,160),breaks = seq(80,160,20), labels = seq(80,160,20)) +
  theme(text=element_text(family = "Varta"),
        legend.position = "none",
        panel.background = element_rect(color="#FFFFFF",fill="#FFFFFF"),
        plot.background = element_rect(color="#FFFFFF",fill="#FFFFFF"),
        plot.title = element_text(size=40, face = "bold", margin = margin(t=10,b=5)),
        plot.subtitle = element_text(size=30, lineheight = .35),
        plot.caption = element_text(size=20),
        axis.text.y = element_blank(),
        axis.text.x = element_text(size=25),
        axis.ticks.y = element_blank(),
        axis.line.x = element_line(size=1)) 
  annotate_npc(x = 0.13, y = 1, height = 0.05, width = 0.15, fill = "#F6423C", col = NA)


#ggsave("food_price_index.png", last_plot(), width = 4, height = 5, units="in")

  dev.off()
  
  