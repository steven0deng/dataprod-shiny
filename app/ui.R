library(shiny)

startDate <- as.Date('2017-01-01')
endDate <- Sys.Date()

shinyUI(fluidPage(
  titlePanel("Really simple stock price viewer"),
  div("This is a simple stock price viewer.
      You can use it to view the prices of multiple stock symbols.
      All you need to do is to enter the symbols in the text box.
      If you are viewing more than one symbols,
      please separate them by commas.
      Please avoid putting <SPACE> in the text box.
      You can select the start date and end date using the slider provided.
      "),
  br(),
  p("Remember to click GO to refresh your chart.", style="color:blue"),
  sidebarLayout(
    sidebarPanel(
      textInput("symbols", "Enter the stock symbols (comma delimited)", 'AMZN,GOOGL'),
      sliderInput("daterange", "Date range", min = startDate, max = endDate,
                  value = c(startDate, endDate), step = 1,
                  timeFormat = '%Y-%m-%d'),
      submitButton("Go")
    ),
    mainPanel(
      plotlyOutput("plot")
    )
  ),
  br(),
  br(),
  tags$footer(
    p("Source Code:"),
    a("https://github.com/steven0deng/dataprod-shiny/tree/master/app", href="https://github.com/steven0deng/dataprod-shiny/tree/master/app"),
    p("Pitch Slides:"),
    a("https://steven0deng.github.io/dataprod-shiny", href="https://steven0deng.github.io/dataprod-shiny"))
))