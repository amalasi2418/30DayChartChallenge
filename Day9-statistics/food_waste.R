setwd("~/R/Infographics/30daysChartChallenge/day9")

library(tidyverse)
library(showtext)


showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Outfit","Outfit")

waste <- read_csv("Data.csv")

unique(waste$food_supply_stage)

waste_cereal <- read_csv("Data_cereal_pulses.csv")

waste_meat <- read_csv("Data_meat_dairy.csv")

waste_veggie <- read_csv("Data_fruits_veggie.csv")

waste_oil <- read_csv("Data_root_tuber_oil.csv")

supplychain <- c("Pre-harvest","Harvest","Post-harvest","Farm","Grading","Storage",
                 "Transport","Trader","Processing","Packing",
                 "Distribution","Market","Wholesale","Retail","Food Services","Households")
                # "Export","Whole Supply Chain")


waste_cereal <- waste_cereal[,c(6,7,11)] %>% cbind(category = "Cereals & Pulses")

waste_meat <- waste_meat[,c(6,7,11)] %>% cbind(category = "Meat & Animal Products")

waste_veggie <- waste_veggie[,c(6,7,11)] %>% cbind(category = "Fruits & Vegetables")

waste_oil <- waste_oil[,c(6,7,11)] %>% cbind(category = "Roots & Oil-bearing crops")




waste_cereal %>% filter(!is.na(food_supply_stage)) %>% 
  mutate(food_supply_stage = fct_relevel(food_supply_stage,supplychain)) %>% 
  ggplot(aes(loss_percentage, food_supply_stage)) + geom_boxplot()

# waste_cereal %>% filter(!is.na(food_supply_stage)) %>% 
#   filter(food_supply_stage %in% supplychain) %>% 
#   ggplot(aes(loss_percentage, food_supply_stage)) + geom_boxplot()

waste_meat %>% filter(!is.na(food_supply_stage)) %>% 
  mutate(food_supply_stage = fct_relevel(food_supply_stage,supplychain)) %>% 
  ggplot(aes(loss_percentage, food_supply_stage)) + geom_boxplot()

waste_veggie %>% filter(!is.na(food_supply_stage)) %>% 
  mutate(food_supply_stage = fct_relevel(food_supply_stage,supplychain)) %>%
  ggplot(aes(loss_percentage, food_supply_stage)) + geom_boxplot()

waste_oil %>% filter(!is.na(food_supply_stage)) %>% 
  mutate(food_supply_stage = fct_relevel(food_supply_stage,supplychain)) %>%
  ggplot(aes(loss_percentage, food_supply_stage)) + geom_boxplot() +
  ylab("")+xlab("% loss")+
  theme(panel.grid = element_blank(),
        panel.background = element_rect(color="white",fill="white"),
        plot.background = element_rect(color="white",fill="white"))



waste_total <- rbind(waste_cereal,waste_meat,waste_oil,waste_veggie)

waste_total %>% filter(!is.na(food_supply_stage)) %>% 
  filter(food_supply_stage %in% supplychain) %>%
  mutate(food_supply_stage = fct_relevel(food_supply_stage,supplychain)) %>%
  ggplot(aes(loss_percentage, food_supply_stage)) + 
  geom_boxplot(aes(color=food_supply_stage,fill=food_supply_stage), alpha=.5) +
  ylab("")+xlab("% loss")+
  #scale_fill_viridis(option="mako",begin=.1,discrete = "TRUE")+
  #scale_color_viridis(option="mako",begin=.1,discrete = "TRUE")+
  labs(title = "Food loss along the global supply chain",
       subtitle = "The data depicts the food loss measured between 2000 till 2021 across the\ndifferent stages of the food supply chain. It is interesting to note that\nmost of the waste occurs at household level.",
       caption = "Data: Food and Agriculture Organization of UN | Graphic: Abhinav Malasi")+
  theme(panel.grid = element_blank(),
        panel.background = element_rect(color="#191919",fill="#191919"),
        plot.background = element_rect(color="#191919",fill="#191919"),
        plot.title = element_text(size = 55),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 35, lineheight = .35, margin = margin(t=15,b=10)),
        plot.caption = element_text(size = 25, margin=margin(t=10)),
        plot.margin = margin(c(20,20,20,25)),
        legend.position = "none",
        strip.background = element_blank(),
        strip.text = element_text(color = "#EEEDDE", size = 33),
        axis.text = element_text(color = "#EEEDDE", size = 30),
        axis.title.x = element_text(color = "#EEEDDE", size = 30),
        text = element_text(color = "#EEEDDE", family = "Outfit")) +
  facet_wrap(~category)

ggsave("supply_chain.png",last_plot(),width = 6, height = 8,units = "in")

