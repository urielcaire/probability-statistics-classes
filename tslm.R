library(forecast)
library(ggplot2)

# time series linear model
plot(Seatbelts)

model1 <- tslm(DriversKilled ~ trend, data = Seatbelts)
model1

model2 <- tslm(DriversKilled ~ season, data = Seatbelts)
model2

model3 <- tslm(DriversKilled ~ trend + season, data = Seatbelts)
model3

CV(model1)
CV(model2)
CV(model3)


prevm1 <- forecast(model1, h=12)
prevm2 <- forecast(model2, h=12)
prevm3 <- forecast(model3, h=12)

autoplot(prevm1)
autoplot(prevm2)
autoplot(prevm3)

plot(prevm1)
lines(prevm2$mean, col='red')
lines(prevm3$mean, col='green')
legend("topright", legend=c("Tend", "Seas", "Tend+Seas"), col=c('blue',
                                                                'red',
                                                                'green'),
       lty=1:2, cex=0.8)



