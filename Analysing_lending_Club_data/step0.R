#clean up
rm(list=ls())

#packages to install
# install.packages("data.table")
# install.packages("moments")
# install.packages("e1071")
# install.packages("plyr")

library(data.table)

# 
# # Original 
# # Loads all columns
# year2014<-fread("LoanStats3c.csv",skip=1,showProgress=TRUE,na.strings=c("","NA","n/a"))
# year2015<-fread("LoanStats3d.csv",skip=1,showProgress=TRUE,na.strings=c("","NA","n/a"))
# # converting blank strings to NA saves us from additional overhead later

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
