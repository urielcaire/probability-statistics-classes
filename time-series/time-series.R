# load data Fraser River monthly flows
fraser <- scan("time-series/fraser.txt")
# standard plot
plot(fraser)

# specify a frequency and convert the dataset to a time series using the ts
# function
fraser.ts <- ts(fraser, frequency=12, start=c(1913,3))
fraser.ts

# seasonal decomposition of the time series using the stl function
fraser.stl = stl(fraser.ts, s.window="periodic")
fraser.stl

summary(fraser.stl)

# organizes the time series into monthly patterns
monthplot(fraser.stl)

# using seasonal plot
library(forecast)
seasonplot(fraser.ts)

# plots various components of stl
plot(fraser.stl)

# smooth data using the SMA function of the TTR package
library(TTR)
fraser.SMA3 <- SMA(fraser,n=12)
plot(fraser.SMA3)

# stretched out 5 years
fraser.SMA60 <- SMA(fraser,n=60)
plot(fraser.SMA60)

# decompose the components of the time series
fraser.components <- decompose(fraser.ts)

# recalculate without seasonality
fraser.adjusted <- fraser - fraser.components$season
plot(fraser.adjusted)

# short-term forecast from our time series data using Holt-Winters filtering
fraser.forecast <- HoltWinters(fraser.ts,beta=FALSE)
fraser.forecast

# compute the SSE
fraser.forecast$SSE
plot(fraser.forecast)

fraser.forecast$fitted

# use Holt-Winters filtering for forecasting
library(forecast)
fraser.forecast2 <-  forecast:::forecast.HoltWinters(fraser.forecast, h=8)
fraser.forecast2
plot.forecast(fraser.forecast2)

# produce a correlogram using the acf function
# The acf function computes (and by default plots) the autocorrelation of your data.
acf(fraser.forecast2$residuals,lag.max=20,na.action = na.pass)

# use a Box test for the forecast
Box.test(fraser.forecast2$residuals,lag=20,type="Ljung-Box")
plot.ts(fraser.forecast2$residuals)

############################################################
