library(ggplot2)
library(mapdata)
library(dplyr)

make_pie_chart <- function(state, FCC_data) {
  filtered_FCC <- FCC_data %>% filter(StateAbbr == state) %>% 
    select(MaxAdDown)
  range_1_less<- filtered_FCC %>% filter(MaxAdDown <= 1) %>% nrow()
  range_1_10 <- filtered_FCC %>% filter(MaxAdDown > 1 & MaxAdDown < 10) %>% nrow()
  range_10_100 <- filtered_FCC %>% filter(MaxAdDown >= 10 & MaxAdDown < 100) %>% nrow()
  range_100_1000 <- filtered_FCC %>% filter(MaxAdDown >= 100 & MaxAdDown < 1000) %>% nrow()
  range_1000_more <- filtered_FCC %>% filter(MaxAdDown >= 1000) %>% nrow()
  range_name <- c("<1 mbps", "1-10 mbps", "10-100 mbps", "100-1000 mbps", "1000+ mbps")
  range_value <- c(range_1_less,  range_1_10, range_10_100, range_100_1000, range_1000_more)
  range_data <- data.frame(range_name, range_value)
  range_data <- range_data %>% rename(range = range_name) %>% 
    rename(value = range_value)
  
  ggplot(range_data, aes(x="", y=value, fill=range))+
    geom_bar(width = 2, stat = "identity", color = "black") + 
    coord_polar("y", start=0) + 
    ggtitle(paste0("Max Advertised Download Speeds in ", state)) +
    scale_fill_brewer(palette = "Set1") +
    theme_void() +
    theme(plot.title = element_text(size=22))
}

make_heat_map <- function(display_percentile, FCC_data) {
  filtered_data <- FCC_data %>% select(StateName, MaxAdDown)
  states <- map_data("state")
  states$percentile <- NA
  state_percentile <- filtered_data %>% group_by(StateName) %>% summarize(percentile = quantile(MaxAdDown, probs = as.numeric(display_percentile)))
  for (i in 1:nrow(states)){
    state_name <- states[i, "region"]
    result <- filter(state_percentile, StateName == state_name)
    if(nrow(result) != 0) {
      states$percentile[i] = result$percentile
    }
  }
  
  ggplot(data = states) + 
    geom_polygon(aes(x = long, y = lat, fill = percentile, group = group), color = "white") + 
    coord_fixed(1.3) + guides(fill=FALSE) + theme_void()
}