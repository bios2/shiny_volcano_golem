#' volcanomap UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_volcanomap_ui <- function(id){
  ns <- NS(id)
  tagList(
    leaflet::leafletOutput(ns("map"), height = 760)
  )
}
    
#' volcanomap Server Functions
#'
#' @noRd 
mod_volcanomap_server <- function(id, selected_volcanoes){
  
  stopifnot(is.reactive(selected_volcanoes))
  
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
    output$map <- leaflet::renderLeaflet({
      
      # add blank leaflet map 
      leaflet::leaflet(options = leaflet::leafletOptions(minZoom = 0, maxZoom = 10, zoomControl = TRUE)) %>%
        # add map tiles from CartoDB. 
        leaflet::addProviderTiles("CartoDB.VoyagerNoLabels") %>%
        # set lat long and zoom to start
        leaflet::setView(lng = 15, lat = -10, zoom = 1.5)
      
    })
    
    observe({
      
      # make a colorpalette function for the 9 volcano types
      pal <- leaflet::colorFactor(RColorBrewer::brewer.pal(9,"Set1"), 
                         domain = NULL)
      
      # when something is changed, clear existing points, and add new ones
      leaflet::leafletProxy("map") %>%
        leaflet::clearMarkers() %>%       # clear points
        leaflet::addCircleMarkers(        # add new points from "selected_volcanoes()" reactive object
          data = selected_volcanoes(),
          layerId = ~volcano_name,
          lng = ~longitude,
          lat = ~latitude,
          radius = ~6,
          color = ~pal(volcano_type_consolidated),
          stroke = FALSE, fillOpacity = 0.9,
          # create a popup with the volcano name and some info
          # --- --- --- --- ---  CHALLENGE  --- --- --- --- --- ---
          # if you want, see if you can add "country" or "last eruption year" to the popup box
          popup = ~paste("<b>",volcano_name,"</b>",
                         "<br>",
                         "<b> Type: </b>",volcano_type_consolidated, "<br>",
                         "<b> Continent: </b>",continent, "<br>",
                         "<b> Elevation: </b>", elevation, "ft.") 
        ) # end add circle markers
      
    })
    
    clicked_volcano <- reactive(input$map_marker_click$id)
    
    return(clicked_volcano)
    
  })
}
    
## To be copied in the UI
# mod_volcanomap_ui("volcanomap_1")
    
## To be copied in the server
# mod_volcanomap_server("volcanomap_1")
