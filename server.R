library(shiny)
library(data.table)

FCC_data <- fread("data_filtered.csv", stringsAsFactors = FALSE)
shinyServer(function(input, output) {
  # graph the state data pie chart
  output$statePlot <- renderPlot({
    filtered_FCC <- FCC_data %>% filter(StateAbbr == toString(input$selected_state)) %>% 
      select(MaxAdDown)
    range_1_10 <- filtered_FCC %>% filter(MaxAdDown >= 1 & MaxAdDown < 10) %>% nrow()
    range_10_100 <- filtered_FCC %>% filter(MaxAdDown >= 10 & MaxAdDown < 100) %>% nrow()
    range_100_1000 <- filtered_FCC %>% filter(MaxAdDown >= 100 & MaxAdDown < 1000) %>% nrow()
    range_1000_more <- filtered_FCC %>% filter(MaxAdDown >= 1000) %>% nrow()
    range_name <- c("1-10 mbps", "10-100 mbps", "100-1000 mbps", "1000+ mbps")
    range_value <- c(range_1_10,  range_10_100,  range_100_1000,  range_1000_more)
    range_data <- data.frame(range_name, range_value)
    range_data <- range_data %>% rename(range = range_name) %>% 
      rename(value = range_value)
    
    ggplot(range_data, aes(x="", y=value, fill=range))+
      geom_bar(width = 2, stat = "identity", color = "black") + 
      coord_polar("y", start=0) + 
      ggtitle("Total Sightings of each UFO shapes") +
      theme(plot.title = element_text(size=22))
    
  })
  
})
