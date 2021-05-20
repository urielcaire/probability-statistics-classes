library(forecast)
library(ggplot2)

t1 = BoxCox(AirPassengers, lambda = 0)
autoplot(t1)

t2 = BoxCox(AirPassengers, lambda = 0.1)
autoplot(t2)

# generate a lambda
lbd = BoxCox.lambda(AirPassengers)
lbd

t3 = BoxCox(AirPassengers, lambda = 0.1)
autoplot(t3)

t4 = diff(AirPassengers)
autoplot(t4)

t5 = log10(AirPassengers)
autoplot(t5)

# compare all
split.screen(figs = c(2,2))
screen(1)
plot(t1, main= "")
screen(2)
plot(t2, main="")
screen(3)
plot(t3, main="")
screen(4)
plot(t5, main="")
close.screen(all=T)
