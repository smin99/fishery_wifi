library(shiny)
library(data.table)
library(mapdata)
library(dplyr)
source("scripts/graphs.R")
source("scripts/analysis_text.R")
source("scripts/make_Table.R")

FCC_data <- fread("data/data_filtered.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  output$nationalPlot <- renderPlot({
    make_heat_map(input$display_data1, FCC_data)
  })
  output$statePlot <- renderPlot({
    make_pie_chart(input$display_data2, input$selected_state2, FCC_data)
  })
  output$stats <- renderText({
    generate_percentile_text(input$selected_state2, FCC_data)
  })
  output$barPlot <- renderPlot({
    make_bar_plot(input$display_data3, input$selected_state3, FCC_data)
  })
  output$ispTable <- reactive({
    filter_data(input$selected_state4, FCC_data)
  })
  
})
