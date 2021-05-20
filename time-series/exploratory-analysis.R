help("sunspots")
min(sunspots)
max(sunspots)
median(sunspots)
mean(sunspots)
summary(sunspots)


start(sunspots)
end(sunspots)

frequency(sunspots)

sun2 <- window(sunspots, start=c(1749,1), end = c(1763,12))
sun2

plot(sunspots)
hist(sunspots)
boxplot(sunspots)

library(ggplot2)
library(forecast)

autoplot(AirPassengers)

plot(aggregate(AirPassengers, FUN=mean))