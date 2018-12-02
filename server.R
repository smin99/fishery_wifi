library(shiny)
library(data.table)

source("graphs.R")

FCC_data <- fread("data_filtered.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  output$statePlot <- renderPlot({
    make_pie_chart(input$selected_state, FCC_data)
  })
  
})
