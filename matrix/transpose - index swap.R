/* iris data set */
M1<-iris[1:nrow(iris),1:ncol(iris)-1]
M1

/* user defined matrix */
M1<-matrix(1:49,nrow=7,ncol=7)
M1

/* Transpose code  */
M3<-matrix(, nrow = ncol(M1), ncol = nrow(M1))
for (i in 1:nrow(M1)){
   for (j in 1:ncol(M1)){
       M3[j,i] <- M1[i,j]
     }   
}
/* Displaying result */
M3
