# load packages
#library(knitr)
#library(markdown)
# library(rmarkdown)

setwd('/Users/stephen.gillespie/Documents/Army Memo/Example Multi-Memo/')
library(ggplot2)

# We'll produce a report for the governor of each state based on the standard data set 'USArrests'

myReport <- USArrests
myReport$State <- rownames(myReport)

p <- ggplot(myReport, aes(x = Murder)) + geom_density() + theme_minimal()
nationalMean <- mean(myReport$Murder)
# Produce a report for each state
# these reports are saved in output_dir with the name specified by output_file
for (i in 1:length(myReport$State)){
  stateData <- myReport[i,]
  rmarkdown::render("/Users/stephen.gillespie/Documents/Army Memo/Example Multi-Memo/ExampleMultiMemo.Rmd", 
                    output_format = 'word_document',
                    output_file = paste('MurderReport_', stateData$State, '_', Sys.Date(), '.docx', sep = ''),
                    output_dir = '/Users/stephen.gillespie/Documents/Army Memo/Example Multi-Memo/StateMemos', 
                    params = c(p, stateData, nationalMean)
  )
}

