# load libraries
library(dplyr)
library(kableExtra)

allData <- read.csv("../data/data_filtered.csv")

filter_data <- function(state){
  state_data <- allData %>% 
    select(ProviderName, DBAName, HoldingCompanyName, HocoFinal, StateAbbr, MaxAdDown, MaxAdUp, MaxCIRDown, MaxCIRUp) %>% 
    filter(StateAbbr == "WA") %>% 
    group_by(ProviderName) %>% 
    summarize(AvgMaxAdDown=mean(MaxAdDown), AvgMaxAdUp=mean(MaxAdUp), 
              AvgMaxCIRDown=mean(MaxCIRDown), AvgMaxCIRUp=mean(MaxCIRUp)) %>% 
    filter(AvgMaxCIRDown != 0 || AvgMaxAdDown != 0 || AvgMaxCIRUp != 0 || AvgMaxAdUp != 0)
    arrange(desc(AvgMaxAdDown))
  
}
