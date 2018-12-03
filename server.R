library(shiny)
library(data.table)
library(mapdata)
library(dplyr)
source("scripts/graphs.R")
source("scripts/analysis_text.R")
source("scripts/make_Table.R")

FCC_data <- fread("data/data_filtered.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  output$statePlot <- renderPlot({
    make_pie_chart(input$display_data, input$selected_state, FCC_data)
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
  output$barplot <- renderPlot({
    make_bar_plot(input$display_data, input$selected_state, FCC_data)
  })
})
