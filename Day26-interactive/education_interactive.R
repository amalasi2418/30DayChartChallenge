setwd("~/R/Infographics/30daysChartChallenge/day26")

library(tidyverse)
library(plotly)
library(countrycode)
library(showtext)

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Varta","Varta")

population <- read_csv("learning-outcomes-vs-gdp-per-capita.csv") %>% filter(Year == max(Year))

gender <- read_csv("gender-ratios-for-mean-years-of-schooling.csv") %>% filter(Year == max(Year))

comp_edu <- read_csv("duration-of-compulsory-education.csv")%>% filter(Year == max(Year))

mean_school <- read_csv("mean-years-of-schooling-long-run.csv")%>% filter(Year == 2016)

gdp <- read_csv("mobile-phone-subscriptions-vs-gdp-per-capita.csv") %>% filter(Year == 2016)

a=merge(gdp,mean_school,by = "Entity")

final_df = merge(a,comp_edu, by="Entity") 

final_df <- final_df[,-c(4,7:9,11,12)]

colnames(final_df) <- c("country","code","year", "GDP","population","schooling_years","compulsory_edu")

final_df$continent <- countrycode(sourcevar = final_df$country,
                                     origin = "country.name",
                                     destination = "continent")

p <- final_df %>% 
  filter(!is.na(continent)) %>%
  ggplot(aes(GDP, schooling_years, 
             size=population, 
             color=continent, 
             text=paste0("Country: ",country,"\nCompulsory education (years): ",compulsory_edu))) +
  geom_point() +
  scale_x_log10(label = scales::comma) + 
  scale_y_continuous(limits = c(0,15)) +
  xlab("GDP per capita (adjusted US $, log scale)") +
  ylab("Schooling years") +
  annotate(geom="text", y=.5, x=25000,label="Data: OurWorldInData.org | Graphic: Abhinav Malasi",color="#313131" ,family="Verta",size=3)+
  labs(title = "Schooling Years as of 2017") +
  scale_color_manual(values = c(
    "Africa" = "#eaac8b", "Americas" = "#6d597a", "Asia" = "#b56576",
    "Europe" = "#e56b6f", "Oceania" = "#355070"), name="") + 
  theme(panel.background = element_rect(color="#EEEEEE",fill="#EEEEEE"),
        plot.background = element_rect(color="#EEEEEE",fill="#EEEEEE"),
        panel.grid = element_blank(),
        plot.title = element_text(size=45, hjust=-.1),
        plot.title.position = "plot",
        text = element_text(family = "Varta"),
        plot.margin = margin(c(10,10,10,10)),
        axis.text = element_text(size=20),
        axis.title = element_text(size=25),
        legend.position = "horizontal",
        legend.background =  element_rect(color="#EEEEEE",fill="#EEEEEE"),
        legend.title = element_blank()) 

ggplotly(p)

