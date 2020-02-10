Introduction
------------

It is now possible to collect a large amount of data about personal
movement using activity monitoring devices such as a Fitbit, Nike
Fuelband, or Jawbone Up. These type of devices are part of the
“quantified self” movement – a group of enthusiasts who take
measurements about themselves regularly to improve their health, to find
patterns in their behavior, or because they are tech geeks. But these
data remain under-utilized both because the raw data are hard to obtain
and there is a lack of statistical methods and software for processing
and interpreting the data.

This assignment makes use of data from a personal activity monitoring
device. This device collects data at 5 minute intervals through out the
day. The data consists of two months of data from an anonymous
individual collected during the months of October and November, 2012 and
include the number of steps taken in 5 minute intervals each day.

\#\#Code for reading in the dataset and/or processing the data 1.
Loading of the pachage. Default of the echo will be throughout the
document

``` r
library(knitr)
opts_chunk$set(dev = "png")
```

1.  read csv file

``` r
act = read.csv("/Users/apple/Downloads/activity.csv", na.strings = "NA")
act$date <- as.Date(as.character(act$date, "%Y%m%d"))
summary(act)
```

    ##      steps             date               interval     
    ##  Min.   :  0.00   Min.   :2012-10-01   Min.   :   0.0  
    ##  1st Qu.:  0.00   1st Qu.:2012-10-16   1st Qu.: 588.8  
    ##  Median :  0.00   Median :2012-10-31   Median :1177.5  
    ##  Mean   : 37.38   Mean   :2012-10-31   Mean   :1177.5  
    ##  3rd Qu.: 12.00   3rd Qu.:2012-11-15   3rd Qu.:1766.2  
    ##  Max.   :806.00   Max.   :2012-11-30   Max.   :2355.0  
    ##  NA's   :2304

1.  Histogram of the total steps of each day

``` r
daily_steps_sum <- aggregate(steps ~ date, act, sum, rm.na=TRUE)
str(daily_steps_sum)
```

    ## 'data.frame':    53 obs. of  2 variables:
    ##  $ date : Date, format: "2012-10-02" "2012-10-03" ...
    ##  $ steps: int  127 11353 12117 13295 15421 11016 12812 9901 10305 17383 ...

``` r
hist(daily_steps_sum$steps, xlab = "number of steps", 
     main = "Histogram of the total number of steps taken each day", ylab = "")
```

![unnamed-chunk-3-1](https://raw.githubusercontent.com/stephenyang0215/Reproducible-research-project1/master/PA1_template_files/figure-markdown_github/unnamed-chunk-3-1.png)

\#\#Mean and median number of steps taken each day

``` r
daily_steps_mean <- mean(daily_steps_sum$steps)
daily_steps_med <- median(daily_steps_sum$steps)
```

\#\#Time series plot of the average number of steps taken 1. Average
number of steps in 5-minute interval

``` r
average_steps <- aggregate(steps ~ interval, act, mean, rm.na=TRUE)
str(average_steps)
```

    ## 'data.frame':    288 obs. of  2 variables:
    ##  $ interval: int  0 5 10 15 20 25 30 35 40 45 ...
    ##  $ steps   : num  1.717 0.3396 0.1321 0.1509 0.0755 ...

1.  Plot of average number of steps taken in 5-minute interval

``` r
plot(average_steps$interval, average_steps$steps, type = "l", 
     xlab = "Time interval", ylab = "average number of steps taken"
     )
```

![unnamed-chunk-6-1](https://raw.githubusercontent.com/stephenyang0215/Reproducible-research-project1/master/PA1_template_files/figure-markdown_github/unnamed-chunk-6-1.png)

\#\#The 5-minute interval that, on average, contains the maximum number
of steps

``` r
max_aveage_steps <- which(average_steps$steps == max(average_steps$steps))
max_steps_interval <- average_steps[max_aveage_steps, "interval"] 
```

\#\#Code to describe and show a strategy for imputing missing data
1.Getting the data structure of the NA value in column steps

``` r
missing_value <- sum(is.na(act$steps))
Imputed_missing_value <- act
```

2.Assigning the value in each NA steps

``` r
for (i in (1: length(Imputed_missing_value$steps))){
  if(is.na(Imputed_missing_value$steps[i])){
    Int <- Imputed_missing_value$interval[i]
    Imputed_missing_value$steps[i] <- 
      average_steps[Int == average_steps$interval, 2]
  }
}
```

\#\#Histogram of the total number of steps taken each day after missing
values are imputed

``` r
sum_imputed_missing_value <- aggregate(steps ~ date, Imputed_missing_value, sum)
hist(sum_imputed_missing_value$steps, xlab = "number of steps", 
     ylab = "", main = "Histogram of the total number of steps taken each day")
```

![unnamed-chunk-10-1](https://raw.githubusercontent.com/stephenyang0215/Reproducible-research-project1/master/PA1_template_files/figure-markdown_github/unnamed-chunk-10-1.png)

\#\#Panel plot comparing the average number of steps taken per 5-minute
interval across weekdays and weekends 1. Identify the weekday and
weekend in the date column

``` r
Imputed_missing_value$weekdays <- weekdays(as.Date(Imputed_missing_value$date))
Imputed_missing_value$weekdays <- ifelse(Imputed_missing_value$weekdays == "Saturday"|Imputed_missing_value$weekdays == "Sunday", "weekend", "weekday")
```

1.  Create two dataframes based on weekdays and weekend

``` r
activity_weekend <- subset(Imputed_missing_value, Imputed_missing_value$weekdays=="weekend")
activity_weekdays <- subset(Imputed_missing_value, Imputed_missing_value$weekdays=="weekday")
```

1.  Create the panel plots

``` r
plot(activity_weekdays$interval, activity_weekdays$steps, main = "Average steps taken 5 minute interval across weekdays"
     , type = "l", col = "blue", xlab = "Interval", ylab = "Step", xlim = c(0,2355), ylim = c(0, 800))
```

![unnamed-chunk-13-1](https://github.com/stephenyang0215/Reproducible-research-project1/blob/master/PA1_template_files/figure-markdown_github/unnamed-chunk-13-1.png)

``` r
plot(activity_weekend$interval, activity_weekend$steps, main = "Average steps taken 5 minute interval across weekend"
     , type = "l", col = "red", xlab = "Interval", ylab = "Step", xlim = c(0,2355), ylim = c(0, 800))
```

![000005](https://raw.githubusercontent.com/stephenyang0215/Reproducible-research-project1/master/PA1_template_files/figure-markdown_github/000005.png)
