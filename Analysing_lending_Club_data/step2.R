# b)
# Each loan is categorized into a single purpose. What fraction of all loans are for the most
# common purpose?
# col to be used : purpose

# quick peek
#head(mydata$purpose)

# convert to factors
purpose_factor<-factor(mydata$purpose)
# to view levels
#levels(purpose_factor)
# to count occurences of each level in the factor
# summary(purpose_factor)

fraction<-(max(summary(purpose_factor))/sum(summary(purpose_factor)))
sprintf("Fraction of loans for a common purpose :  %.10f",fraction)

#cleanup
rm(purpose_factor)
