# I will consider all loans that are not in the 'Fully Paid', 'Current', 'In Grace Period' statuses
# to be in default. Calculate the ratio of the time spent paying the loan, defined as thedifference between the last payment date and the issue date, divided by the term of loan.
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
