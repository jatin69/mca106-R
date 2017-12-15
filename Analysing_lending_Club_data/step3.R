# c) Calculate the average interest rate across loans for each purpose. What is the ratio of
# minimum average rate to the maximum average rate? (The ratio should be less than 1.)

# Col to be used : int_rate	- Interest Rate on the loan

# Make a matrix of avg_int_rates grouped by purpose
avg_int_rates<-aggregate(as.numeric(strsplit(mydata$int_rate,"%")), by=list(mydata$purpose), FUN=mean)

# calculation ratio of min average rate to max average rate
ratio<-min(avg_int_rates[2])/max(avg_int_rates[2])

sprintf("Required Ratio is %.10f",ratio)

# clean up
rm(avg_int_rates)
