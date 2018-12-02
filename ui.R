library(shiny)

states <- read.csv("states_filtered.csv", stringsAsFactors = FALSE)
states <- states[order(states$x),]
shinyUI(fluidPage(
  
  titlePanel("FCC Broadband Data"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("seleceted_state", "Select a state", 
                  choices = states, 
                  selected = 1)
      
    ),
 
    mainPanel(
      plotOutput("statePlot"),
      plotOutput("distPlot")
    )
  )
))
