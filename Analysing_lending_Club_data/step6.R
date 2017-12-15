# What is the Mean, Median, Mean Absolute Deviation, Variance, IQR, Skewness and
# Kurtosis for the total rate of return, as figured from the total payments and the loan amount,
# and the interest rate? Consider only loans that have reached the end of their term. 
# [Summary function NOT to be used here]
#
# Columns used : total_pymnt,loan_amnt,int_rate


# Assumption - rate of return percent = (interest received/original value ) * 100

data_set<-subset(mydata, (loan_status=="Fully Paid"), select = c("loan_amnt","total_rec_int","term"))

rate_of_return<-(as.numeric(data_set$total_rec_int)/as.numeric(data_set$loan_amnt))*100
# In percent


# mean
sprintf("(f) MEAN is %.10f",mean(rate_of_return))

#median
sprintf("(f) Median is %.10f",median(rate_of_return))

# Mean absolute deviation
sprintf("(f) Mean Absolute deviation is %.10f",mad(rate_of_return))

# Variance
sprintf("(f) Variance is %.10f",var(rate_of_return))

#head(mydata$loan_status,200)
sprintf("(f) IQR is %.10f",IQR(rate_of_return))

library(moments)
sprintf("(f) Skewness is %.10f",skewness(rate_of_return))

library(e1071)
sprintf("(f) Kurtosis is %.10f",kurtosis(rate_of_return))

# for plotting skewness and kurtosis
plot(density(rate_of_return), xlim=c(min(rate_of_return), max(rate_of_return)))

#cleanup
rm(data_set,rate_of_return)
