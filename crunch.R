# Crunsh some stock data
# Expectations:
# - tickers.txt: list of stock names, new-line-separated
# - for each ticker: data/[NAME]_data.csv - appropriate csv file, in IEX format
# Output:
# - for each ticker: graphs/[NAME].jpg - appropriate graph, with forecasts
# - data/accuracies.csv: table of accuracy data for the previous iteration of forecasts

library(ggplot2)
library(fpp2)
library(forecast)

tickers = read.csv('tickers.txt', header=F)[,1]

accuracies = c()

for (ticker_name in tickers){
  dat = read.csv(paste0('data/', ticker_name, '_data.csv'))
  ticker = ts(dat$close)

  # Do forecasting ===
  driftmod = rwf(ticker, h=7, drift=T)
  holtmod = holt(ticker, h=7)
  # hw needs seasonality
  arimamod = auto.arima(ticker, seasonal=F)

  plotdata = window(ticker, start=length(ticker)-30)
  start_date = max(as.Date(dat$date)) - 30

  jpeg(paste0('graphs/', ticker_name, '.jpg'), 846, 512)
  print(autoplot(plotdata) +
    autolayer(driftmod$mean, series='Drift') + autolayer(holtmod$mean, series='Holt') +
    autolayer(forecast(arimamod, 7)$mean, series='Arima') + ylab('USD') +
    xlab(paste('Workdays since', format(start_date, '%d %b'))) +
    guides(colour=guide_legend('Forecasts')) + ggtitle(paste(ticker_name, 'daily closing stock prices')))
  dev.off()

  # Previous accuracies ===
  prevper = window(ticker, end=length(ticker)-8)
  test = window(ticker, start=length(ticker)-7)

  olddrift = rwf(prevper, h=7, drift=T)
  oldholt = holt(prevper, h=7)
  oldarima = auto.arima(prevper, seasonal=F)

  accdrift = accuracy(olddrift, test)['Test set', 'RMSE']
  accholt = accuracy(oldholt, test)['Test set', 'RMSE']
  accarima = accuracy(forecast(oldarima, 7), test)['Test set', 'RMSE']

  accuracies = c(accuracies, accdrift, accholt, accarima)

  ##
  print(paste('Done with', ticker_name))

}

write.table(matrix(accuracies, ncol=3, byrow=T), col.names=c('DRIFT', 'HOLT', 'ARIMA'), row.names=as.character(tickers),
          file='data/accuracies.csv', sep=',')

