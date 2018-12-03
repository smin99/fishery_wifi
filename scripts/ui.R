library(shiny)

states <- read.csv("../data/states_filtered.csv", stringsAsFactors = FALSE)
states <- states[order(states$x),]
shinyUI(fluidPage(
  
  titlePanel("\"It's like the WiFi at Fisheries\""),
  p("-- An investigation of broadband service providers in CON US"),
  
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
      p("This plot shows a heatmap of advertised Internet speeds in the contiguous United States,
        separated by state and the averages of advertised internet speeds. As some states have
        less Internet Service Providers, they may appear to have higher averages, as opposed to
        data from larger states which may too be skewed by a large amount of rural dialup. 
        Supplement your knwoledge with the following charts and tables to help you make a better
        informed decision."),
      hr(),
      textOutput("stats"),
      p(),
      plotOutput("barplot"),
      plotOutput("statePlot"),
      tableOutput("ispTable")
    )
  )
))
