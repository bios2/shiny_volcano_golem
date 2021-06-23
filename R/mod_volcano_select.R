#' volcano_select UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_volcano_select_ui <- function(id){
  ns <- NS(id)
  tagList(
    # Widget specifying the species to be included on the plot
    shinyWidgets::checkboxGroupButtons(
      inputId = ns("volcano_type"),
      label = "Volcano Type",
      choices = c("Stratovolcano" , "Shield" ,"Cone" ,   "Caldera" ,    "Volcanic Field",
                  "Complex" , "Other",   "Lava Dome"  , "Submarine"    ),
      checkIcon = list(
        yes = tags$i(class = "fa fa-check-square", 
                     style = "color: steelblue"),
        no = tags$i(class = "fa fa-square-o", 
                    style = "color: steelblue"))
    ) # end checkboxGroupButtons
  )
}
    
#' volcano_select Server Functions
#'
#' @noRd 
mod_volcano_select_server <- function(id, volcano){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # make reactive dataset
    # ------------------------------------------------
    # Make a subset of the data as a reactive value
    # this subset pulls volcano rows only in the selected types of volcano
    selected_volcanoes <- reactive({
      
      req(input$volcano_type)
      
      volcano %>%
        
        # select only volcanoes in the selected volcano type (by checkboxes in the UI)
        dplyr::filter(volcano_type_consolidated %in% input$volcano_type) %>%
        # Space to add your suggested filter here!! 
        # --- --- --- --- --- --- --- --- --- --- --- --- ---
        # filter() %>%
        # --- --- --- --- --- --- --- --- --- --- --- --- ---
        # change volcano type into factor (this makes plotting it more consistent)
        dplyr::mutate(volcano_type_consolidated = factor(volcano_type_consolidated,
                                                  levels = c("Stratovolcano" , "Shield",  "Cone",   "Caldera", "Volcanic Field",
                                                             "Complex" ,  "Other" ,  "Lava Dome" , "Submarine" ) ) )
    })
    
  })
}
    
## To be copied in the UI
# mod_volcano_select_ui("volcano_select_1")
    
## To be copied in the server
# mod_volcano_select_server("volcano_select_1")
