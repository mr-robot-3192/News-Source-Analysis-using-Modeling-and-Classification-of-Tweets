


library(shiny)

# Define UI for application.
ui <- fluidPage(
  tags$head(tags$style(
    HTML(
      "
      @import url('https://fonts.googleapis.com/css?family=Roboto+Slab');
      
      h1 {
      font-family: 'Roboto Slab', cursive;
      font-weight: 1000;
      line-height: 1.0;
      color: #0084b4;
      text-align: center;
      }
      
      "
    )
    )),
  tags$body(tags$style(
    HTML(
      "
      body {
      background-image: url(/download.jpg);
      background-repeat: no-repeat;
      background-attachment: fixed;
      background-size: 375px 249px;
      background-position: center;
      }
      "
    )
    )),
  
  # Application title
  headerPanel("News Source Analysis"),
  headerPanel("Using Modeling and Classification of Tweets"),
  
  # Sidebar with Inputs.
  sidebarLayout(
    # Sidebar Panel for inputs.
    sidebarPanel(
      # Input: Selector for choosing dataset.
      selectInput(
        inputId = "dataset",
        label = "Choose The Dataset:",
        choices = c(
          "Initial",
          "Raw Data for Tweet Credibility",
          "Raw Data for Tweeter Credibility",
          "Processed for Tweet Credibility",
          "Processed for Tweeter Credibility",
          "Tweet Credibility",
          "Tweeter Credibility",
          "Final Credibility"
        )
      ),
      
      # Input: Number of obs.
      numericInput(
        inputId = "obs",
        label = "Number of Observations:",
        value = 20
      ),
      
      helpText("Note: Credibility Levels are "),
      helpText("VHC : Very High Credibility"),
      helpText("HC  : High Credibility"),
      helpText("NC  : Neutral Credibility"),
      helpText("LC  : Low Credibility"),
      helpText("VLC : Very Low Credibility")
    
  ),
  
  # Main panel for displaying outputs.
  mainPanel(verbatimTextOutput("summary"),
            # Output: HTML table with requested number of observations.
            tableOutput("view"))
    )
  )

# Define Server Logic
server <- function(input, output) {
  # Return the requested dataset.
  datasetInput <- reactive({
    switch(
      input$dataset,
      "Initial" = tweet_df,
      "Raw Data for Tweet Credibility" = modelA,
      "Raw Data for Tweeter Credibility" = modelB,
      "Processed for Tweet Credibility" = modelA_P,
      "Processed for Tweeter Credibility" = modelB_P,
      "Tweet Credibility" = modelAT,
      "Tweeter Credibility" = modelBT,
      "Final Credibility" = modelF
    )
  })
  
  # Show the first "n" observations.
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
}

# Run the application
shinyApp(ui = ui, server = server)
