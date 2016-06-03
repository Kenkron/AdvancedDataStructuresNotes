Tournament Trees
================

*Lecture 5-6*

*This is required for a log(n) comparison for Mergesort*

~~~
               Internal Node
                 /       \
                /         \
        Internal Node    External Node
           /       \
          /         \
External Node      External Node
~~~

| **Internal Nodes**: Represent Competitions
| **External Nodes**: Represent Contestants

Winner Tree
-----------

* Go through tree "Bottom Up" (Starting at the outer most Internal Nodes)
* For each Internal Node, mark it with it's best child (the winner)
* Since the tree is fixed and binary, it can be represented as an array
	* Double the index to move to first child
	* Half the index to move to parent

The first tournament takes up to `n-1` time, *but* when the old winner is removed, replaying it's matches only takes `log(n)` time. This is because only the winner's internal nodes must be updated.

Loser Tree
----------

*Prevents the need to look up siblings during replays*

* Like a winner tree, *but* instead of storing the winner at each internal node, store the loser
	* Structure of the tree is the same
	* Winner is still passed up the tree, it's just not stored in the node
* Because both the loser and left winner must be stored, it takes up to `2(n-1)` time
	* The 2 appears because the loser is stored, but the winner still needs to be passed up the tree
* During the replay, the old winner must play against the old loser
	* If the old loser wins, write the old winner and pass the new loser up
	* If the old winner wins, write the old loser and pass the new winner up
* The complexity of a replay is the same, but because there is no overhead for sibling lookup, it is faster by a constant

###Uses of Loser Tree:###

* Run Generation (~2x memory capacity)
* Run Merging (in Mergesort)
* Truck Loading (A.K.A: Bin Packing)

Truck Loading (A.K.A: Bin Packing)
----------------------------------

* There are `n` packages
* Each package has a weight
* Each truck (or bin) has a capacity of `c` tons
* Minimize the number of trucks(/bins) needed to deliver the packages

**This problem is NP-hard**

* NP-hard means there is no known solution that can be found in polynomial time 
* NP-hard problems are impractical to solve, except for *very* simple cases
* A polynomial time approximation is usually preferred

###Non-NP approximations###

* First Fit ($\leq\dfrac{17}{10} \times optimal + 2$):
	* Bins are ordered
	* Items are packed one at a time in given order
	* Items are packed into the first bin in which they fit
* First Fit Decreasing ($\leq\dfrac29 \times optimal + 4$):
	* Items are sorted in decreasing order
	* Then packed using first fit
* Best Fit ($\leq\dfrac{17}{10} \times optimal + 2$):
	* Pack each item is packed into the lowest capacity bin that can still fit the item
* Best Fit Decreasing ($\leq\dfrac29 \times optimal + 4$):
	* Items are sorted in decreasing order
	* Then packed using best fit

###Winner-Tree for First Fit###

* External Nodes: the remaining capacity of a bin
* Internal Nodes: the leftmost child with enough capacity is the winner

Merge Sort Run Generation
-------------------------

* Create two buffers for input, and two for output
	* While one is in use, fill the other one
* Simultaneously:
	* Write the previously filled output buffer to disk
	* Read the next input buffer from disk
	* Use Loser Tree to move a run from the current input buffer to the current output buffer
* During Loser Tree generation:
	* Fill the External Nodes with entries from the previous input buffer
		* Give each entry a run number of 1
	* Output the winning entry the the current output
		* Only entries with the current run number may win
	* Enter the next entry from the current input
		* If this entry is smaller than the last winner, it can't be part of the current run.  Assign it a run number equal to current run + 1.
	* Once there are no more records in the tree for the current run, move to the next run
	* Run size is always at least the size of the loser tree
	* It has been shown that the average run size is twice th size of the tree
	* Because four blocks are used for I/O, there should be at least 8 blocks of memory available (in addition to program/variable space) in order to produce a run that is longer (on average) than memory can hold.
* Merging trees of the same size is more efficient than merging trees of different sizes, but this method creates different sized runs.
	* In order for this to be efficient, the cost of switching runs to same disks must be smaller than the efficiency of a better merge pattern.

**A Huffman Tree can provide an efficient pairing scheme for merging**
