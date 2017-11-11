library(plotly)
library(shiny)

source('utils.R')

shinyServer(function(input, output) {
  output$fromDate <- renderText(format(input$daterange[1], '%Y-%m-%d'))
  output$toDate <- renderText(format(input$daterange[2], '%Y-%m-%d'))
  output$plot <- renderPlotly({
    symbols <- strsplit(input$symbols, ',')[[1]]
    startDate <- input$daterange[1]
    endDate <- input$daterange[2]
    stocks <- getMultiQuotes(symbols, startDate=startDate, endDate=endDate)
    plot_ly(stocks, x = ~Date, y = ~Price, color = ~Stock, mode = "lines") %>%
      layout(title=paste("Stock Prices", format(min(stocks$Date), '%b %d, %Y'), "to", format(max(stocks$Date), '%b %d, %Y')))
  })
})