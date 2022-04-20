setwd("~/R/Infographics/30daysChartChallenge/day20")


fertility <- read_csv("total-fertility-rate-slope-chart.csv")

colnames(fertility)[4] <- c("Fertility")

#asia = fertility %>% filter(Entity =="Asia")

#asia %>% ggplot(aes())


regions <- c("World","Asia", "Europe", "Africa","North America", "South America","Oceania")

world = fertility %>% filter(Entity %in% regions & Year >= 1950) %>% 
  select(-Code, -`Population (historical estimates)`,-Continent) %>% filter(!is.na(Fertility))

world = spread(world,Entity, Fertility)

write.csv(world,"fertility.csv",row.names = FALSE)
