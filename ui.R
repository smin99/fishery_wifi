library(shiny)

states <- read.csv("states_filtered.csv", stringsAsFactors = FALSE)
states <- states[order(states$x),]
shinyUI(fluidPage(
  
  titlePanel("\"It's like the WiFi at Fisheries\""),
  p("-- An investigation of broadband speeds in the US"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("selected_state", "Select a state", 
                  choices = states, 
                  selected = 1)
    ),
 
    mainPanel(
      plotOutput("nationalPlot"),
      hr(),
      plotOutput("statePlot"),
      plotOutput("distPlot"),
      tableOutput("ispTable")
    )
  )
))
