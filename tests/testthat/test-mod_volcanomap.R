test_that("volcano map works", {
  
  testthat::skip_if_not(interactive())
  
  
  ui <- fluidPage(
    ## To be copied in the UI,
    verbatimTextOutput("clicked"),
    mod_volcanomap_ui("volcanomap_1")
  )
  
  server <- function(input, output) {
    ## To be copied in the server
    volcano_data <- readRDS("data/volcanoes.rds")
    volcano_recent <- subset(volcano_data, last_eruption_year > 2000)
    
    chosen_volcano <- mod_volcanomap_server("volcanomap_1",
                      selected_volcanoes = reactive(volcano_recent))
    
    output$clicked <- renderPrint(chosen_volcano())
    
  }
  
  shinyApp(ui = ui, server = server)
  
})