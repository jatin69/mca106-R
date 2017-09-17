n<-3
n
M<-matrix(,nrow=n,ncol=n)

num<-1
i<-1
j<-1
init<-1
stop<-n
while(stop>0 ) {

i<-init
j<-init


if(i==init && j==init){
	while(j<n)
	{
		M[i,j]<-num
		num<-num+1
		j<-j+1
	}
	M[i,j]<-num
	num<-num+1	
}
num<-num-1

if(i==init && j==n){
	while(i<n)
	{
		M[i,j]<-num
		num<-num+1
		i<-i+1
	}
	M[i,j]<-num
	num<-num+1		
}
num<-num-1

if(i==n && j==n){
	while(j>init)
	{
		M[i,j]<-num
		num<-num+1
		j<-j-1
	}
	M[i,j]<-num
	num<-num+1	
}
num<-num-1

if(i==n && j==init){
	while(i>init)
	{
		M[i,j]<-num
		num<-num+1
		i<-i-1
	}
	
}


init<-init+1
n<-n-1
stop<-stop-2
}

M
