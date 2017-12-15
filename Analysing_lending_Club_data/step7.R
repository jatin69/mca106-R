# Let's find a loan purpose that shows up abnormally often in one state. Call A the probability
# of a loan going to a specific purpose nationwide. Call B the probability of a loan going to
# a specific purpose for each state. Out of all (state, purpose) pairs with at least 10 loans,
# what is the highest ratio of B / A (i.e. the most surprising)?


library(plyr)

# 
# AIM 1 : Calculate probability of a loan going to Delhi, for car purpose
# TODO : we need to find how many loans went to delhi and for what purpose did they go,
# so we find a matrix with state-purpose-countofloan data

# create state purpose pairs
state_purpose_pairs <- ddply(mydata, .(mydata$addr_state, mydata$purpose), nrow)
names(state_purpose_pairs) <- c("State", "Purpose", "Count")
req_pairs<-state_purpose_pairs[which(state_purpose_pairs$Count>=10),]
#req_pairs

# FINDING PROBABILITY OF ALL CAR LOANS IN DELHI STATE

# created a matrix for totals of each state
State_Sum<- (aggregate(req_pairs$Count, by=list(State=req_pairs$State), FUN=sum))
# tweaking it so, col names can be accessed and count of state can be obtained
state_matrix<-t(as.matrix(State_Sum[,"x"]))
colnames(state_matrix)<-c(State_Sum[,"State"])

# find prob of all state purpose pairs - That is prob B - as per question
state_prob<-(req_pairs$Count)/(state_matrix[,c(as.character(req_pairs$State))])


#
# AIM 1 : Calculate the probability of a loan going for CAR purpose, in all over INDIA
# TODO: we need to find how many car loans were issued in INDIA, then find prob. of car loan issuing among all the purposes

# This will give us the total car loans in INDIA 
nation_fav_outcomes<-summary(factor(mydata$purpose))
# This will give us the total loans in INDIA
nation_total_outcomes<-sum(summary(nation_fav_outcomes))
# making tweaks for accessing and manipulation
nation_matrix<-t(as.matrix(nation_fav_outcomes/nation_total_outcomes))

# Nation prob- A , as per question
nation_prob<-as.matrix(nation_matrix[1,as.character(req_pairs$Purpose)])


# Calculation prob ration B/A
prob_ratio<-(state_prob/nation_prob)


#### MERGING A and B with original state purpose pairs for easy user view

final_data <- cbind(req_pairs,state_prob,nation_prob, prob_ratio )

# finding the abnormality column based on ratio value
abnormal<-final_data[which( final_data$prob_ratio == max(final_data$prob_ratio)),]

# Storing the abnormal ratio
abnormal_ratio <- abnormal[,"prob_ratio"]

sprintf("Abnormal Ratio is %.10f",abnormal_ratio)


#cleanup
rm(abnormal_ratio,abnormal,final_data,nation_matrix,nation_prob,prob_ratio,req_pairs,state_matrix,state_purpose_pairs,State_Sum,nation_fav_outcomes,nation_total_outcomes,state_prob)
