# clean up
rm(list=ls())

# ----------------------------- USER DEFINED FUNCTIONS --------------------------------

# ---------------------------------- INIT function ----------------------------------
# Function call : INIT()  
# Returns : A standard deck
INIT<-function(){
  # Objective : Initilise a standard deck 
  # Parameters : None
  # Return value : Return a standard deck
  # 
  suit<-rep(c("Clubs","Diamonds","Hearts","Spades"),each=13)
  rank<-rep(c(11,2:10,10,10,10),4)
  name<- paste(rep(c("Ace",2:10,"Jack","Queen","King"),4),"of",suit)
  deck<-data.frame(suit,name,rank,stringsAsFactors=FALSE)
  
  return(deck)
}


# ----------------------------------SHUFFLE function--------------------------------
# Function call : SHUFFLE(deck)
# Returns : SHUFFLED deck
SHUFFLE<- function(deck){
  # Objective : To Shuffle the deck
  # Parameters : 
  #   Original deck - A original deck, with any configuration
  # Return value : The shuffled deck
  # 
  random_vector<-sample(1:52)
  new_deck<-deck
  j<-1
  for( i in random_vector){
    new_deck[j,]<-deck[i,]
    j<-j+1
  }
  return(new_deck)
}


# ---------------------------------- DEAL function ----------------------------------
# Function call : DEAL()
# Returns : Top card 
# WARNING : IT MODIFIES THE GLOBAL DECK
DEAL<- function(){
  # Objective : Accept the deal, return the top card and increments IndexOfTop
  # parameters : None, works on the global deck
  # Return Value : Return the top card from the deck, deck now has one less card
  # 
  
  top_card<-deck[1,]
  
  # Global modifications
  deck<<-deck[-1,]
  
  return(top_card)
}



# ---------------------------------- GET_PROB function ----------------------------------
# Function call : GET_PROB(deck,your_Score)
# Returns : The probabililty of getting a score of 21, based on current cards.
GET_PROB<- function(deck,your_score){
  req_card= 21 - your_score
  total_outcomes<-length(deck[,"rank"])
  
  # At most 21, simple approaching
  favourable_outcomes<-length(deck[which(deck$rank<=req_card),"rank"])
  if(your_score>10){
    # If score is more than 10, aces needs to counted separately
    favourable_outcomes<- favourable_outcomes + length(deck[which(deck$rank==11),"rank"])
  }
  
  # Exactly 21
  # favourable_outcomes<-length(deck[which(deck$rank==req_card),"rank"])
  # if(your_score==20){
  #   # If score is more than 10, aces needs to counted separately
  #   favourable_outcomes<- favourable_outcomes + length(deck[which(deck$rank==11),"rank"])
  # }
  # 
  
  req_prob<-(favourable_outcomes/total_outcomes)
}


# ---------------------------------- TwentyOne function ----------------------------------
# Function call : TwentyOne()
# WARNING : MAKES AND  MODIFIES THE GLOBAL DECK
# OBJECTIVE : PLAYS ONE GAME OF TWENTY ONE
TwentyOne<- function(){
  # Objective : Plays the game 21
  
  cat("\nLETS PLAY 21\n\n")
  
  # Initialize a standard deck
  standard_deck<-INIT()
  cat("\nSHUFFLING CARDS . . .\n\n")
  # Shuffle the deck
  deck<<-SHUFFLE(standard_deck)
  # GLOBAL DECK MADE.
  
  cat("\nYOUR TURN\n")
  # Simulate the player Turn of the Game 21
  
  your_score<-0
  
  top<-DEAL()
  your_score<-  your_score + top$rank
  cat(top$name,"\t", your_score,"\n")
  
  choice<- "HIT"
  
  while(choice=="HIT"){
    
    top<-DEAL()
    
    if(top$rank==11 && (your_score + top$rank) > 21){
      top$rank=1
    }
    your_score<-  your_score + top$rank
    cat(top$name,"\t", your_score)
    
    if(your_score>21){
      break
    }
    
    # get probabilty of getting 21 based on current cards
    Prob_TwentyOne<-GET_PROB(deck,your_score)
    cat("\n\nProbability of getting 21 is : ",Prob_TwentyOne)
    
    
    if(Prob_TwentyOne==0){
      if(your_score<11){
        cat("\nYou should go for a HIT !!")
      }
      else{
        cat("\nYou should STAY !!")
      }
    }
    else if(Prob_TwentyOne>0.5){
      cat("\nYou should go for a HIT !!")
    }
    else{
      cat("\nYou should STAY !!")
    }
    
    # Get user's choice
    choice<-toupper(readline(prompt="HIT or STAY ? "))
    while( !(choice == "HIT" || choice == "STAY") ){
      cat("Un-recognized Input. Please Retry !!")
      choice<-toupper(readline(prompt="HIT or STAY ? "))
    }
    cat("\n")
  }
  
  
  # IF Over 21, other party wins
  if(your_score > 21){
    cat("\nYOU LOSE !\n")
    return()
  }
  
  
  
  
  cat("\nCOMPUTER'S TURN\n")
  # Simulate the Computer Turn of the Game 21
  comp_score<-0
  
  top<-DEAL()
  if(top$rank==11 && (comp_score + top$rank) > 21){
    top$rank=1
  }
  
  comp_score<-  comp_score + top$rank
  cat(top$name,"\t", comp_score,"\n")
  
  choice<- "HIT"
  
  while(choice=="HIT"){
    
    top<-DEAL()
    comp_score<-  comp_score + top$rank
    cat(top$name,"\t", comp_score)
    
    if(comp_score>21){
      if(top$rank==11){
        comp_score<-comp_score-10
      }
      else{
        break
      }
    }
    
    if(comp_score>17){
      break
    }
    
    cat("\n")
  }
  
  
  # IF Over 21, other party wins 
  if(comp_score > 21){
    cat("\n\nYOU WIN !\n")
    return()
  }
  
  
  cat("\n\nYOUR SCORE: ",your_score)
  cat("\nCOMPUTER'S SCORE: ",comp_score)
  cat("\n")
  if(your_score > comp_score){
    cat("\nYOU WIN !\n")
    return()
  }
  
  if(your_score <= comp_score){
    cat("\nYOU LOSE !\n")
    return()
  }
  
}


# ---------------------------------- PLAY function ----------------------------------
# Function call : PLAY()
# OBJECTIVE : PLAYS THE ENTIRE GAME TWENTY ONE
PLAY<- function(){
  
  # Objective : Let the user play the game
  
  playmore="Y"
  while(playmore=="Y"){
    TwentyOne()
    playmore<-toupper(readline(prompt="PLAY AGAIN? (Y/N) "))
    while( !(playmore == "Y" || playmore == "N") ){
      cat("Un-recognized Input. Please Retry !!")
      playmore<-toupper(readline(prompt="PLAY AGAIN? (Y/N) "))
    }
    cat("\n")
  }
}


PLAY()
