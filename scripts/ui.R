library(shiny)

states <- read.csv("../data/states_filtered.csv", stringsAsFactors = FALSE)
states <- states[order(states$x),]
shinyUI(fluidPage(
  
  titlePanel("\"It's like the WiFi at Fisheries\""),
  p("-- An investigation of broadband speeds in the US"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("display_data", "Download or Upload",
                   choices = list("Download" = 1, "Upload" = 2), 
                   selected = 1),
      selectInput("selected_state", "Select a state", 
                  choices = states, 
                  selected = 1)
    ),
 
    mainPanel(
      plotOutput("nationalPlot"),
      hr(),
      textOutput("stats"),
      plotOutput("statePlot"),
      tableOutput("ispTable")
    )
  )
))
