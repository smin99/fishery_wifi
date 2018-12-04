library(shiny)
library(shinydashboard)
states <- read.csv("data/states_filtered.csv", stringsAsFactors = FALSE)
states <- states[order(states$x),]


shinyUI(dashboardPage(
  dashboardHeader(title = "Like WiFi at Fisheries"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("National Data", tabName = "heat_map", icon = icon("map")),
      menuItem("Each State's Data", tabName = "pie_chart", icon = icon("pie-chart")),
      menuItem("Each Mode of Service", tabName = "bar_plot", icon = icon("bar-chart")),
      menuItem("Each Provider", tabName = "table", icon = icon("table"))
    )
  ),
  dashboardBody(
    tabItems(
      
      tabItem(tabName = "heat_map",
              fluidRow(
                box(plotOutput("nationalPlot"), width = 12),
                box(p("This plot shows a heatmap of advertised Internet speeds in the contiguous United States,
                      separated by state and the averages of advertised internet speeds. As some states have
                      less Internet Service Providers, they may appear to have higher averages, as opposed to
                      data from larger states which may too be skewed by a large amount of rural dialup. 
                      Supplement your knwoledge with the following charts and tables to help you make a better
                      informed decision."), width=12)
                ),
              fluidRow(
                box(radioButtons("display_data1", "Type of Speed Advertised",
                                 choices = list("Max Download" = 1, "Max Upload" = 2), 
                                 selected = 1),  width = 4)
                
                
              )
                ),
      
      tabItem(tabName = "pie_chart",
              fluidRow(
                box(radioButtons("display_data2", "Type of Speed Advertised",
                                 choices = list("Max Download" = 1, "Max Upload" = 2), 
                                 selected = 1)),
                box(selectInput("selected_state2", "Select a state", 
                                choices = states, 
                                selected = "WA"))
                
              ), 
              fluidRow(
                box(plotOutput("statePlot"), width = 12)
              ),
              fluidRow(
                box(textOutput("stats"), width = 12)
              )
      ),
      
      tabItem(tabName = "bar_plot",
              fluidRow(
                box(radioButtons("display_data3", "Type of Speed Advertised",
                                 choices = list("Max Download" = 1, "Max Upload" = 2), 
                                 selected = 1)),
                box(selectInput("selected_state3", "Select a state", 
                                choices = states, 
                                selected = "WA"))
              ), 
              fluidRow(
                box(plotOutput("barPlot"), width = 12)
              )
      ),
      
      tabItem(tabName = "table",
              fluidRow(
                box(selectInput("selected_state4", "Select a state", 
                                choices = states, 
                                selected = "WA"))
              ),
              fluidRow(
                box(tableOutput("ispTable"), width = 12)
              )
      )
              )
  )
))
