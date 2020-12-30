#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source('forecasting.R')
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$penumpang <-renderText(
        p(data)
    )
    
    output$naive <- renderPlot({
        plot(data, col="blue", xlab="Year", ylab="Passengers", main="Seasonal Naive Forecast", type='l')
        lines(naive$mean, col="red", lwd=2)
    })
    output$mape_naive <-renderText(({
        MAPE(naive$mean, validation) * 100
    }))
    output$dshw <- renderPlot({
        plot(data, col="blue", xlab="Year", ylab="Passengers", main="Double Seasonal Holt-Winters", type='l')
        lines(dshw_model$mean, col="red", lwd=2)
    })
    output$mape_dshw <-renderText(({
        MAPE(dshw_model$mean, validation)*100
    }))
    output$bats <- renderPlot({
        plot(data, col="blue", xlab="Year", ylab="Passengers", main="BATS and TBATS", type='l')
        lines(tbats_forecast$mean, col="red", lwd=2)
    })
    output$mape_bats <-renderText(({
        MAPE(tbats_forecast$mean, validation) * 100
    }))
    output$sarima <- renderPlot({
        plot(data, col="blue", xlab="Year", ylab="Passengers", main="SARIMA", type='l')
        lines(sarima_forecast$pred, col="red", lwd=2)
    })
    output$mape_sarima <-renderText(({
        MAPE(sarima_forecast$pred, validation) * 100
    }))
    output$osas <- renderPlot({
        plot(data, col="blue", xlab="Year", ylab="Passengers", main="one steap ahead SARIMA Forecast", type='l')
        lines(ts(one_step_ahead_sarima[,2], start = c(1956,1), frequency = 12), col="red", lwd=3)
    })
    output$mape_osas <-renderText(({
        MAPE(one_step_ahead_sarima[,1], one_step_ahead_sarima[,2]) * 100
    }))

})
