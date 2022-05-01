setwd("~/R/Infographics/30daysChartChallenge/day29")

library(tidyverse)
library(rvest)
library(data.table)
library(ggrepel)
library(cowplot)
library(tidyr)
library(showtext)

showtext_auto()

sysfonts::font_families_google()
sysfonts::font_add_google("Bitter","Bitter")

url <- "https://en.wikipedia.org/wiki/Transistor_count"
webpage <- read_html(url)
tbls <- html_nodes(webpage, ".wikitable")

# Shows all tables
tbls
df <- html_table(tbls, fill = TRUE)[[2]]



# fixing the MOS transistor count column
temp = vector()

for (i in 1:nrow(df)) {
 temp[i] =gsub("\\[.*","",df[i,2])
 temp[i] =gsub("\\(.*","",temp[i])
 temp[i] =gsub("\\+.*","",temp[i])
}
 
# repeat 3 times to remove commas
for (i in 1:3) {
  temp = sub(",","",temp) # 3 times
}




df$temp = as.numeric(temp)

# repeating for fixing the year column

temp1 =vector()

for (i in 1:nrow(df)) {
  temp1[i] =gsub("\\[.*","",df[i,3])
}

df$year <- as.numeric(temp1)


# fixing some NA values in MOS transistor count
df[199,7] <- 18000000000
df[202,7] <- 26000000000


# cost

cost <- read_csv("historical-cost-of-computer-memory-and-storage.csv")

cost_long <- gather(cost,storage, cost, memory:ssd)



final_df= merge(df, cost_long, by.x="year",by.y="Year")

final_df %>% 
  filter(storage =="memory" | storage =="disk_drives") %>%
  ggplot(aes(temp,cost)) + 
  geom_point(color="#52057B",size=1.5) + 
  geom_smooth(color="#BC6FF1",size=1) +
  scale_x_log10(label = scales::comma, breaks = c(1e3,1e5,1e7,1e9) ,limit = c(1000,NA),expand=c(0,0)) + 
  scale_y_log10(label = c("<0.0001 $/MB","0.1 $/MB","100 $/MB","100,000 $/MB"), breaks = c(.0001,.1,1e2,1e5),expand=c(0,.5)) +
  xlab("Transistor count") +
  ylab("") +
  coord_cartesian(clip = "off") +
  annotate(geom="text",y=5.8e-6,x=1.1e8,label="Apple M1 (year: 2020)", color="#EFA8E4",family="Bitter",size=8) +
  annotate("segment", x = 8e8, y =5.8e-6, xend = 1.6e10, yend = 1.62e-5,color="#EFA8E4",size=.25,
           arrow = arrow(type = "closed", length = unit(0.02, "npc"))) +
  annotate(geom="text",y=1.2e5,x=60000,label="Intel 4040 (year: 1974)", color="#EFA8E4",family="Bitter",size=8) +
  annotate("segment", x = 9000, y = 1.2e5, xend = 3000, yend = 314573,color="#EFA8E4",size=.25,
           arrow = arrow(type = "closed", length = unit(0.02, "npc"))) +
  annotate(geom = "text", x= 1200,y=30e5, label="US dollars per megabyte", color="#EFA8E4",family="Bitter",size=11)+
  labs(title = "Rapid evolution of computer memory cost (1970 - 2020)",
       subtitle = "Integrated circuits (ICs) invented in 1958 changed the computing power altogether.\nDr. Moore's observation of doubling of transistors on ICs every 2 years became the\nbenchmark for the processor industry know as Moore's Law. In 1971, Intel came up\nwith the first microprocessor. Since then the transistor count on an IC has increased\n~ 10 million folds. The axis are log scales.",
       caption = "Data: OurWorldInData.org and Wikipedia.org | Graphic: Abhinav Malasi") +
  theme(panel.grid = element_blank(),
        panel.background = element_rect(color="#000000", fill="#000000"),
        plot.background = element_rect(color="#000000", fill="#000000"),
        legend.position = "none",
        plot.title = element_text(size=40,margin=margin(b=10)),
        plot.subtitle = element_text(size=25,lineheight = .35),
        plot.caption = element_text(size=20,margin=margin(t=15)),
        plot.margin = margin(c(20,10,15,10)),
        axis.text = element_text(color="#EFA8E4",size=25),
        axis.title.x=element_text(size=30,margin=margin(5,0,0,0),hjust = 1),
        axis.ticks = element_line(color="#EFA8E4"),
        text = element_text(color="#EFA8E4", family = "Bitter"))


ggsave("story4.png", last_plot(),width = 6, height = 5, dpi=300, units = "in")
