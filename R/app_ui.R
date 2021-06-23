#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    shinydashboard::dashboardPage(
      header = shinydashboard::dashboardHeader(
        title = "Exploring Volcanoes of the World",
        titleWidth = 350 # since we have a long title, we need to extend width element in pixels
      ),
      sidebar = shinydashboard::dashboardSidebar(disable = TRUE), # here, we only have one tab, so we don't need a sidebar
      body = shinydashboard::dashboardBody(
        # make first row of elements (actually, this will be the only row)
        fluidRow(
          # make first column, 25% of page - width = 3 of 12 colums
          column(width = 3,
                 # box 1 : input for selecting volcano type
                 #-----------------------------------------------
                 shinydashboard::box(width = NULL, status = "primary",
                     title  = "Selection Criteria", solidHeader = T
                     
                 ), # end box 1
                 # box 2: ggplot of selected volcanoes by continent
                 #------------------------------------------------
                 shinydashboard::box(width = NULL, status = "primary",
                     solidHeader = TRUE, collapsible = T,
                     title = "Volcanoes by Continent"

                 ) # end box 2
          ), # end column 1
          
          # second column - 75% of page (9 of 12 columns)
          column(width = 9,
                 
                 # Box 3: leaflet map
                 shinydashboard::box(width = NULL, background = "light-blue"
                                     
                 ) # end box with map
          ) # end second column
        ) # end fluidrow
      ) # end body
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'shiny_volcano_golem'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

