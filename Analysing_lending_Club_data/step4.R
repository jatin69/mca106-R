# What is the difference in the fraction of the loans with a 36-month term between 2014 and
# 2015?
# Required Fraction 
# 0.017472334236841358 

library(data.table)

year2014<-fread("LoanStats3c.csv",skip=1,showProgress=TRUE,select=c("term"))
year2015<-fread("LoanStats3d.csv",skip=1,showProgress=TRUE,select=c("term"))

data2014<-factor(year2014$term)
data2015<-factor(year2015$term)

frac2014<-(summary(data2014)[1]/sum(summary(data2014)))
frac2015<-(summary(data2015)[1]/sum(summary(data2015)))
frac<-frac2014-frac2015

sprintf("Required fraction is %.10f",frac)

#cleanup
#rm(year2014,year2015,data2014,data2015,frac2014,frac2015,frac)
