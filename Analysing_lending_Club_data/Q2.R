# Set wd and place files in 
# setwd("")

#clean up of memory
rm(list=ls())

start_time <- Sys.time() # Calculate time diff on the big files

#packages to install
# install.packages("data.table")
# install.packages("moments")
# install.packages("e1071")
# install.packages("plyr")

library(data.table)

# Optimised
# Loads only required Columns 
year2014<-fread("LoanStats3c.csv",skip=1,showProgress=TRUE,na.strings=c("","NA","n/a"),
                select=c("loan_amnt","purpose","int_rate","issue_d","last_pymnt_d","term","total_rec_int",
                         "loan_status","addr_state","sub_grade")
                )
year2015<-fread("LoanStats3d.csv",skip=1,showProgress=TRUE,na.strings=c("","NA","n/a"),
                select=c("loan_amnt","purpose","int_rate","issue_d","last_pymnt_d","term","total_rec_int",
                         "loan_status","addr_state","sub_grade")
                )
# converting blank strings to NA saves us from additional overhead later

mydata<-rbind(year2014,year2015)
#head(mydata[,1:4],6)

# cleaning intermediate data
rm(year2014,year2015)

# ------------------------------------------------------------------------------------

# a) find the median of loan amount.
# col to be used : loan_amnt

# testing on head
# as.numeric(head(mydata$loan_amnt,5))
# median(as.numeric(head(mydata$loan_amnt,5)),na.rm = T)

#on actual data
loan_amnt_median<-median(as.numeric(mydata$loan_amnt))
cat(" (a) Median of loan amount is : ",loan_amnt_median)

#cleanup`
rm(loan_amnt_median)
# ------------------------------------------------------------------------------------

# b) Each loan is categorized into a single purpose. What fraction of all loans 
# are for the most common purpose?
# col to be used : purpose

# convert to factors
purpose_factor<-factor(mydata$purpose)
# to view levels
#levels(purpose_factor)
# to count occurences of each level in the factor
# summary(purpose_factor)

fraction<-(max(summary(purpose_factor))/sum(summary(purpose_factor)))
sprintf(" (b) Fraction of loans for a common purpose :  %.10f",fraction)

#cleanup
rm(purpose_factor)
# ------------------------------------------------------------------------------------

# c) Calculate the average interest rate across loans for each purpose. What is the ratio of
# minimum average rate to the maximum average rate? (The ratio should be less than 1.)
# Col to be used : int_rate	- Interest Rate on the loan

# Make a matrix of avg_int_rates grouped by purpose
avg_int_rates<-aggregate(as.numeric(strsplit(mydata$int_rate,"%")), by=list(mydata$purpose), FUN=mean)

# calculation ratio of min average rate to max average rate
ratio<-min(avg_int_rates[2])/max(avg_int_rates[2])

sprintf(" (c) Required Ratio is %.10f",ratio)

# clean up
rm(avg_int_rates)
# ------------------------------------------------------------------------------------

# (d) What is the difference in the fraction of the loans with a 36-month term 
# between 2014 and 2015?
# Required Fraction 
# 0.017472334236841358 

year2014<-fread("LoanStats3c.csv",skip=1,showProgress=TRUE,select=c("term"))
year2015<-fread("LoanStats3d.csv",skip=1,showProgress=TRUE,select=c("term"))

data2014<-factor(year2014$term)
data2015<-factor(year2015$term)

frac2014<-(summary(data2014)[1]/sum(summary(data2014)))
frac2015<-(summary(data2015)[1]/sum(summary(data2015)))
frac<-frac2014-frac2015

sprintf(" (d) Required fraction is %.10f",frac)

#cleanup
rm(year2014,year2015,data2014,data2015,frac2014,frac2015,frac)
# ------------------------------------------------------------------------------------

# e) I will consider all loans that are not in the 'Fully Paid', 'Current', 'In Grace Period' statuses
# to be in default. Calculate the ratio of the time spent paying the loan, defined as thedifference between
# the last payment date and the issue date, divided by the term of loan.
# What is the standard deviation of this ratio for all the loans in default?
#
# Columns used : loan_status,term,issue_d,last_pymnt_d

default_status<- subset(mydata, 
                        !(loan_status=="Fully Paid" | loan_status=="Current" | loan_status=="In Grace Period"),
                        select = c("issue_d","last_pymnt_d","term"))
# NA values in last_pymnt_d are handled at last in sd function

issue_date<- as.Date(paste("1-",default_status$issue_d,sep=""), format="%d-%b-%Y")
last_payment_date <- as.Date(paste("1-",default_status$last_pymnt_d,sep=""), format="%d-%b-%Y")

# Months spent paying the loan by the borrower
time_spent_paying<-((last_payment_date)-(issue_date))/30

# ratio = time spent by user / total term
ratio_time_spent_paying<- time_spent_paying/ (as.numeric(strsplit(default_status$term," months")))

sd_of_ratio<- sd(ratio_time_spent_paying,na.rm=TRUE)
sprintf("Standard deviation is %.10f",sd_of_ratio)

# cleanup
rm(default_status,issue_date,last_payment_date,ratio_time_spent_paying,time_spent_paying)
# ------------------------------------------------------------------------------------
# f)
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
# ------------------------------------------------------------------------------------

# (g)
# Let's find a loan purpose that shows up abnormally often in one state. Call A the probability
# of a loan going to a specific purpose nationwide. Call B the probability of a loan going to
# a specific purpose for each state. Out of all (state, purpose) pairs with at least 10 loans,
# what is the highest ratio of B / A (i.e. the most surprising)?


library(plyr)

# 
# AIM 1 : Calculate probability of a loan going to Delhi, for car purpose
# TODO : we need to find how many loans went to delhi and for what purpose did they go,
# so we find a matrix with state-purpose-countofloan data

# create state purpose pairs
state_purpose_pairs <- ddply(mydata, .(mydata$addr_state, mydata$purpose), nrow)
names(state_purpose_pairs) <- c("State", "Purpose", "Count")
req_pairs<-state_purpose_pairs[which(state_purpose_pairs$Count>=10),]
#req_pairs

# FINDING PROBABILITY OF ALL CAR LOANS IN DELHI STATE

# created a matrix for totals of each state
State_Sum<- (aggregate(req_pairs$Count, by=list(State=req_pairs$State), FUN=sum))
# tweaking it so, col names can be accessed and count of state can be obtained
state_matrix<-t(as.matrix(State_Sum[,"x"]))
colnames(state_matrix)<-c(State_Sum[,"State"])

# find prob of all state purpose pairs - That is prob B - as per question
state_prob<-(req_pairs$Count)/(state_matrix[,c(as.character(req_pairs$State))])


#
# AIM 1 : Calculate the probability of a loan going for CAR purpose, in all over INDIA
# TODO: we need to find how many car loans were issued in INDIA, then find prob. of car loan issuing among all the purposes

# This will give us the total car loans in INDIA 
nation_fav_outcomes<-summary(factor(mydata$purpose))
# This will give us the total loans in INDIA
nation_total_outcomes<-sum(summary(nation_fav_outcomes))
# making tweaks for accessing and manipulation
nation_matrix<-t(as.matrix(nation_fav_outcomes/nation_total_outcomes))

# Nation prob- A , as per question
nation_prob<-as.matrix(nation_matrix[1,as.character(req_pairs$Purpose)])


# Calculation prob ration B/A
prob_ratio<-(state_prob/nation_prob)


#### MERGING A and B with original state purpose pairs for easy user view

final_data <- cbind(req_pairs,state_prob,nation_prob, prob_ratio )

# finding the abnormality column based on ration value
abnormal<-final_data[which( final_data$prob_ratio == max(final_data$prob_ratio)),]

# Storing the abnormal ratio
abnormal_ratio <- abnormal[,"prob_ratio"]

sprintf("Abnormal Ratio is %.10f",abnormal_ratio)

#cleanup
rm(abnormal_ratio,abnormal,final_data,nation_matrix,nation_prob,prob_ratio,req_pairs,state_matrix,state_purpose_pairs,State_Sum,nation_fav_outcomes,nation_total_outcomes,state_prob)

# ------------------------------------------------------------------------------------

# (h) 
# Group all loans by their sub-grade and calculate their 
# average interest rate, average default rate, and percentage of loan status categories.
# Average default rate is no term. It is default rate.
# I will consider all loans that are not in the 'Fully Paid', 'Current', 'In Grace Period' statuses
# to be in default.
# col used : sub_grade, int_rate, loan_status
# 

library(data.table)



# Average Interest rate
# what is the averages of interest rates in a sub-grade
data_set<-aggregate(as.numeric(strsplit(mydata$int_rate,"%")), by=list(mydata$sub_grade), FUN=mean)
names(data_set)<-c("Sub_grade","avg_int_rate")



# Default rate
# In a particular sub-grade, what is the default rate, i.e. no of default loan status/ total loan status
# and here default loan status is assumed as ALL - (fully paid + current + in grace)
total_in_subgroup<-summary(factor(mydata$sub_grade))

default_status<- subset(mydata, !(loan_status=="Fully Paid" | loan_status=="Current" | loan_status=="In Grace Period"),select = c("sub_grade","loan_status"))
default_in_subgroup<-summary(factor(default_status$sub_grade))

default_rate<-default_in_subgroup/total_in_subgroup
data_set<- cbind(data_set,default_rate)
cat("Part 1 of q2(h)")
data_set


# Now for loan status categories, its 2-level grouping
# Displays all subgrade-loan_status pairs. 
# Percentage tells the amount of the contribution each status makes to that subgrade.
# usefulness : How much %age farmers paid the fully loan ?
# How much %age business man need waiving off of loans ?

library(plyr)

# create subgrade-loanstatus pairs
subgrade_loanstatus_pairs <- ddply(mydata, .(mydata$sub_grade, mydata$loan_status), nrow)
names(subgrade_loanstatus_pairs) <- c("sub_grade", "loan_status", "Count")

State_Sum<- (aggregate(subgrade_loanstatus_pairs$Count, by=list(sub_grade=subgrade_loanstatus_pairs$sub_grade), FUN=sum))
# tweaking it so, col names can be accessed and count of state can be obtained
state_matrix<-t(as.matrix(State_Sum[,"x"]))
colnames(state_matrix)<-c(State_Sum[,"sub_grade"])

percentage<- ( (subgrade_loanstatus_pairs$Count)/
  (state_matrix[,as.character(subgrade_loanstatus_pairs$sub_grade)]) ) *100

subgrade_loanstatus_pairs<-cbind(subgrade_loanstatus_pairs,percentage)
cat("Part 1 of q2(h)")
subgrade_loanstatus_pairs

# Verified.
#sum(subgrade_loanstatus_pairs[which(subgrade_loanstatus_pairs$sub_grade=="A1"),"percentage"])

#cleanup
rm(data_set,total_in_subgroup,default_status,default_in_subgroup,default_rate)
rm(subgrade_loanstatus_pairs,percentage,state_matrix,State_Sum)

# ------------------------------------------------------------------------------------

end_time <- Sys.time() # Calculate time diff on the big files
time_diff <- end_time - start_time # Calculate the time difference
time_diff

