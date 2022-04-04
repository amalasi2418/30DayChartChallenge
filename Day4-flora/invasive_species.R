setwd("~/R/Infographics/30daysChartChallenge/day4")

library(tidyverse)
library(tabulizer)
library(eurostat)
library(tidyr)
library(sysfonts)
library(showtext)
library(ggtext)

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Junge","Junge")
font_add_google(name="Noto Sans",family="notosans")


invasive1 <- extract_tables("Preslia-AlienFlora-2008.pdf",
                           output = "data.frame",
                           pages = 13,
                           area = list(c(234.01893,66.64034,771.19874,274.06624)),
                           guess = FALSE)

data <- invasive1[[1]]


pg <- locate_areas("Preslia-AlienFlora-2008.pdf",
                   pages = 13)

pg[[1]]


invasive2 <- extract_tables("Preslia-AlienFlora-2008.pdf",
                            output = "data.frame",
                            pages = 14,
                            area = list(c(91.0,65.28076,338.82115,274.71346)),
                            guess = FALSE)


data1 <- invasive2[[1]]


pg1 <- locate_areas("Preslia-AlienFlora-2008.pdf",
                   pages = 14)

pg1[[1]]


###########
# data cleaning


colnames(data) <- c("country","total","Naturalized","Casual","Unspecified","cryptogenic")

colnames(data1) <- c("country","total","naturalized-casual","Unspecified","cryptogenic")

data1 <- data1[1:17,]

split <- (str_split(data1[,3], " "))

v=unlist(split)
v = data.frame(as.numeric(v))
odd <- seq_len(nrow(v)) %% 2
vv = data.frame(Naturalized = v[odd == 1,],Casual = v[odd == 0,])

data1 <- data1 %>% select(-3) %>% cbind(vv)

invasive <- rbind(data,data1)

t = invasive %>% filter(country %in% eu_countries$name) %>% filter(!(country %in% c("Croatia","Bulgaria","Finland")))

b = t[,-c(2,6)] %>% gather(category,value, Naturalized:Unspecified)




b$value= as.numeric(b$value) 

#b %>% filter(!is.na(value))%>% ggplot(aes(value,fct_reorder(country,value),group=country,fill=category)) + geom_col()
bb <- b %>% filter(!is.na(value))

t %>% ggplot(aes(total,fct_reorder(country,total))) + geom_col() +
  geom_col(data=bb,aes(value,country,group=country,fill=category)) +
  labs(title = "Alien flora of Europe", 
       subtitle = "The invasive species are categorised into three categories.<br>Naturalized alien species are self-replacing population,<br>casual alien species can reproduce occasionally, and<br>unspecified means insufficient data to categorize it to<br>either naturalized or casual.",
       caption = "Data: Preslia 80:101-149,2008 | Graphic: Abhinav Malasi") +
  ylab("") + xlab("Total species") + 
  scale_y_discrete(expand = c(0,0)) +
  scale_x_continuous(limits = c(0,2000),expand = c(0,0)) +
  scale_fill_manual(values =  c("#1E5128","#4E9F3D","#D8E9A8"), name = "Category") +
  theme(panel.background = element_rect(color="#191A19",fill="#191A19"),
        plot.background = element_rect(color="#191A19",fill="#191A19"),
        legend.position = "top",
        legend.box.margin=margin(0,0,-10,0),
        legend.title = element_text(color="#D8E9A8",size=18),
        legend.spacing.x = unit(.05, 'cm'),
        legend.text = element_text(color="#D8E9A8",size=18),
        legend.key = element_rect(color="#191A19",fill="#191A19"),
        legend.background = element_rect(color="#191A19",fill="#191A19"),
        legend.key.size = unit(3, 'mm'),
        axis.line = element_blank(),
        axis.text = element_text(color="#D8E9A8",size=20),
        axis.title = element_text(color="#D8E9A8",size=20),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        plot.margin = margin(c(20,30,20,20)),
        plot.title = element_text(size=50,hjust = -0.5),
        plot.subtitle = element_markdown(size=25,lineheight = .35,margin = margin(t=5,l=-45,b=0,r=0)),
        plot.caption = element_text(size=18,margin = margin(t=20)),
        text = element_text(color="#D8E9A8",family = "notosans"))


ggsave("invasive_species.png",last_plot(),width=4,height = 5,units = "in")
