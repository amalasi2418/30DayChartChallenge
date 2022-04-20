setwd("~/R/Infographics/30daysChartChallenge/day19")

library(tidyverse)
library(tidyr)
library(showtext)

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("News Cycle","News Cycle")


unemploy <- readxl::read_xlsx("une_rt_a_h__custom_2527507_spreadsheet.xlsx",skip = 9,sheet = "Sheet 1",)

unemploy[,(1:ncol(unemploy))%%2 == 0]

unemploy_df <- cbind(unemploy[-1,1],unemploy[-1,(1:ncol(unemploy))%%2 == 0]) %>% as.data.frame()

# removing cpountries with missing data and unnecessary rows at the end
unemploy_df <- unemploy_df[-c(33,34,36,38:43),]

# converting from chr to int type
for(i in 2:10)
unemploy_df[,i] <- as.numeric(unemploy_df[,i])

colnames(unemploy_df)[1] <- c("country")


europeanUnion <- c("Austria","Belgium","Bulgaria","Croatia","Cyprus",
                   "Czechia","Denmark","Estonia","Finland","France",
                   "Germany","Greece","Hungary","Ireland","Italy","Latvia",
                   "Lithuania","Luxembourg","Malta","Netherlands","Poland",
                   "Portugal","Romania","Slovakia","Slovenia","Spain",
                   "Sweden")



unemploy_df %>% mutate(country = case_when(country == "Germany (until 1990 former territory of the FRG)" ~ "Germany",
                                           TRUE ~ country)) %>% 
  filter(country %in% europeanUnion) %>%
  gather(year, value, `2005`:`2020`) %>%
  #ggplot(aes(year, country, group = country)) + 
  ggplot() +
  geom_tile(aes(year,country,fill=value)) + 
  # geom_dl(aes(label = country), method = list(dl.trans(x = x + 0.2),
  #                                                        "last.points", cex = 0.8)) +
  #geom_label_repel(aes(label = as.factor(country)),nudge_x = 1, na.rm = TRUE) +
  xlab("") + ylab("")+
  labs(title = "Unemployment in EU (2005 - 2020)",
       caption = "Data: Eurostat | Graphic: Abhinav Malasi") +
  scale_fill_gradientn(colours = c("green","yellow","orange","red"), name = "", limits =c(0,30), labels = paste0(seq(0,30,10),"%"))+
  theme(panel.background = element_rect(color="#EEEDDE",fill = "#EEEDDE"),
        plot.background = element_rect(color="#EEEDDE",fill = "#EEEDDE"),
        panel.grid = element_blank(),
        plot.margin = margin(c(10,10,10,5)),
        plot.title = element_text(size=80, hjust = 0.5),
        plot.title.position = "plot",
        plot.caption = element_text(size=30),
        axis.text = element_text(size=35),
        legend.position = "top",
        #legend.title = element_text(size=35),
        legend.background = element_rect(color="#EEEDDE",fill = "#EEEDDE"),
        legend.key = element_rect(color="#EEEDDE",fill = "#EEEDDE"),
        legend.margin = margin(t=10, b=-10),
        legend.text = element_text(size=35),
        text = element_text(family = "News Cycle",color = "#3A3845")) 


ggsave("unemployment.png", last_plot(), width = 8.5, height = 8, units = "in")

