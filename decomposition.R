library(forecast)
library(ggplot2)

autoplot(AirPassengers)

prev <- stlf(AirPassengers, h=48)
prev
autoplot(prev)