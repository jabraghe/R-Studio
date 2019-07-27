# Hello. Please enjoy this learning video on Logistic Regression while listening "Petals (Floriscope)"
# We are going to use the library MASS

# install.packages('MASS')
library(MASS)

# and the dataset birthwt avaiable
data(birthwt)
?birthwt

# let's have a look at the dataset
head(birthwt)
str(birthwt)
# the variables are all integers.
# we need to make sure that the categorical variables are defined as factors
birthwt$race<-as.factor(birthwt$race)
birthwt$smoke<-as.factor(birthwt$smoke)
birthwt$ht<-as.factor(birthwt$ht)
birthwt$ui<-as.factor(birthwt$ui)
# check
str(birthwt)

# summary for race variable
table(birthwt$race)
# (1 = white, 2 = black, 3 = other)
# let's plot it
#install.packages('plotrix')
library(plotrix)
slices <- c(96, 26, 67) 
lbls <- c("white", "black", "other")
pie3D(slices,labels=lbls,explode=0.1,
      main="Jabraghe: Learn with Classical Music ")


# Logistic Regression
model<-glm(low~ age + lwt + race + smoke + ptl + ht + ui + ftv, 
           data=birthwt,family= "binomial" ) # glm stands for generalized linear model
summary(model)

# Null deviance: 234.67 = deviance of the model with no predictors
# Residual deviance: 201.28 = deviance of the model with all predictors
# The model have a difference of 188 − 179 = 9 parameters.

# from looking at p-value, we can deduct that only the variables
# lwt, race2, race3, smoke1, ht1 are significant because
# they have a p-value < 0.05 --> reject the null hypothesis of a variable having coefficients = 0.
# in other words, there is a relationship between an independent variable and the response variable
# if its p-value is << 0.05

# let's try to fit our model with only those variables. 
# We expect an improvement of our model

model1<-glm(low ~ lwt + race + smoke  + ht , 
            data=birthwt,family= "binomial" ) # glm stands for generalized linear model
summary(model1)

# Look at AIC (Akaike information Criterion) https://en.wikipedia.org/wiki/Akaike_information_criterion
# The Akaike information criterion (AIC) is a measure of the relative quality
# of a statistical model for a given set of data.
# As such, AIC provides a means for model selection 

# we can see that our model1 is better than model (lower AIC)
# However, you should not only focus on this measure.

# We can use the predict() command to look at the fitted values
# from the model.
predict (model1) # predicted log-odds for each obs
predict (model1, type = 'response') # predicted prob for each obs

# We can also calculate the confidence intervals for each term
# Extract the coefficients of the model
coeff<-coef(model1)
coeff # note: lwt has a negative relationship with the respone variable

# Compute the odds
exp(coeff)

# Compute a 95% confidence interval for coeff & odds
# Compute confidence limits for beta
coeffLB<-summary(model1)$coef[,1]-qt(0.975,summary(model1)$df.residual)*summary(model1)$coef[,2]
coeffLB
coeffUB<-summary(model1)$coef[,1]+qt(0.975,summary(model1)$df.residual)*summary(model1)$coef[,2]
coeffUB

# let's create a table containing full information
overall <- cbind (coeffLB,coeff,coeffUB)
overall
# Compute odds & confidence limits for odds
exp(overall)

print ('Thanks for watching.')
print (' You can find the code in the description.')