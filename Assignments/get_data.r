library(tidyverse)
library(tidyquant)

final_data <- c()

tickers <- c("SPY",
  "XLE",
  "XLRE",
  "XLF",
  "XLK",
  "XLC",
  "XLY",
  "XLI",
  "XLP",
  "XLB",
  "XLV",
  "XLU")


final_data <- tq_get(tickers)


daily_log_returns <- final_data %>%
  group_by(symbol) %>%
  tq_transmute(select     = adjusted, 
               mutate_fun = periodReturn, 
               period     = "daily", 
               type       = "log",
               col_rename = "log.returns")


n_data <- final_data %>% left_join(daily_log_returns, by=c("symbol", "date"))

write.csv(n_data, file="SP500_sector_data.csv")

