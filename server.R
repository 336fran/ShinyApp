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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    mdr<-reactive({
        x<-seq(input$xmin,input$xmax,length=100)
        Normal<-dnorm(x,0,1)
        tStudent<-dt(x,input$dfinp)
        md<-data.frame(x=x, Normal=Normal, tStudent=tStudent)
    })
    
    mdpoints<-reactive({
        pin<-input$pinp
        ponits<-data.frame(x=c(qnorm(pin),qt(pin,input$dfinp)),
                           y=c(dnorm(qnorm(pin),0,1),dt(qt(pin,input$dfinp),input$dfinp)))
        
    })
    
    output$text1 <- renderText({
        pin<-input$pinp
        temp<-as.character(round(qnorm(pin),3))
        paste("Normal:", temp)
    })
    
    output$text2 <- renderText({
        pin<-input$pinp
        temp<-as.character(round(qt(pin,input$dfinp),3))
        paste("tStudent:", temp)
    })
    

    
    output$distPlot <- renderPlot({
        md<-mdr()
        points<-mdpoints()
        ggplot(md,aes(x=x)) +
            geom_line(aes(y = Normal, colour = "Normal"), size=1) +
            geom_line(aes(y = tStudent, colour = "tStudent"), size=1) +
            ylab("density") +
            scale_colour_manual(values=c("blue","red")) +
            geom_point(data=points, aes(x=x,y=y), size=2)
    })
    
})
