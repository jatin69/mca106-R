m<-matrix(1:9,nrow=3,ncol=3)
m
for(j in 1:nrow(m)){
		if(j==1){
			 r<-m[,j] 
		}
		else{
		r<-rbind(r,m[,j])
		}
	}
r
