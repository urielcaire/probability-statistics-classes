test_result <- Box.test(airmiles, type="Ljung-Box")
test_result # p-value = 5.035e-06: it is not stationary, so...

# apply diff on airmiles
diff_series <- diff(airmiles)
diff_series

test_result <- Box.test(diff_series, type="Ljung-Box")
test_result # p-value = 0.1407: it is now stationary :)

# compare it
split.screen(figs = c(2,1))
screen(1)
plot(airmiles, main= "Airmiles")
screen(2)
plot(diff_series, main="Diff Airmiles")

# how many diffs it needs
ndiffs(airmiles, test="pp")
ndiffs(diff_series, test="pp")

