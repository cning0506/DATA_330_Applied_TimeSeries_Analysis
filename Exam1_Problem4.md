# Problem 4  
Find an example of a (weakly) stationary process and a non-stationary process (do not use the bat echolocation data from the notebook). Include screenshots (if possible) and references of these processes. In 150 words or less describe what it means for a process to be weakly stationary and why we care about it for our analysis of time series.

### Example of (Weakly) Stationary Process: Daily change in the Google stock price for 200 consecutive days
<img src="./Stationary_Example.PNG" />
Reference - Forecasting: Principles&nbsp;and&nbsp;Practice (2nd ed). 8.1 Stationarity and differencing. https://otexts.com/fpp2/stationarity.html. 

### Example of Non-stationary Process: 
<img src="./NonStationary_Example.PNG" />
Reference - Forecasting: Principles&nbsp;and&nbsp;Practice (2nd ed). 8.1 Stationarity and differencing. https://otexts.com/fpp2/stationarity.html. 


#### For a process to be weakly stationary, it needs to fulfill the following conditions, 
- E[X(t)]=μ  and is constant for all values of  t
- Var[X(t)]=σ2<∞ (i.e., is finite for all t)
- γ(t1,t2) depends only on t2−t1
- γ(h) is a semi-definite process (i.e., it's positive or zero for all scalar multiples)

In summary, the expected value should equals to the mean and it should be constant for every time unit. The variance should be constant as well. Moreover, a stationary time-series should have no predictable patterns in long term. Another property is to see if there is any trend or seasonality for the time series. If there is, then it is not stationary. It is crucial to care about the stationarity in our analysis of time series because it indicates how the time series does not change over time. Hence, we can conduct different statistical and analytical test on the time series. 

Reference - Forecasting: Principles&nbsp;and&nbsp;Practice (2nd ed). 8.1 Stationarity and differencing. https://otexts.com/fpp2/stationarity.html. 
