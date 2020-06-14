# Make a graph for the accuracy statistics
# Expectation: data/accuracy_stats.csv - accuracy table, from db
# Output: graphs/accuracies.jpg

library(ggplot2)
library(fpp2)

dat = read.csv('data/accuracy_stats.csv')  # ignore row names

jpeg('graphs/accuracies.jpg', 1024, 864)
autoplot(ts(dat)) + ylab('Relative accuracy (1=best)') + xlab('Weekly calculation iteration') +
  guides(colour=guide_legend('Models')) + ggtitle('Relative model accuracies over time')
dev.off()

