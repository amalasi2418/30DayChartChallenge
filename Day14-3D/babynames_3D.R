setwd("~/R/Infographics/30daysChartChallenge/day14")

library(tidyverse)
library(sysfonts)
library(showtext)
library(ggtext)
library(rayshader)

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Junge","Junge")

babynames <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-22/babynames.csv')


male=babynames%>% filter(sex=="M") %>% group_by(year) %>% summarise(max=max(n))
female=babynames%>% filter(sex=="M") %>% group_by(year) %>% summarise(max=max(n))

for(i in 1:nrow(male)){
male$first_letter[i] <- babynames %>% filter(year==male$year[i] & n==male$max[i]) %>% select(name) %>% substr(1,1)
female$first_letter[i] <- babynames %>% filter(year==male$year[i] & n==male$max[i]) %>% select(name) %>% substr(1,1)
}


babynames_let <- babynames %>% mutate(first_letter = substr(name,1,1))

babynames_summary_m <- babynames_let %>% filter(sex=="M") %>% group_by(year, first_letter) %>% summarise(total = sum(n)) #%>% select(year, first_letter,total) 
babynames_summary_f <- babynames_let %>% filter(sex=="F") %>% group_by(year, first_letter) %>% summarise(total = sum(n)) #%>% select(year, first_letter,total) 
babynames_summary <- babynames_let %>% group_by(year, first_letter,sex) %>% summarise(total = sum(n)) #%>% select(year, first_letter,total) 


baby = babynames_summary %>% 
  filter(year >=2001) %>%
  mutate(sex = case_when(
  sex == "F"~ "Female",
  TRUE ~ "Male")) %>% 
  ggplot() + 
  geom_tile(aes(year, first_letter, fill= total/1e5),size=6) +
  scale_fill_gradient(name="Count (in 10,000's)")+
  xlab("") + ylab("")+
  facet_grid(.~sex) +
   labs(title="How popular is the starting letter of your name?",
        subtitle = "Data spans between 1880-2017 for the registered baby names\nin the USA. The black patch indicates missing data.",
        caption = "Source: babynames R package | Graphic: Abhinav Malasi")+
   theme(plot.background = element_rect(fill="white",color="white"),
         panel.background = element_rect(fill="white",color="white"),
         panel.grid = element_blank(),
         text = element_text(family="Junge",color="#141414"),
         plot.caption = element_text(size=15,face="bold",color="#141414"),
         plot.subtitle = element_text(lineheight=.35,margin = margin(0, 0, 10, 0),size=25,hjust = .5,face="bold",color="#141414"),
         plot.title=element_text(size=37,hjust = .5,face="bold",color="#141414",margin = margin(b=10)),
  #       plot.margin = margin(c(8,12,5,5),unit = "mm"),
         axis.text = element_text(color="#141414",size=20),
         axis.title = element_text(color="#141414",size=23),
  #       legend.position = "top",
  #       legend.box = "horizontal",
         legend.key.size = unit(.5, 'cm'),
         legend.margin = margin(c(0,0,-4,0),unit = "mm"),
         legend.background = element_rect(fill="white",color="white"),
         legend.text = element_text(color="#141414", size = 18, vjust=4),
         legend.title = element_text(color="#141414", size = 22, hjust=-.5,vjust = .85,margin = margin(b=-5)),
         strip.background = element_rect(fill="white",color="white"),
         strip.text = element_text(color="#141414",size =22))

# babynames_summary_m %>% ggplot(aes(year, first_letter, fill= total/1e5)) + 
#   geom_tile() +
#   scale_fill_gradient(low="skyblue", high="blue") 
# 
# 
# babynames_summary_f %>% ggplot(aes(year, first_letter, fill= total/1e5)) + 
#   geom_tile() +
#   scale_fill_gradient(low="pink", high="red") 


baby

plot_gg(baby,multicore=TRUE,width=5,height=5,scale=300,windowsize = c(1400, 866), zoom = 0.5, phi = 30, theta = -30)

#ggsave("babynames_v11.png",last_plot(), width=4,height = 5,units = "in")

render_snapshot("baby_names_3D6", width = 10, height = 10,
                #vignette = FALSE,
                background = "#141414")
                #title_size = 30,
                #title_font = "sans",
                #title_bar_color = NULL,)
