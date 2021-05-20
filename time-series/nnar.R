# Autoregressive Neural Network

library(forecast)
library(ggplot2)

model <- nnetar(co2)
model

prev <- forecast(model, h=24)
prev
autoplot(prev)

########################################
plot(Seatbelts)

autoplot(Seatbelts[,c("DriversKilled")])

train <- window(Seatbelts[,c("DriversKilled")], start=c(1980,1), end=c(1983,
                                                                      12))
train

model <- auto.arima(train)
model

prev1 <- forecast(model, h=12)
autoplot(prev1)


train_drivers <- as.vector(window(Seatbelts[,c("drivers")], start=c(1980,1), 
                        end=c(1983,12)))
train_drivers

model2 <- auto.arima(train, xreg = train_drivers)
model2

test_drivers <- as.vector(window(Seatbelts[,c("drivers")], start=c(1984,1), 
                                 end=c(1984,12)))
test_drivers

prev2 <- forecast(model2, xreg = test_drivers)
prev2
autoplot(prev2)

plot(prev1)
lines(prev2$mean, col='red')










