library(shiny)

states <- read.csv("../data/states_filtered.csv", stringsAsFactors = FALSE)
states <- states[order(states$x),]
shinyUI(fluidPage(
  
  titlePanel("\"It's like the WiFi at Fisheries\""),
  p("-- An investigation of broadband service providers in the US"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("display_data", "Type of Speed Advertised",
                   choices = list("Max Download" = 1, "Max Upload" = 2), 
                   selected = 1),
      selectInput("selected_state", "Select a state", 
                  choices = states, 
                  selected = "WA")
    ),
 
    mainPanel(
      plotOutput("nationalPlot"),
      hr(),
      textOutput("stats"),
      p(),
      plotOutput("barplot"),
      plotOutput("statePlot"),
      tableOutput("ispTable")
    )
  )
))
