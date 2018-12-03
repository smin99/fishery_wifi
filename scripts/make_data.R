# Follow this document to replicate the process of generating the datause for use in this project.
library(data.table)
library(dplyr)

# From the FCC dataset website, export the data as a CSV file and read it in.
# http://transition.fcc.gov/form477/BroadbandData/Fixed/Jun17/Version%201/US-Fixed-without-Satellite-Jun2017.zip
# Since we are performing statistical analysis, you may elect to read a random sample instead.
# Read the man pages for shuf(1) on how to do that.
full_data <- fread("fcc_small.csv",
                   stringsAsFactors = FALSE) %>%
  filter(StateAbbr != "PR" & # Puerto Rico
         StateAbbr != "AK" & # Alaska
         StateAbbr != "HI" & # Hawaii
         StateAbbr != "GU" & # Guam
         StateAbbr != "AS" & # Samoa 
         StateAbbr != "MP" & # Northern Mariana Islands
         StateAbbr != "VI") %>% # Virgin Islands
  mutate(StateName = tolower(setNames(state.name, state.abb)[StateAbbr]))

# For the UI, we also find all the states.
conus_states <- unique(full_data$StateAbbr)

# Write data.
write.csv(full_data, "../data/data_filtered.csv", row.names = FALSE)
write.csv(conus_states, "../data/states_filtered.csv", row.names = FALSE)

