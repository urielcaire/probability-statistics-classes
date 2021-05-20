library(forecast)
library(ggplot2)

autoplot(austres)

prev <- rwf(austres, h=12, drift = F)
prev
autoplot(prev)

prev <- rwf(austres, h=12, drift = T)
prev
autoplot(prev)