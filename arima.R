library(forecast)
library(ggplot2)

# Best model: ARIMA(1,1,1)(1,1,2)[12]
# AIC=180.78   AICc=180.97   BIC=205.5
model <- auto.arima(co2, trace = T)
model
autoplot(model)

# how to improve it?
# Best model: ARIMA(0,1,3)(0,1,1)[12] 
# AIC=176.86   AICc=177   BIC=197.47
model2 <- auto.arima(co2, trace = T, stepwise = F, approximation = F)
model2
autoplot(model2)

prevm <- forecast(model, h=12)
autoplot(prevm)

prevm2 <- forecast(model2, h=12)
autoplot(prevm2)

plot(prevm)
lines(prevm2$mean, col='red')

prevm$mean
prevm2$mean