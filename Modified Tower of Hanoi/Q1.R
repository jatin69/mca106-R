# memory cleanup
rm(list=ls())

## Function start here
######

# IMPORTANT NOTE : as per question stacks are 0,1,2 . But logical stacks are 1,2,3

# Function to initialise TOH Stacks and disks
initialize_toh <- function(n,m){
  my_toh<-matrix( data=as.numeric(0), nrow = n, ncol = m )
  rownames(my_toh) <- c(1:n)
  colnames(my_toh) <- c(0:(m-1))
  #my_toh[,1]<-c(rep(1, each=n))
  my_toh[,1]<-c(1:n)
  return(my_toh)
}

# Function for the operations after movement of a disk, i.e. one step
mean_com_of_step_T<- function(my_toh){
  # IMPORTANT NOTE : as per question stacks are 0,1,2 . But logical stacks are 1,2,3
  
  # COM of step T= 1,2,3...
  # OBJECTIVE : This functionmean_com_of_step_T  reads the stacks, return mean(com) for that move 'T' 
  # which is then appended to to a global list T, which can be used for mean and sd at last
  # Requirements ?? my matrix with updated disk values
  
  #cat("ok")
  # disk weight and position of disk
  
  # center of mass for that T step 
  com<- numeric(0)
  i=1
  
  # calculating center of mass of each Stack 
  for(i in 1:n){
    
    # finding disk in single stack
    disks_in_stack<-my_toh[,i]
    
    j=1
    sigma_d_into_pd=0
    sigma_d=0
    for( j in 1:n){
      sigma_d_into_pd = sigma_d_into_pd + disks_in_stack[j]*(i-1)
      sigma_d= sigma_d + disks_in_stack[j]
    }
    com_of_i_stack=0
    if(sigma_d>0 && sigma_d_into_pd>0){  
      com_of_i_stack<-sigma_d_into_pd/sigma_d
    }
    com<-append(com,com_of_i_stack)
  }
  mean(com)
}

######
# functions end here
#source("myfunctions.R", local = TRUE)


### START ####

# No of disks and stack

n=3; m=3 ; T_by_user=16
#n=6; m=6; T_by_user=256


# Initializing stack and disks
my_toh<-initialize_toh(n,m)
# Global com list, final mean and sd operation will be performed on this
com_list<- numeric(0)

state_list<-list(my_toh)

# Focus on indexing
# below 2 are equivalent here
# my_toh[,1]
# my_toh[,"0"]

p_source=-1
p_dest=-1
p_disk=-1

step=0
repeat{
  
  # generates one move and breaks, so that com can be calculated for that step
  i=1
  
  # stack by stack propagation of the loop
  for(i in 1:n){
    right_possible=FALSE
    left_possible=FALSE
    
    # finding first non-zero entry in the stack column , i.e. top of the stack 
    current_stack_disk<- my_toh[head(which( my_toh[,i]>0),1) ,i]
    
    # if current stack is empty, move to next stack immediately
    if(length(current_stack_disk)== 0){
      next
    }
    
    # check right side
    if(i+1<=n){
      # finding first non-zero entry in the stack column , i.e. top of the stack 
      right_stack_disk<- as.numeric(my_toh[head(which( my_toh[,(i+1)]>0),1) ,(i+1)])
      
      if(length(right_stack_disk)== 0){
        right_stack_disk=Inf
      }
      if(current_stack_disk< right_stack_disk){
        right_possible=TRUE
        source=i
        dest=i+1
        disk=current_stack_disk
        #cat("Current move  :    Disk ",disk," from source : ",source," to dest : ",dest,"\n")
        #cat("Previous move : ","Disk",p_disk,"from source : ",p_source," to dest : ",p_dest,"\n")
        
        if(disk==p_disk && dest==p_source && source==p_dest){
            right_possible=FALSE
          # cat("culprit right \n")
          # cat("Current move  :    Disk ",disk," from source : ",source," to dest : ",dest,"\n")
          # cat("Previous move : ","Disk",p_disk,"from source : ",p_source," to dest : ",p_dest,"\n")
        
        }
      }
    }
    
    # check left side
    if(i-1 > 0){
      # finding first non-zero entry in the stack column , i.e. top of the stack 
      left_stack_disk<- my_toh[head(which( my_toh[,(i-1)]>0),1) ,(i-1)]
      
      if(length(left_stack_disk)== 0){
        left_stack_disk=Inf
      }
      if(current_stack_disk<left_stack_disk){
        left_possible=TRUE
        source=i
        dest=i-1
        disk=current_stack_disk
        #cat("Current move  :    Disk ",disk," from source : ",source," to dest : ",dest,"\n")
        #cat("Previous move : ","Disk",p_disk,"from source : ",p_source," to dest : ",p_dest,"\n")
        
        
        if(disk==p_disk && dest==p_source && source==p_dest){
          left_possible=FALSE
         # cat("culprit left \n")
          #cat("Current move  :    Disk ",disk," from source : ",source," to dest : ",dest,"\n")
          #cat("Previous move : ","Disk",p_disk,"from source : ",p_source," to dest : ",p_dest,"\n")
          
        }
        
      }
    }
    #cat("\n\n\n")
    
    # IF BOTH SIDES POSSIBLE, choose right move, as my wish
    if(right_possible && left_possible){
      # choose randomly & move
      # move right
      source=i
      dest=i+1
      disk=current_stack_disk
      break
    }
    else if(right_possible && !left_possible){
      # move right
      source=i
      dest=i+1
      disk=current_stack_disk
      break
    }
    else if(left_possible && !right_possible){
      # move left
      source=i
      dest=i-1
      disk=current_stack_disk
      break
    }
  }
  
  # save these values for comparison with next iteration
  p_source=source
  p_dest=dest
  p_disk=disk
  
  # Moving the actual disk
  my_toh[disk,dest]<-my_toh[disk,source]
  my_toh[disk, source]<-0

  # calculating mean_com of step T, updated value of toh- my passed
  com_of_step_T<-mean_com_of_step_T(my_toh)
  com_of_step_T
  step=step+1
  
  state_list[[step+1]]<-my_toh
  
  # com_list
  # appending mean_com of step T to global com
  com_list <- append(com_list, com_of_step_T)
  
  if(step==T_by_user){
    break
  }
  
}


# displays all states
#state_list

# mean and SD of com after steps T=16
sprintf("Mean of the center of mass is : %.10f",mean(com_list))
sprintf("SD of the center of mass is   : %.10f",sd(com_list))


# cleanup
rm(com_list,com_of_step_T,current_stack_disk,dest,disk,i,left_possible,left_stack_disk,p_dest,p_disk)
rm(p_source,right_possible,right_stack_disk,source)


