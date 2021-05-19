library(forecast)
library(ggplot2)

autoplot(fdeaths)
mean(fdeaths)

prev <- meanf(fdeaths, h = 5)
prev
autoplot(prev)

fdeaths2 <- window(fdeaths, start = c(1976, 1), end = c(1979,12))
autoplot(fdeaths2)

mean(fdeaths2)

newprev <- meanf(fdeaths2, h = 5)
newprev
autoplot(newprev)

plot(prev)
lines(newprev$mean, col='red')

newprev$mean