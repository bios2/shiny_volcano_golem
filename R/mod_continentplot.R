#' continentplot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_continentplot_ui <- function(id){
  ns <- NS(id)
  tagList(
    plotOutput(ns("barplot"), # this calls to object continentplot that is made in the server page
               height = 350)
  )
}
    
#' continentplot Server Functions
#'
#' @noRd 
mod_continentplot_server <- function(id, volcano, selected_volcanoes){
  
  # kind of helpful
  stopifnot(is.reactive(selected_volcanoes))
  
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
    output$barplot <- renderPlot({
      
      # create basic barplot
      barplot <- ggplot2::ggplot(data = volcano,
                                 ggplot2::aes(x=continent,
                            fill = volcano_type_consolidated))+
        # update theme and axis labels:
        ggplot2::theme_bw()+
        ggplot2::theme(plot.background  = ggplot2::element_rect(color="transparent",fill = "transparent"),
                       panel.background = ggplot2::element_rect(color="transparent",fill="transparent"),
                       panel.border     = ggplot2::element_rect(color="transparent",fill="transparent"))+
        ggplot2::labs(x=NULL, y=NULL, title = NULL) +
        ggplot2::theme(axis.text.x = ggplot2::element_text(angle=45,hjust=1))
      
      
      # IF a selected_volcanoes() object exists, update the blank ggplot. 
      # basically this makes it not mess up when nothing is selected
      
      barplot <- barplot +
        ggplot2::geom_bar(data = selected_volcanoes(), show.legend = F) +
        ggplot2::scale_fill_manual(values = RColorBrewer::brewer.pal(9,"Set1"), drop=F) +
        ggplot2::scale_x_discrete(drop=F)
      
      
      # print the plot
      barplot
      
    }) # end renderplot command
    
    
  })
}
    
## To be copied in the UI
# mod_continentplot_ui("continentplot_1")
    
## To be copied in the server
# mod_continentplot_server("continentplot_1")
