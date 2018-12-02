# load libraries
library(dplyr)
library(kableExtra)

allData <- read.csv("../data/data_filtered.csv")

filter_data <- function(state){
  state_data <- allData %>% 
    select(ProviderName, DBAName, HoldingCompanyName, HocoFinal, StateAbbr, MaxAdDown, MaxAdUp, MaxCIRDown, MaxCIRUp) %>% 
    filter(StateAbbr == state) %>% 
    group_by(ProviderName) %>% 
    summarize(AvgMaxAdDown=mean(MaxAdDown), AvgMaxAdUp=mean(MaxAdUp), 
              AvgMaxCIRDown=mean(MaxCIRDown), AvgMaxCIRUp=mean(MaxCIRUp)) %>% 
    filter(AvgMaxAdDown != 0) %>% 
    arrange(desc(AvgMaxAdDown)) %>% 
    knitr::kable(format="html", digits=2, caption=paste0("Table 1: Speed of each Provider in ", state)) %>% 
    kable_styling()
}
