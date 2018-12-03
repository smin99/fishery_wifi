# load libraries
library(dplyr)
library(kableExtra)

filter_data <- function(state, allData){
  state_data <- allData %>% 
    select(ProviderName, DBAName, HoldingCompanyName, HocoFinal, StateAbbr, MaxAdDown, MaxAdUp) %>% 
    filter(StateAbbr == state) %>% 
    group_by(ProviderName) %>% 
    summarize(AvgMaxAdDown=mean(MaxAdDown), AvgMaxAdUp=mean(MaxAdUp)) %>% 
    filter(AvgMaxAdDown != 0) %>% 
    arrange(desc(AvgMaxAdDown)) %>% 
    knitr::kable(format="html", digits=2, caption=paste0("Table 1: Speed of each Provider in ", state)) %>% 
    kable_styling()
}
