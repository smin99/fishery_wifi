library(ggplot2)
library(mapdata)
library(dplyr)


#pie-chart code
make_pie_chart <- function(display_data, state, FCC_data) {
  if(display_data ==1){
    filtered_FCC <- FCC_data %>% filter(StateAbbr == state) %>% 
      select(MaxAdDown)
    #filtering between data speeds with filter. separating speeds sort of logarithmically
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
  } else {
    filtered_FCC <- FCC_data %>% filter(StateAbbr == state) %>% 
      select(MaxAdUp)
    range_1_less<- filtered_FCC %>% filter(MaxAdUp <= 1) %>% nrow()
    range_1_10 <- filtered_FCC %>% filter(MaxAdUp > 1 & MaxAdUp < 10) %>% nrow()
    range_10_100 <- filtered_FCC %>% filter(MaxAdUp >= 10 & MaxAdUp < 100) %>% nrow()
    range_100_1000 <- filtered_FCC %>% filter(MaxAdUp >= 100 & MaxAdUp < 1000) %>% nrow()
    range_1000_more <- filtered_FCC %>% filter(MaxAdUp >= 1000) %>% nrow()
    range_name <- c("<1 mbps", "1-10 mbps", "10-100 mbps", "100-1000 mbps", "1000+ mbps")
    range_value <- c(range_1_less,  range_1_10, range_10_100, range_100_1000, range_1000_more)
    range_data <- data.frame(range_name, range_value)
    range_data <- range_data %>% rename(range = range_name) %>% 
      rename(value = range_value)
  }
 
  #bar plot
  ggplot(range_data, aes(x="", y=value, fill=range))+
    geom_bar(width = 2, stat = "identity", color = "black") + 
    coord_polar("y", start=0) + 
    ggtitle(paste0("Advertised Speed Categories in ", state)) +
    scale_fill_brewer(palette = "Pastel1") +
    theme_void() +
    theme(plot.title = element_text(size=22))
}
#heat map information
make_heat_map <- function(display_data, FCC_data) {
  if (display_data ==1){
    filtered_data <- FCC_data %>% select(StateName, MaxAdDown)
    states <- map_data("state")
    states$percentile <- NA
    state_percentile <- filtered_data %>% group_by(StateName) %>% summarize(percentile = mean(MaxAdDown))
    graph_name <- "Download"
  }else{
    filtered_data <- FCC_data %>% select(StateName, MaxAdUp)
    states <- map_data("state")
    states$percentile <- NA
    state_percentile <- filtered_data %>% group_by(StateName) %>% summarize(percentile = mean(MaxAdUp))
    graph_name <- "Upload"
  }

  for (i in 1:nrow(states)){
    state_name <- states[i, "region"]
    result <- filter(state_percentile, StateName == state_name)
    if(nrow(result) != 0) {
      states$percentile[i] = result$percentile
    }
  }
  states <- states %>% rename(Mbps = percentile)
  ggplot(data = states) + 
    geom_polygon(aes(x = long, y = lat, fill = Mbps, group = group), color = "white") + 
    coord_fixed(1.3) + 
    scale_fill_gradient2(low = "yellow", high = "red") + 
    ggtitle(paste0("National Mean Advertised Internet ", graph_name, " Speed")) + 
    theme(plot.title = element_text(size=22))
}
#bar plot for displaying different forms of internet services
make_bar_plot <- function(display_data, state, FCC_data) {
  if(display_data ==1){
    needed_data <- FCC_data %>% filter(StateAbbr == state) %>% 
      select(TechCode,  MaxAdDown)
    DSL <- median((needed_data %>% filter(TechCode >= 10 & TechCode < 40))$MaxAdDown)
    Cable <- median((needed_data %>% filter(TechCode >= 40 & TechCode < 50))$MaxAdDown)
    Fiber <- median((needed_data %>% filter(TechCode >= 50 & TechCode < 60))$MaxAdDown)
    Satellite_and_others <- median((needed_data %>% filter(TechCode >= 60))$MaxAdDown)
    graphing_data <- data.frame(Type = c("DSL", "Cable", "Fiber", "Satellite and others"), 
                                Average.Speed = c(DSL, Cable, Fiber, Satellite_and_others))
    ggplot(graphing_data, aes(x = Type, y = Average.Speed, fill = Type)) + geom_bar(stat="identity") + 
      coord_flip()  + scale_fill_brewer(palette="YlGnBu") +
      ggtitle("Median Advertised Speed of Each Mode of Service") + 
      theme(plot.title = element_text(size=22))

  } else {
    needed_data <- FCC_data %>% filter(StateAbbr == state) %>% 
      select(TechCode,  MaxAdUp)
    DSL <- median((needed_data %>% filter(TechCode >= 10 & TechCode < 40))$MaxAdUp)
    Cable <- median((needed_data %>% filter(TechCode >= 40 & TechCode < 50))$MaxAdUp)
    Fiber <- median((needed_data %>% filter(TechCode >= 50 & TechCode < 60))$MaxAdUp)
    Satellite_and_others <- median((needed_data %>% filter(TechCode >= 60))$MaxAdUp)
    graphing_data <- data.frame(Type = c("DSL", "Cable", "Fiber", "Satellite and others"), 
                                Average.Speed = c(DSL, Cable, Fiber, Satellite_and_others))
    ggplot(graphing_data, aes(x = Type, y = Average.Speed, fill = Type)) + geom_bar(stat="identity") + 
      coord_flip()  + scale_fill_brewer(palette="YlGnBu") +
      ggtitle("Median Advertised Speed of Each Mode of Service") +
      theme(plot.title = element_text(size=22))

  }
}
