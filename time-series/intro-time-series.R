#install.packages("forecast")
#install.packages("ggplot2")
#install.packages("urca")
#install.packages("lmtest")
#install.packages("seasonal")
#install.packages("seasonalview")

# creating a random time series; monthly
myts <- rnorm(60)
myts <- ts(myts, start = c(2012,1), end=c(2016,12), frequency = 12)
myts
class(myts)
plot(myts)

# importing time series data
#tempts = read.csv(file.choose(), sep = ",", header = F)
tempts = read.csv("time-series/support-material/Dados/importar.csv", sep = ",",
                  header = F)
tempts = ts(tempts[2], start = c(1884), end=c(1939), frequency = 1)
plot(tempts)