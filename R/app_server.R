#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  
  volcano_data <- readRDS("data/volcanoes.rds")
  
  # user chooses the volcano types
  selected_data <- mod_volcano_select_server("volcano_select_1",
                                             volcano = volcano_data)
  
  ## generate barplot
  mod_continentplot_server("continentplot_1",
                           volcano = volcano_data,
                           selected_volcanoes = selected_data)
  
  mod_volcanomap_server("volcanomap_1", selected_volcanoes = selected_data)
  
}
