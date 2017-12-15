Q1. A Tower of Hanoi setup consists of N disks, weighing 1,…, N kilos. 
Each disk sits in one of M stacks, at positions 0,1,2,M−1. 

All disks start stacked at position zero, ordered by weight with
the lightest on top. At each point in time, a valid move can be made. A valid move consists of
taking the top disk off of one of the stacks and moving it to the top of the stack to the immediate
left or right (that is, at position one less or one greater than its current position), provided that themoved disk weighs less than all other disks at its destination stack. 

For example, in a N=M=3
problem with disks 1,2,3 at positions 0,1,2, respectively, the only valid moves are for disk 1 to
move to position 1 and disk 2 to move to position 2. We choose moves uniformly at random
amongst all valid moves at a given time. 

I am interested in the position of the center of mass after
T moves, that is
∑d×pd / ∑d

Where, d is the disk weight and pd is the position of a disk weighing d.

(a) For M=3, N=3, what is the mean of the center of mass after T=16?

(b) For M=3, N=3, what is the standard deviation of the center of mass after T=16?

(c) For M=6, N=6, what is the mean of the center of mass after T=256?

(d) For M=6, N=6, what is the standard deviation of the center of mass after T=256?