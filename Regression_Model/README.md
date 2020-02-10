# Regression_model
Looking at a data set of a collection of cars, they are interested in exploring the relationship between a set of variables and miles per gallon (MPG) (outcome). They are particularly interested in the following two questions:  

“Is an automatic or manual transmission better for MPG”.  
"Quantify the MPG difference between automatic and manual transmissions".  

First, basic data processing would be used to convert the factor of am to the level of ""automatic" and "manual".  
Then we have to differentiate the effect of mpg from two different transmissions by boxplot and use t.test to prove the true difference effect between the two.  
Variance inflation provides some clues for giving up the unnecessary variables.  
The remaining variables are am, cyl, disp, wt, which finally are to be determined in model selection by anova.
