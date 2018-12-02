library(shiny)

states <- read.csv("../data/states_filtered.csv", stringsAsFactors = FALSE)
states <- states[order(states$x),]
shinyUI(fluidPage(
  
  titlePanel("\"It's like the WiFi at Fisheries\""),
  p("-- An investigation of broadband speeds in the US"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("display_percentile", "Choose a percentile",
                   choices = list("25th percentile" = 0.25, "median" = 0.5, "75th percentile" = 0.75), 
                   selected = 0.25),
      selectInput("selected_state", "Select a state", 
                  choices = states, 
                  selected = 1)
    ),
 
    mainPanel(
      plotOutput("nationalPlot"),
      hr(),
      textOutput("stats"),
      plotOutput("statePlot"),
      plotOutput("distPlot"),
      tableOutput("ispTable")
    )
  )
))
