library(shiny)
library(data.table)
library(mapdata)
source("graphs.R")
source("analysis_text.R")

FCC_data <- fread("data_filtered.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  output$statePlot <- renderPlot({
    make_pie_chart(input$selected_state, FCC_data)
  })
  output$nationalPlot <- renderPlot({
    filtered_data <- FCC_data %>% select(StateAbbr, MaxAdDown)
    state_averages
    states <- map_data("state")
    states <- states %>% mutate(region = state.abb[which(state.name == region)])
    ggplot(data = states) + 
      geom_polygon(aes(x = long, y = lat, group = group), color = "white") + 
      coord_fixed(1.3) +
      guides(fill=FALSE) + theme_void()
  })
  output$stats <- renderText({
    generate_percentile_text(input$selected_state, FCC_data)
  })
})
