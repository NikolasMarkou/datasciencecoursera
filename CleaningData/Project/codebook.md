Codebook
========
Codebook was generated on 2015-01-25 21:07:24 during the same process that generated the dataset. See `run_analysis.md` or `run_analysis.html` for details on dataset creation.

Variable list and descriptions
------------------------------

Variable name       | Description
--------------------|------------
subject             | ID the subject who performed the activity for each window sample. Its range is from 1 to 30.
activity            | Activity name
featureJerk         | Feature: Jerk signal
featureVariable     | Feature: Variable (Mean or SD)
featureAcceleration | Feature: Acceleration signal (Body or Gravity)
featureCount        | Feature: Count of data points used to compute `average`
featureInstrument   | Feature: Measuring instrument (Accelerometer or Gyroscope)
featureAxis         | Feature: 3-axial signals in the X, Y and Z directions (X, Y, or Z)
featureDomain       | Feature: Time domain signal or frequency domain signal (Time or Freq)
featureMagnitude    | Feature: Magnitude of the signals calculated using the Euclidean norm
featureAverage      | Feature: Average of each variable for each activity and each subject

Dataset structure
-----------------


```r
str(dataTableTidy)
```

```
## Classes 'data.table' and 'data.frame':	11880 obs. of  11 variables:
##  $ subject            : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ activity           : Factor w/ 6 levels "LAYING","SITTING",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ featureDomain      : Factor w/ 2 levels "Time","Freq": 1 1 1 1 1 1 1 1 1 1 ...
##  $ featureAcceleration: Factor w/ 3 levels NA,"Body","Gravity": 1 1 1 1 1 1 1 1 1 1 ...
##  $ featureInstrument  : Factor w/ 2 levels "Accelerometer",..: 2 2 2 2 2 2 2 2 2 2 ...
##  $ featureJerk        : Factor w/ 2 levels NA,"Jerk": 1 1 1 1 1 1 1 1 2 2 ...
##  $ featureMagnitude   : Factor w/ 2 levels NA,"Magnitude": 1 1 1 1 1 1 2 2 1 1 ...
##  $ featureVariable    : Factor w/ 2 levels "Mean","SD": 1 1 1 2 2 2 1 2 1 1 ...
##  $ featureAxis        : Factor w/ 4 levels NA,"X","Y","Z": 2 3 4 2 3 4 1 1 2 3 ...
##  $ count              : int  50 50 50 50 50 50 50 50 50 50 ...
##  $ average            : num  -0.0166 -0.0645 0.1487 -0.8735 -0.9511 ...
##  - attr(*, "sorted")= chr  "subject" "activity" "featureDomain" "featureAcceleration" ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

List the key variables in the data table
----------------------------------------


```r
key(dataTableTidy)
```

```
## [1] "subject"             "activity"            "featureDomain"      
## [4] "featureAcceleration" "featureInstrument"   "featureJerk"        
## [7] "featureMagnitude"    "featureVariable"     "featureAxis"
```

Show a few rows of the dataset
------------------------------


```r
dataTableTidy
```

```
##        subject         activity featureDomain featureAcceleration
##     1:       1           LAYING          Time                  NA
##     2:       1           LAYING          Time                  NA
##     3:       1           LAYING          Time                  NA
##     4:       1           LAYING          Time                  NA
##     5:       1           LAYING          Time                  NA
##    ---                                                           
## 11876:      30 WALKING_UPSTAIRS          Freq                Body
## 11877:      30 WALKING_UPSTAIRS          Freq                Body
## 11878:      30 WALKING_UPSTAIRS          Freq                Body
## 11879:      30 WALKING_UPSTAIRS          Freq                Body
## 11880:      30 WALKING_UPSTAIRS          Freq                Body
##        featureInstrument featureJerk featureMagnitude featureVariable
##     1:         Gyroscope          NA               NA            Mean
##     2:         Gyroscope          NA               NA            Mean
##     3:         Gyroscope          NA               NA            Mean
##     4:         Gyroscope          NA               NA              SD
##     5:         Gyroscope          NA               NA              SD
##    ---                                                               
## 11876:     Accelerometer        Jerk               NA              SD
## 11877:     Accelerometer        Jerk               NA              SD
## 11878:     Accelerometer        Jerk               NA              SD
## 11879:     Accelerometer        Jerk        Magnitude            Mean
## 11880:     Accelerometer        Jerk        Magnitude              SD
##        featureAxis count     average
##     1:           X    50 -0.01655309
##     2:           Y    50 -0.06448612
##     3:           Z    50  0.14868944
##     4:           X    50 -0.87354387
##     5:           Y    50 -0.95109044
##    ---                              
## 11876:           X    65 -0.56156521
## 11877:           Y    65 -0.61082660
## 11878:           Z    65 -0.78475388
## 11879:          NA    65 -0.54978489
## 11880:          NA    65 -0.58087813
```

Summary of variables
--------------------


```r
summary(dataTableTidy)
```

```
##     subject                   activity    featureDomain
##  Min.   : 1.0   LAYING            :1980   Time:7200    
##  1st Qu.: 8.0   SITTING           :1980   Freq:4680    
##  Median :15.5   STANDING          :1980                
##  Mean   :15.5   WALKING           :1980                
##  3rd Qu.:23.0   WALKING_DOWNSTAIRS:1980                
##  Max.   :30.0   WALKING_UPSTAIRS  :1980                
##  featureAcceleration     featureInstrument featureJerk  featureMagnitude
##  NA     :4680        Accelerometer:7200    NA  :7200   NA       :8640   
##  Body   :5760        Gyroscope    :4680    Jerk:4680   Magnitude:3240   
##  Gravity:1440                                                           
##                                                                         
##                                                                         
##                                                                         
##  featureVariable featureAxis     count          average        
##  Mean:5940       NA:3240     Min.   :36.00   Min.   :-0.99767  
##  SD  :5940       X :2880     1st Qu.:49.00   1st Qu.:-0.96205  
##                  Y :2880     Median :54.50   Median :-0.46989  
##                  Z :2880     Mean   :57.22   Mean   :-0.48436  
##                              3rd Qu.:63.25   3rd Qu.:-0.07836  
##                              Max.   :95.00   Max.   : 0.97451
```

List all possible combinations of features
------------------------------------------


```r
dataTableTidy[, .N, by=c(names(dataTableTidy)[grep("^feature", names(dataTableTidy))])]
```

```
##     featureDomain featureAcceleration featureInstrument featureJerk
##  1:          Time                  NA         Gyroscope          NA
##  2:          Time                  NA         Gyroscope          NA
##  3:          Time                  NA         Gyroscope          NA
##  4:          Time                  NA         Gyroscope          NA
##  5:          Time                  NA         Gyroscope          NA
##  6:          Time                  NA         Gyroscope          NA
##  7:          Time                  NA         Gyroscope          NA
##  8:          Time                  NA         Gyroscope          NA
##  9:          Time                  NA         Gyroscope        Jerk
## 10:          Time                  NA         Gyroscope        Jerk
## 11:          Time                  NA         Gyroscope        Jerk
## 12:          Time                  NA         Gyroscope        Jerk
## 13:          Time                  NA         Gyroscope        Jerk
## 14:          Time                  NA         Gyroscope        Jerk
## 15:          Time                  NA         Gyroscope        Jerk
## 16:          Time                  NA         Gyroscope        Jerk
## 17:          Time                Body     Accelerometer          NA
## 18:          Time                Body     Accelerometer          NA
## 19:          Time                Body     Accelerometer          NA
## 20:          Time                Body     Accelerometer          NA
## 21:          Time                Body     Accelerometer          NA
## 22:          Time                Body     Accelerometer          NA
## 23:          Time                Body     Accelerometer          NA
## 24:          Time                Body     Accelerometer          NA
## 25:          Time                Body     Accelerometer        Jerk
## 26:          Time                Body     Accelerometer        Jerk
## 27:          Time                Body     Accelerometer        Jerk
## 28:          Time                Body     Accelerometer        Jerk
## 29:          Time                Body     Accelerometer        Jerk
## 30:          Time                Body     Accelerometer        Jerk
## 31:          Time                Body     Accelerometer        Jerk
## 32:          Time                Body     Accelerometer        Jerk
## 33:          Time             Gravity     Accelerometer          NA
## 34:          Time             Gravity     Accelerometer          NA
## 35:          Time             Gravity     Accelerometer          NA
## 36:          Time             Gravity     Accelerometer          NA
## 37:          Time             Gravity     Accelerometer          NA
## 38:          Time             Gravity     Accelerometer          NA
## 39:          Time             Gravity     Accelerometer          NA
## 40:          Time             Gravity     Accelerometer          NA
## 41:          Freq                  NA         Gyroscope          NA
## 42:          Freq                  NA         Gyroscope          NA
## 43:          Freq                  NA         Gyroscope          NA
## 44:          Freq                  NA         Gyroscope          NA
## 45:          Freq                  NA         Gyroscope          NA
## 46:          Freq                  NA         Gyroscope          NA
## 47:          Freq                  NA         Gyroscope          NA
## 48:          Freq                  NA         Gyroscope          NA
## 49:          Freq                  NA         Gyroscope        Jerk
## 50:          Freq                  NA         Gyroscope        Jerk
## 51:          Freq                Body     Accelerometer          NA
## 52:          Freq                Body     Accelerometer          NA
## 53:          Freq                Body     Accelerometer          NA
## 54:          Freq                Body     Accelerometer          NA
## 55:          Freq                Body     Accelerometer          NA
## 56:          Freq                Body     Accelerometer          NA
## 57:          Freq                Body     Accelerometer          NA
## 58:          Freq                Body     Accelerometer          NA
## 59:          Freq                Body     Accelerometer        Jerk
## 60:          Freq                Body     Accelerometer        Jerk
## 61:          Freq                Body     Accelerometer        Jerk
## 62:          Freq                Body     Accelerometer        Jerk
## 63:          Freq                Body     Accelerometer        Jerk
## 64:          Freq                Body     Accelerometer        Jerk
## 65:          Freq                Body     Accelerometer        Jerk
## 66:          Freq                Body     Accelerometer        Jerk
##     featureDomain featureAcceleration featureInstrument featureJerk
##     featureMagnitude featureVariable featureAxis   N
##  1:               NA            Mean           X 180
##  2:               NA            Mean           Y 180
##  3:               NA            Mean           Z 180
##  4:               NA              SD           X 180
##  5:               NA              SD           Y 180
##  6:               NA              SD           Z 180
##  7:        Magnitude            Mean          NA 180
##  8:        Magnitude              SD          NA 180
##  9:               NA            Mean           X 180
## 10:               NA            Mean           Y 180
## 11:               NA            Mean           Z 180
## 12:               NA              SD           X 180
## 13:               NA              SD           Y 180
## 14:               NA              SD           Z 180
## 15:        Magnitude            Mean          NA 180
## 16:        Magnitude              SD          NA 180
## 17:               NA            Mean           X 180
## 18:               NA            Mean           Y 180
## 19:               NA            Mean           Z 180
## 20:               NA              SD           X 180
## 21:               NA              SD           Y 180
## 22:               NA              SD           Z 180
## 23:        Magnitude            Mean          NA 180
## 24:        Magnitude              SD          NA 180
## 25:               NA            Mean           X 180
## 26:               NA            Mean           Y 180
## 27:               NA            Mean           Z 180
## 28:               NA              SD           X 180
## 29:               NA              SD           Y 180
## 30:               NA              SD           Z 180
## 31:        Magnitude            Mean          NA 180
## 32:        Magnitude              SD          NA 180
## 33:               NA            Mean           X 180
## 34:               NA            Mean           Y 180
## 35:               NA            Mean           Z 180
## 36:               NA              SD           X 180
## 37:               NA              SD           Y 180
## 38:               NA              SD           Z 180
## 39:        Magnitude            Mean          NA 180
## 40:        Magnitude              SD          NA 180
## 41:               NA            Mean           X 180
## 42:               NA            Mean           Y 180
## 43:               NA            Mean           Z 180
## 44:               NA              SD           X 180
## 45:               NA              SD           Y 180
## 46:               NA              SD           Z 180
## 47:        Magnitude            Mean          NA 180
## 48:        Magnitude              SD          NA 180
## 49:        Magnitude            Mean          NA 180
## 50:        Magnitude              SD          NA 180
## 51:               NA            Mean           X 180
## 52:               NA            Mean           Y 180
## 53:               NA            Mean           Z 180
## 54:               NA              SD           X 180
## 55:               NA              SD           Y 180
## 56:               NA              SD           Z 180
## 57:        Magnitude            Mean          NA 180
## 58:        Magnitude              SD          NA 180
## 59:               NA            Mean           X 180
## 60:               NA            Mean           Y 180
## 61:               NA            Mean           Z 180
## 62:               NA              SD           X 180
## 63:               NA              SD           Y 180
## 64:               NA              SD           Z 180
## 65:        Magnitude            Mean          NA 180
## 66:        Magnitude              SD          NA 180
##     featureMagnitude featureVariable featureAxis   N
```

Save to file
------------

Save data table objects to a tab-delimited text file called `TidyDataset.txt`.


```r
f <- file.path(path, "TidyDataset.txt")
```

```
## Error in file.path(path, "TidyDataset.txt"): object 'path' not found
```

```r
write.table(dataTableTidy, f, quote=FALSE, sep="\t", row.names=FALSE)
```

```
## Error in write.table(dataTableTidy, f, quote = FALSE, sep = "\t", row.names = FALSE): object 'f' not found
```
