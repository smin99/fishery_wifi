library(shiny)
library(data.table)
library(mapdata)
library(dplyr)
source("graphs.R")
source("analysis_text.R")

FCC_data <- fread("data_filtered.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  output$statePlot <- renderPlot({
    make_pie_chart(input$selected_state, FCC_data)
  })
  output$nationalPlot <- renderPlot({
    filtered_data <- FCC_data %>% select(StateName, MaxAdDown)
    states <- map_data("state")
    states$median <- NA
    state_median <- filtered_data %>% group_by(StateName) %>% summarize(median = mean(MaxAdDown))
    for (i in 1:nrow(states)){
      state_name <- states[i, "region"]
      result <- filter(state_median, StateName == state_name)
      if(nrow(result) != 0) {
        states$median[i] = result$median
      }
    }

    ggplot(data = states) + 
      geom_polygon(aes(x = long, y = lat, fill = median, group = group), color = "white") + 
      coord_fixed(1.3) +
      guides(fill=FALSE) + theme_void()
  })
  output$stats <- renderText({
    generate_percentile_text(input$selected_state, FCC_data)
  })
})
