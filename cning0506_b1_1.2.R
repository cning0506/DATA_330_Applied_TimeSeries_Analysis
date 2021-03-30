# ATSA Exercise 1.2

library("tswge")

# Question 1 - "base plot" in R and the "plotts.wge"

# Load the dataset
data("ss08")

plot.ts(ss08)
plotts.wge(ss08)

# Question 2 - Calculate the average of TS realization 
mean(ss08)

# Output
# [1] 52.24385

# Question 3 - Dataset "Hadley" and plot the auto-correlation and auto-covariance 
data("hadley")
acf(hadley, type = "correlation")
acf(hadley, type = "covariance")

# Question 4 - Equations 
m <- length(hadley)
cat(m)


# Question 5 - Plot the time series and the periodogram for Fig 1.10a 
data("fig1.10a")
plot.ts(fig1.10a)
spectrum(fig1.10a)
plot(1:1000/10, fig1.10a, type = "l", xlab = "Time")
