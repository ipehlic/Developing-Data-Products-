#The app will show diamond price based on input of the following input variables: 
#The input variables are as follows:
#carat: weight or size of the diamond that can be from .32 carat to 4.0 carat
#cut: quality of the diamond (Ideal, Premium, Very Good, Good, Fair)
#clarity: measures how clear the diamond (IF, VVS2, VVS1, VS2, VS1, SI2, SI1, I1)

library(shiny)
library(dplyr)
library(ggplot2)

# Define UI for application that draws a plot
shinyUI(fluidPage(

    # Application title
    titlePanel("Price of Diamonds by Carat"),

    # Sidebar with a slider, checkbox, and dropdown input
    sidebarLayout(
        sidebarPanel(
            sliderInput("carat", "Select Carat Range:",
              min = 0, max = 5, value = c(0, 5), step = 0.01),
            radioButtons("cut", "Select Cut Type:",
                        choices = c("Fair", "Good", "Very Good", "Premium", "Ideal"),
                        selected = "Ideal"),
            selectInput("clarity", "Select Clarity:", 
                        choices = list("I1" = "I1", "SI2" = "SI2",
                                       "SI1" = "SI1", "VS2" = "VS2", "VS1" = "VS1",
                                       "VVS2" = "VVS2", "VVS1" = "VVS1", "IF" = "IF" ))
            
  
     ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput('plot'),
            tableOutput("results")
            
        )
    )
))
