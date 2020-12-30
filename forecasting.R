library(forecast)
library(MLmetrics)
library(astsa)
data=AirPassengers
#membuat contoh
#data diambil dari library penumpang pesawat terbang yang disediakan oleh R
training=window(data, start = c(1949,1), end = c(1955,12))
validation=window(data, start = c(1956,1))

#metode naive
#proses training
naive = snaive(training, h=length(validation))
#mencari MAPE dari metode naive
MAPE(naive$mean, validation) * 100
#menampilkan plot data
plot(data, col="blue", xlab="Year", ylab="Passengers", main="Seasonal Naive Forecast", type='l')
#menampilkan hasil prediksi dan perbedaan dengan data yang asli
lines(naive$mean, col="red", lwd=2)

#Exponential Smoothing
ets_model = ets(training, allow.multiplicative.trend = TRUE)
summary(ets_model)
ets_forecast = forecast(ets_model, h=length(validation))
MAPE(ets_forecast$mean, validation) *100

#Double Seasonal Holt-Winters
dshw_model = dshw(training, period1=4, period2 = 12, h=length(validation))
MAPE(dshw_model$mean, validation)*100
plot(data, col="blue", xlab="Year", ylab="Passengers", main="Double Seasonal Holt-Winters", type='l')
lines(dshw_model$mean, col="red", lwd=2)

#BATS and TBATS
tbats_model = tbats(training)
tbats_forecast = forecast(tbats_model, h=length(validation))
MAPE(tbats_forecast$mean, validation) * 100
plot(data, col="blue", xlab="Year", ylab="Passengers", main="BATS and TBATS", type='l')
lines(tbats_forecast$mean, col="red", lwd=2)

#model ARIMA/SARIMA
arima_optimal = auto.arima(training)
sarima_forecast = sarima.for(training, n.ahead=length(validation),
                             p=0,d=1,q=1,P=1,D=1,Q=0,S=12)
MAPE(sarima_forecast$pred, validation) * 100
plot(data, col="blue", xlab="Year", ylab="Passengers", main="SARIMA", type='l')
lines(sarima_forecast$pred, col="red", lwd=2)

#one-step-ahead SARIMA forecast
one_step_ahead_sarima = matrix(ncol = 2, nrow = 60)
for (i in 1:60){
  
  training_observed = window(data, start = c(1949,1), end = c(1955,(12+i)), frequency = 12)
  
  forecasted.sarima = sarima.for(training_observed,n.ahead=1,p=0,d=1,q=1,P=1,D=1,Q=0,S=12)
  
  demandforecast = forecasted.sarima$pred
  observed = validation[[i]]
  
  one_step_ahead_sarima[i,1]= observed
  one_step_ahead_sarima[i,2]= demandforecast
}
MAPE(one_step_ahead_sarima[,1], one_step_ahead_sarima[,2]) * 100
plot(data, col="blue", xlab="Year", ylab="Passengers", main="one steap ahead SARIMA Forecast", type='l')
lines(ts(one_step_ahead_sarima[,2], start = c(1956,1), frequency = 12), col="red", lwd=3)

