library(forecast)
library(ggplot2)

set.seed(4312)
data <- cumsum(sample(c(-1,1), 100, T))
data

serie <- ts(data, start = c(1900), end = c(2000), frequency = 1)
autoplot(serie)

prev <- naive(serie, h=5)
autoplot(prev)

newprev <- naive(serie, h=5, level = c(92, 99))
newprev
autoplot(newprev)

autoplot(AirPassengers)

sprev <- snaive(AirPassengers, h=12)
sprev
autoplot(sprev)

sprev$mean
window(AirPassengers, start=c(1960))