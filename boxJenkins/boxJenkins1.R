# Andrew Man

# Load and Prepare Data
# Read CPI data from a CSV file into 'data.cpi' with headers and comma separator
data.cpi <- read.table("cpi_newZealand_quarterly.csv", header = TRUE, sep = ",")

# Create a time series object 'cpi' starting from 1960 with quarterly frequency
cpi <- ts(data.cpi[, 2], start = 1960, frequency = 4)

# Exclude the COVID-19 period (up to 2020Q1)
cpi <- window(cpi, start = c(1960, 1), end = c(2020, 1))

# Calculate Annualized Quarterly Growth Rate

# Compute year-over-year growth rate 'dlogCpi'
dlogCpi <- 100 * diff(log(cpi), lag = 4)

# Convert 'dlogCpi' back to a time series object 'cpiRate'
cpiRate <- ts(dlogCpi, start = 1960, frequency = 4)

# Model Identification

# Plot 'cpiRate' and analyze autocorrelation and partial autocorrelation
plot(cpiRate, main = "Quarterly Inflation", xlab = "Time", type = "l")
acf(cpiRate, main = "Autocorrelation Inflation", lag.max = 50)
pacf(cpiRate, main = "Partial Autocorrelation Inflation", lag.max = 50)

# Model Estimation and Comparison

# Load necessary libraries
library(dyn)
library(forecast)
library(sandwich)
library(lmtest)

# Define and estimate ARMA models of different orders
models <- list(
  arima(cpiRate, order = c(13, 0, 0)),
  arima(cpiRate, order = c(13, 0, 1)),
  arima(cpiRate, order = c(13, 0, 2)),
  arima(cpiRate, order = c(13, 0, 3)),
  arima(cpiRate, order = c(10, 0, 0)),
  arima(cpiRate, order = c(10, 0, 1)),
  arima(cpiRate, order = c(5, 0, 0)),
  arima(cpiRate, order = c(5, 0, 1)),
  arima(cpiRate, order = c(5, 0, 2)),
  arima(cpiRate, order = c(5, 0, 3)),
  arima(cpiRate, order = c(5, 0, 4)),
  arima(cpiRate, order = c(5, 0, 5)),
  arima(cpiRate, order = c(2, 0, 0)),
  arima(cpiRate, order = c(2, 0, 1))
)

# Perform diagnostic checks 
#(coefficient tests for parameters using NeweyWest std. Errors)
#coeftest(AR5MA4.y, vcv = NeweyWest)

# Test model fit using AIC and BIC

# Diagnostic Checking
# Plot fitted values and residuals of the selected model (e.g., ARMA(5, 4))
selected_model <- models[[4]]  # For example, ARMA(13,0,3)
fitted_values <- fitted(selected_model)
residuals <- residuals(selected_model)

# Plot fitted values
plot(cpiRate, main = "Fitted Model Estimates", xlab = "Time", type = "l", col = "blue")
lines(fitted_values, col = "red")

# Create histograms with normal distribution curves for residuals

# Define a function to create the histogram with a normal curve
plot_histogram_with_normal_curve <- function(residuals, title) {
  h <- hist(residuals, breaks = 40, col = "red", xlab = "Inflation", main = title)
  xfit <- seq(min(residuals), max(residuals), length = 40)
  yfit <- dnorm(xfit, mean = mean(residuals), sd = sd(residuals))
  yfit <- yfit * diff(h$mids[1:2]) * length(residuals)
  lines(xfit, yfit, col = "blue", lwd = 2)
}

# Create histograms for residuals of different models
# lst argument is residuals of chosen model (i.e., ARMA(5,0,4))
# residuals = AR5MA4_residuals is already assigned by `residuals(selected_model)` 
title <- "Histogram with Normal Curve"
plot_histogram_with_normal_curve(residuals, title)