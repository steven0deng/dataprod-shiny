library(dplyr)

getPrices <- function(sym, startDate, endDate)
{
  s <- sapply(strsplit(format(startDate, '%Y+%m+%d'), '-'), as.integer)
  e <- sapply(strsplit(format(endDate, '%Y+%m+%d'), '-'), as.integer)
  
  url <- paste0("http://www.google.com/finance/historical",
                "?q=", sym,
                "&startdate=", s,
                "&enddate=", e,
                "&output=csv")
  
  renameColumns <- function(cn){
    if (grepl('Date', cn)){
      return('Date')
    }
    if(cn == 'Close'){
      return('Price')
    }
    cn
  }
  tryCatch({
    df <- read.csv(url)
  },
  error=function(e){
    stop(paste("Failed downloading data for", sym, ". Is it a valid symbol?"))
  }
  )
  
  df$Stock <- rep(sym, nrow(df))
  names(df) <- sapply(names(df), renameColumns)
  df$Date <- as.Date(df$Date, '%d-%b-%y')
  df[,c('Date', 'Price', 'Stock')]
}

getMultiQuotes <- function(symbols, startDate, endDate){
  stocks <- lapply(symbols, getPrices, startDate, endDate) %>% Reduce(function(dtf1,dtf2) merge(dtf1,dtf2, all=TRUE), .)
  stocks <- stocks[with(stocks, order(Date)), ]
  stocks <- stocks[(stocks$Date >= startDate) & (stocks$Date <= endDate), ]
  stocks
}
