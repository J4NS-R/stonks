# Stonks

Does some number crunching to predict stocks. 

## Design

Every week:
- Stock data downloaded and cleaned - 3 months
- R calculates 1w forecast and plots it
- R calcs previous model and gets accuracy, given latest observations.
- Accuracy is stored.

When site viewed:
- Display plot/s
- Display avg accuracy

## Dependencies

- R
  - ggplot2
  - forecast
  - fpp2

## Attribution

<a href="https://iexcloud.io">Data provided by IEX Cloud</a>
