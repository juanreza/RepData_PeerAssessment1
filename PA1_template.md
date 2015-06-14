# assignment1.md

# DEVELOPMENT SCRAPS
# setwd("c:/edu/_DataScienceJohnsHopkins/_ReproducibleResearch/_ASGN1")
# source("PA1_template.Rmd")

# Title / Author
## Assignment1: Steps Among Tech Geeks
Author: (omitted per assignment instructions)

### Abstract
We are interested in discovering the average daily activity pattern of TODO subjects. 
We want to discover whether the differences in activity patterns between weekdays and weekends.
We also want to find the time of day when the most steps occur.
 To operationalize this approach we take 5-minute intervals across all days in a sample, and compute the average number of steps at each time of day. The interval with the greatest number of steps (on average) reveals the pattern of interest.

# Body / Results

TODO: 
Figure 1. plot weekday versus weekend patterns.


### Analysis Method


TODO: differences in activity patterns between weekdays and weekends


#### Comparison of weekday and weekend patterns

TODO


### Results

Total steps per day: 
Histogram of daily number of steps:

Time series plot (type l L:l, not one:1)


### Discussion

2304	NA's
175698	data points
	1.31%	percent of data that is missing measurements


### Conclusion

### Supplementary Materials / gory details


#### Data-Cleaning Strategy

#### Manual activity performed
Scanned the activity data file to confirm that (1) steps column contains NA values, and (2) date and interval contain valid (non-NA) values.


##### Missing data points
The sample measurements include some points with missing data. This could bias the results.
We take this into account in our analysis.
The total number of missing values in the sample is `print("MISSING NA")`
In order to compensate for missing data points we devised a simple procedure. It is based on the idea that the person's activity level changes more-or-less gradually, so the number of steps in one interval will be similar to that in adjacent intervals, on average.
This histogram appears to support this assumption.

##### Data-Cleaning Procedure

Each place-holder for missing data is replaced with the 
average of the two nearest points (that are not missing).
This yields intermediate dataset activity2Cleaned.csv



### Code / Data really gory details


################ cruft below


# sample:
# "steps","date","interval"
# NA,"2012-10-01",0
# NA,"2012-10-01",5
# NA,"2012-10-01",10
# NA,"2012-10-01",15
# NA,"2012-10-01",20





GORY DETAILS

> sessionInfo()
R version 3.2.0 (2015-04-16)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 8 x64 (build 9200)

locale:
[1] LC_COLLATE=English_United States.1252 
[2] LC_CTYPE=English_United States.1252   
[3] LC_MONETARY=English_United States.1252
[4] LC_NUMERIC=C                          
[5] LC_TIME=English_United States.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets 
[6] methods   base     

loaded via a namespace (and not attached):
[1] tools_3.2.0
> 

