data(mtcars);

### Get index of manual and automatic
indxAuto <- mtcars$am == 0
indxManual <- mtcars$am == 1
### Split mtcars into manual and automatic
mtcarsAuto <- mtcars[indxAuto,]
mtcarsManual <- mtcars[indxManual,]

### Exploratory test if there is significant difference
### between the means using t-test, without fixing any other variables
t.test(mtcarsAuto$mpg, mtcarsManual$mpg)

### There is statistical significant difference between
### the non adjusted groups. It shows that manual has greater mpg
### that automatic. Hoever since the data is not normalized 
### along other variables we cannot make say anthing more.

### Lets examine the data visually
boxplot(mpg ~ am, data = mtcars, col = "yellow")

### The t test is verified visually now
### Plot histograms of mpg with automatic and transmission
hist(mtcars$mpg[indxAuto], breaks=10)
hist(mtcars$mpg[indxManual], breaks=10)

### Our first exploratory model is just fitting the model with
### just the transmission factor variable
fitTest0 <- lm(mpg ~ factor(am), data=mtcars); 
summary(fitTest0);
resTest0 <- residuals(fitTest0);
plot(resTest0 ~ mpg, data=mtcars, xlab="mpg", ylab="residuals")

### The plot of the residuals shows two clear lines which is evidence
### that our model does not explain the mpg well as. Pushing us
### to explore the possibility that the difference is due to another variable 

### We create a joint simple model that assumes a constant change
### in the difference of mpg due to transmission change
fitTest1 <- lm(mpg ~ factor(am) + . - am, data=mtcars); 
summary(fitTest1);
resTest1 <- residuals(fitTest1);
plot(resTest1 ~ mpg, data=mtcars, xlab="mpg", ylab="residuals")

### This model estimates with very low statistical significance
### factor(am)1  2.52023    2.05665   1.225   0.2340  
### Which is a 2.5 miles per gallon more for manual transmission.
### This seems contrary to our thinking, so we should explore 
### variable interactions

### The last model fits the data with low residual but none of the
### variables seems to be statistically significant, we are then
### forced to assume interaction between the variables
### This new model assumes interaction between transmission and
## all the variables
fitTest2 <- lm(mpg ~ factor(am) * (. -am), data=mtcars); 
summary(fitTest2);
resTest2 <- residuals(fitTest2);
plot(resTest2 ~ mpg, data=mtcars, xlab="mpg", ylab="residuals")

### This model fits better, but we need to fear overfitting the data so
### we select only the most significant interactions, we may loose some accuracy but we
### should strive for a simple model
### To do so we use the step function to find the best fit
fitBest <- step(fitTest2, direction='both')
summary(fitBest);
resBest <- residuals(fitBest);
plot(resBest ~ mpg, data=mtcars, xlab="mpg", ylab="residuals")



fitTest3 <- lm(mpg, factor(am) + wt, data=mtcars)
