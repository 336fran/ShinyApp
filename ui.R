#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Normal vs tStudent density function"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("xmin","x min:",
                   min = -10,max = 5,value = -5),
       sliderInput("xmax","x max:",
                   min = 0,max = 20,value = 5),
       numericInput	("dfinp", "Degrees of freedom", value = 20, min=1),
       numericInput	("pinp", "Non-excedance probablity", value = 0.95, 
                     min=0, max=1, step=0.01)
       
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot"),
       h3("The quantiles for the given probability are:"),
       textOutput("text1"),
       textOutput("text2")
    )
  )
))
