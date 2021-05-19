library(forecast)
library(ggplot2)

# using holt linear trend
autoplot(austres)
mdl1 <- holt(austres, h=16)
mdl1
autoplot(mdl1)

mdl1$model

mdl2 <- holt(austres, h=16, alpha = 0.2)
autoplot(mdl2)

plot(mdl1)
lines(mdl2$mean, col="red")

mdl3 <- holt(austres, damped = T, phi = 0.9, h=16)
autoplot(mdl3)

mdl4 <- holt(austres, damped = T, phi = 0.8, h = 16)
autoplot(mdl4)

plot(mdl3)
lines(mdl4$mean, col ='red')

# using holt winter with seasonal data
mdl5 <- hw(JohnsonJohnson, seasonal = "additive", h=16)
autoplot(mdl5)

mdl6 <- hw(JohnsonJohnson, seasonal = "multiplicative", h=16)
autoplot(mdl6)

plot(mdl5)
lines(mdl6$mean, col='red')

mdl7 <- hw(JohnsonJohnson, seasonal = "multiplicative", damped = T, phi =  0.9, h = 16)
autoplot(mdl7)

# using ETS
mdl8 <- ets(JohnsonJohnson)
mdl8

prev <- forecast(mdl8, h=16, levels=c(85,90))
prev
autoplot(prev)


mdl9 <- ets(JohnsonJohnson, model = "ZAA", damped = T)
autoplot(mdl9)
mdl9

mdl10 <- ets(JohnsonJohnson, model = "ZZZ", damped = T)
autoplot(mdl10)
mdl10