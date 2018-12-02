# load libraries
library(dplyr)

allData <- read.csv("../data/data_filtered.csv")

filter_data <- function(state){
  state_data <- allData %>% 
    select(ProviderName, DBAName, HoldingCompanyName, HocoFinal, StateAbbr, MaxCIRDown, MaxCIRUp) %>% 
    filter(StateAbbr == "WA") %>% 
    group_by(ProviderName) %>% 
    summarize(AvgMaxCIRDown=mean(MaxCIRDown), AvgMaxCIRUp=mean(MaxCIRUp)) %>% 
    arrange(MaxCIRDown)
}