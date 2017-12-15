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
rm(subgrade_loanstatus_pairs,percentage)
