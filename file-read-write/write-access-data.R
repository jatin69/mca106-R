getwd()
setwd("C:/Users/DUCS/Documents/jatin")

data<-iris
data

write.csv(data, file = "Book.csv")
read.csv("Book.csv")

write.csv(data, file = "Book.csv",,row.names=FALSE)
read.csv("Book.csv")

mydata<-read.csv("Book.csv")
mydata
nrow(mydata)
ncol(mydata)

head(mydata,n=5)
tail(mydata,n=2)

tail(head(mydata,n=5),n=2)

data[4,4]
data[4,4]<-8.9

maximum<-max(data$Petal.Length)
maximum

ret<-subset(data,Species=="setosa")
ret


install.packages("xlsx")
