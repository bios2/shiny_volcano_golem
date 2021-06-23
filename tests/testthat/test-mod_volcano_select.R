test_that("volcano selection module works", {
  
  testthat::skip_if_not(interactive())
  
  
  ui <- fluidPage(
  ## To be copied in the UI
  mod_volcano_select_ui("volcano_select_1"),
  tableOutput("table")
  )
  
  server <- function(input, output) {
    ## To be copied in the server
    volcano_data <- readRDS("data/volcanoes.rds")
    selected_data <- mod_volcano_select_server("volcano_select_1",
                                               volcano = volcano_data)
    
    output$table <- renderTable(selected_data())
  }
  
  shinyApp(ui = ui, server = server)
  
})
