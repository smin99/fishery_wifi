library(shiny)
library(shinydashboard)
states <- read.csv("data/states_filtered.csv", stringsAsFactors = FALSE)
states <- states[order(states$x),]


shinyUI(dashboardPage(
  dashboardHeader(
    title = "\"It's like the WiFi at Fisheries\"",
    dropdownMenu(type = "messages", badgeStatus = NULL,
      messageItem("Instructor","Ott Toomet"),
      messageItem("Teachers Assistant","Alvin Tran"),
      messageItem("Author", "Kevin Wang"),
      messageItem("Author","Howard Xiao"),
      messageItem("Author","Min Hwang"),
      messageItem("Author","Ryker Bukowski"),
      headerText = "Contributers",
      icon = icon("user-circle")),
    titleWidth = 290),
  dashboardSidebar(
    sidebarMenu(
      menuItem("National Internet Speeds", tabName = "heat_map", icon = icon("map")),
      menuItem("Statewide Internet Speeds", tabName = "pie_chart", icon = icon("pie-chart")),
      menuItem("Statewide Modes' Speeds", tabName = "bar_plot", icon = icon("bar-chart")),
      menuItem("Statewide Provider's Speeds", tabName = "table", icon = icon("table"))), 
    width = 290
  ),
  dashboardBody(
    tabItems(
      
      tabItem(tabName = "heat_map",
              fluidRow(
                box(radioButtons("display_data1", "Type of Speed Advertised",
                                 choices = list("Max Download" = 1, "Max Upload" = 2), 
                                 selected = 1), height = 108, background = "navy")
              ),
              fluidRow(
                box(plotOutput("nationalPlot"), width = 12, background = "teal"),
                box(p("This plot shows a heat map of advertised Internet speeds in the contiguous United States,
                      separated by state and the averages of advertised internet speeds. As some states have
                      less Internet Service Providers, they may appear to have higher averages, as opposed to
                      data from larger states which may too be skewed by a large amount of rural dialup. 
                      Supplement your knowledge with the following charts and tables to help you make a better
                      informed decision."), width=12, background = "black")
              )
              
                ),
      
      tabItem(tabName = "pie_chart",
              fluidRow(
                box(radioButtons("display_data2", "Type of Speed Advertised",
                                 choices = list("Max Download" = 1, "Max Upload" = 2), 
                                 selected = 1), height = 108, background = "navy"),
                box(selectInput("selected_state2", "Select a state", 
                                choices = states, 
                                selected = "WA"), height = 108, background = "maroon")
                
              ), 
              fluidRow(
                box(plotOutput("statePlot"), width = 12, background = "teal")
              ),
              fluidRow(
                box(textOutput("stats"), width = 12, background = "black")
              )
      ),
      
      tabItem(tabName = "bar_plot",
              fluidRow(
                box(radioButtons("display_data3", "Type of Speed Advertised",
                                 choices = list("Max Download" = 1, "Max Upload" = 2), 
                                 selected = 1), height = 108, background = "navy"),
                box(selectInput("selected_state3", "Select a state", 
                                choices = states, 
                                selected = "WA"), height = 108, background = "maroon")
              ), 
              fluidRow(
                box(plotOutput("barPlot"), width = 12, background = "teal")
              )
      ),
      
      tabItem(tabName = "table",
              fluidRow(
                box(selectInput("selected_state4", "Select a state", 
                                choices = states, 
                                selected = "WA"), height = 108, background = "maroon")
              ),
              fluidRow(
                box(tableOutput("ispTable"), width = 12, background = NULL)
              )
      )
              )
  )
))
