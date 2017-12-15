# a) find the median of loan amount.
# col to be used : loan_amnt


#testing on head
# as.numeric(head(mydata$loan_amnt,5))
# median(as.numeric(head(mydata$loan_amnt,5)),na.rm = T)

#on actual data
loan_amnt_median<-median(as.numeric(mydata$loan_amnt))
cat("Median of loan amount is : ",loan_amnt_median)

#cleanup
rm(loan_amnt_median)
