library(dplyr)

generate_percentile_text <- function(state, data) {
  speeds <- filter(
    data, StateAbbr == state)$MaxAdDown
  result <- quantile(speeds,
                     probs = c(0, 0.25, 0.5, 0.75, 1))
  #These lines are used to paste the text underneath the heat map,
  #giving more descriptive detail
  paste0("In ", state,
         ", the median offered download speed is ",
         result[3], "Mbps, with a standard deviation of ",
         round(sd(speeds), 2),
         "Mbps, a huge inequality that remains problematic nationally. ",
         "This means that lowest 25% speeds offered only go up to ",
         result[2], "Mbps",
         ", while an ISP offering a competitive 75% speed can offer ",
         result[4], "Mbps.")
}