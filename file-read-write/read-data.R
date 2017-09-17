getwd()
setwd("C:/Users/DUCS/Documents/jatin")

read.csv("data.csv")
read.table("data.csv")
read.table("text.txt")

con<-file("text.txt")
open(con,"r")
data<-readLines(con)
close(con)
data


readLines("text.txt")
