library(shiny)
library(data.table)
library(mapdata)
library(dplyr)
source("graphs.R")
source("analysis_text.R")
source("make_Table.R")

FCC_data <- fread("../data/data_filtered.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  output$statePlot <- renderPlot({
    make_pie_chart(input$selected_state, FCC_data)
  })
  output$nationalPlot <- renderPlot({
    make_heat_map(input$display_data, FCC_data)
  })
  output$stats <- renderText({
    generate_percentile_text(input$selected_state, FCC_data)
  })
  output$ispTable <- reactive({
    filter_data(input$selected_state)
  })
})
