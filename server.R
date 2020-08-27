#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)

# select columns to be used in the analysis
shinyServer(function(input, output) {
    output$plot <- renderPlot({
        # Select diamonds in carat range
        df <- diamonds %>%
            dplyr::select("carat", "price", "cut", "clarity") %>%
            dplyr::filter(carat >= !!input$carat[[1]], carat <= !!input$carat[[2]]) %>%
            dplyr::filter(cut == input$cut) %>%
            dplyr::filter(clarity==input$clarity)
       
         # Scatter plot with smoothed means
            ggplot(df, aes(carat, price))+
            geom_point(aes(colour = cut), alpha = 1/2) +
            geom_smooth() +
            scale_size_area(max_size = 2) +
            ggtitle("Price vs. Carat")
            
        
    })
 #output table with results    
    filtered <- reactive({
        if (is.null(input$carat)) {
            return(NULL)
        }   
        
        df <- diamonds %>%
            dplyr::select("carat", "price", "cut", "clarity") %>%
            dplyr::filter(carat >= !!input$carat[[1]], carat <= !!input$carat[[2]]) %>%
            dplyr::filter(cut == input$cut) %>%
            dplyr::filter(clarity==input$clarity)
    })
    
    output$results <- renderTable({
        filtered()
        
    })
    
})


