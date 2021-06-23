test_that("volano barplot works", {
  
  testthat::skip_if_not(interactive())
  
  
  ui <- fluidPage(
    ## To be copied in the UI
    mod_continentplot_ui("continentplot_1"),
    tableOutput("table")
  )
  
  server <- function(input, output) {
    ## To be copied in the server
    volcano_data <- readRDS("data/volcanoes.rds")
    volcano_recent <- subset(volcano_data, last_eruption_year > 2000)
    mod_continentplot_server("continentplot_1",
                                              volcano = volcano_data,
                                              selected_volcanoes = reactive(volcano_recent))
  }
  
  shinyApp(ui = ui, server = server)
})
