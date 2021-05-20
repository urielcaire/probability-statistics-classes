library(forecast)
library(ggplot2)

autoplot(presidents)

prev <- auto.arima(presidents)
prev$residuals
autoplot(prev$residuals)
hist(prev$residuals)
var(prev$residuals, na.rm = T)
mean(as.vector(prev$residuals), na.rm= T)

acf(prev$residuals, na.action = na.pass)

# compacted function
checkresiduals(prev)

# check normal distribution
shapiro.test(prev$residuals)
