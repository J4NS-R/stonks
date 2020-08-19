# Stonks

A bunch of scripts that process stock market data and makes forecasts 
using popular statistical time series forecasting methods. 

Proof that I passed university-level statistics (:

## Design

Every week:
- Stock data downloaded and cleaned - 3 months
- R calculates 1w forecast for each ticker and plots it
- R calcs previous model and gets accuracy, given latest observations.
- This accuracy data is then stored.
- Historical prediction accuracy is loaded from db and plotted.
- All graphs are published to [the website](https://stonks.singularity.net.za).

## Dependencies

- R
  - ggplot2
  - forecast
  - fpp2
- python3
  - mysql-connector-python

## Attribution

[Stock market data provided by IEX Cloud](https://iexcloud.io)
