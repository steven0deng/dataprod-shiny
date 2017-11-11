---
title       : "Shiny Stock Viewer"
date        : Nov 11, 2017
subtitle    : 
author      : 
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---



# Introduction

The objective of this project is to provide a simple way for users to view historical stock prices of selected symbols within certain period.

Basically, two pieces of input information are required:

1. Stock Symbols

>>
   Multiple symbols are allowed so that we can compare different stocks.

2. The Period

>>
   Start and end dates are required.

And the output is a chart showing the stock prices of the given symbols within the given period.

---
# The Data

The functions for getting stock price data are defined in script file `utils.R`.

- `getPrices`

>>
   This function downloads data for one symbol from http://www.google.com/finance/historical

- `getMultiQuotes`

>>
   This function calls `getPrices` for each symbol in input symbol list and then concatenate the results.

--- &twocol w1:40% w2:60%
# The Caculation

The following script is used to do calculation and prepare the chart.


```r
stocks <- getMultiQuotes(symbols, startDate=startDate, endDate=endDate)
plot_ly(stocks, x = ~Date, y = ~Price, color = ~Stock, mode = "lines") %>%
  layout(title=paste("Stock Prices", format(min(stocks$Date), '%b %d, %Y'), "to",
                     format(max(stocks$Date), '%b %d, %Y')))
```

*** {name: left}
For the following inputs:

Symbols: `AMZN,GOOGL`

Period: `2017-04-01` to `2017-07-31`

*** {name: right}
We have:


<iframe src="demo.html" style="position:absolute;height:50%;width:50%"></iframe>


---
# The App


The chart has a side bar layout. The sidebar panel contains the controls for setting the symbols and the period. The main panel contains the result which is a plotly interactive chart showing the stock prices.

The app can accessed via:

http://steven0deng.shinyapps.io/a_simple_stock_view


