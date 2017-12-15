Problem statement :
You are going to create a simple card game of 21. In this game, the single player has to try to come
as close to a score of 21 without going over and beat the computer's score

Solution:




User Defined Functions used :

PLAY()
Plays one game of 21, then asks user if he wants to play again

TwentyOne()
Simulates one game of 21

INIT()
Initialises a global standard deck of 52 cards

SHUFFLE()
Shuffles the standard deck, to generate shuffled deck

DEAL()
pops out the top card from the deck. 

GET_PROB()
calculates the probabilty of being safe, less than equal to 21 for the next card.



Inbuilt Functions used :

sample()
sample takes a sample of the specified size from the elements of x using either with or without replacement.

readline()
To read user input

data.frame()
To bind different vectors together and create a data frame.

<<- operator
to make changes to global variables



Data Structure used :

I wanted something simple to hold the deck of 52 card, with unique rank, name, suit
as, intuitively, rank is numeric but all others were charcacters. So a simple matrix couldn't 
get the job done.

As per the resource,
University of Auckland, New zealand
https://www.stat.auckland.ac.nz/~paul/ItDT/HTML/node64.html

A Data frame is an appropriate structure when we need to store different data types together, 
and with same rows.


Building Logic :

User calls PLAY() to play the game. PLAY() calls TwentyOne() and plays a game.
TwentyOne() simulates user turn and computer turn.
Probability guided hint is given to user to choose between HIT and STAY.


Probability guided hint :
We can use the below to approaches.

1. Probability of getting exactly 21
This is the probability that the next card draw will take us to exactly 21

2. Probability of getting atmost 21,
This is basically the probability of drawing out a safe card.

Our program uses the second approach.


