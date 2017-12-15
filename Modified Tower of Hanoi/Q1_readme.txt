problem staement:
------------------

There are N disks (1,2..n) and M stacks (0,1,2,.. m-1), initially all disks are at stack 0 .
Our AIM is to perform T valid moves on the tower of hanoi.

A valid move is defined as, disks can only be moved to adjacent disks, the stack should have disks
in ascending order and must maintain that order even after a valid move.

Assumption added to valid move : step T and step T+1 should not be reverse of each other


Variables used :
------------
 
N disks
M stacks
T moves

disk   : The disk which is to be moved
source : Source stack, from where the disk needs to be moved
dest   : Destination stack, to where the disk is to be moved.

left_possible : Tells whether a move to the left stack is possible
right_possible : Tells whether a move to the right stack is possible

current_stack_disk : Tells the top of the stack disk for current stack
left_stack_disk    : Tells the top of the stack disk for left stack
right_stack_disk   : Tells the top of the stack disk for right stack


com_of_step_T : stores the mean center of mass for that particular step
com_list : The list which hold Center of Mass of all moves T=1,2,..
State_list : Holds the TOH state after each step, can be used for debugging purposes.


Functions used : 

sprintf : To display the result with precision

Function - initialize_toh 
Objective : Dynamically allocates a matrix for stacks and disks, and places all disks on stack 0

Function - mean_com_of_step_T : 
Objective : Calculates the center of mass after one move. 
approach : Finds the number of disks in stack and calculates sigma_d and sigma_d_into_pd and calculates mean of center of mass of all stacks of that move
return value : mean of the center of mass of that step

Data structure used: 
A matrix, where rows represent disks, and columns represent the stacks.
Each disk number represents the weight of the list

	0 1 2
1   1 0 0
2   2 0 0
3   3 0 0

Initially , all 3 disks are placed in stack 0

Let's assume we perform a move : Move disk 1 from stack 0 to stack 1
So the matrix becomes

	0 1 2
1   0 1 0
2   2 0 0
3   3 0 0


Problem Solving approach :

Brute Force:-

we run a loop which traverses each stack one by one starting from stack 0
Within this loop:
				 We find the top of this stack - we will try to move this disk
				 if the stack is empty we directly move on to the next stack i.e., next iteration of the for loop
				 So, we check if it is possible to move disk to the left stack or to the right stack in a VALID move
				 To do this:
							we find the top of stack for left and right stack, then we compare it with the current disk to be moved
							If the current disk is smaller than the disk is already in the left or right stack. it is a valid mpove
							Also, if the right or left stack is empty we are free to move i.e., it is a valid move
							But as per our assumption of valid move we need to check if
							The next move we are about to perform is the reverse of the previous move
							If any of the probable left or the right move violates our assumption we invalidate it
							Then, we perform a valid move from the set of possible left right moves and update the matrix accordingly
							then we call the function mean_com_of_step_T to calculate mean center of mass for that step then we append that value to global com_list for later processing
		
challenges faced:
			Finding a data structure to aptly represent the tower of hanoi's stacks and disk
			Efficient movement of stack to another
			Storing the state after a move, then reading it out to calculate the center of mass
			Developing a logic for movement of disk with a valid move
			In our method, we use brute force algorithmic approach

Test cases

		M=3 , N=3 and T=16
		M=6, N=6 and T=256


Assumption in the approach :
If many valid moves are available, Our approach chooses the move
which occurs at the lower most stack.
That is, if valid moves are available at stack 0,1,2,3,4
We always choose valid move at stack 0

Similarly, from all valid moves at that particular stack, we always choose to move to the right-side stack.

Further possibility of the approach :
In case of 6x6, we have multiple valid moves,
we can also create a list of all those moves and then choose randomly among all possible 
valid moves. ( unlike now, where lower most stack is chosen)

 
		