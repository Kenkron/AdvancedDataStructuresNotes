Double Ended Priority Queue
===========================

*Lecture 9-10*

*Double ended priority queues are required for the external quicksort*

Correspondence Structures
-------------------------

###Dual Single-Ended Priority Queue###

* Start with two heaps (or single ended priority queue structures)
	* Must support a remove operation
* Put all elements in both heaps
	* Make one a max heap, the other a min heap
	* Each node in one tree must point to the corresponding node in the other tree
* Operation cost is more than double a single heap
* Space requires 2n nodes

###Total Correspondence###

* Start with two heaps (a min, and a max)
	* Heaps (or queues) must support a remove operation
	* Put half the elements in one heap, and half in another
	* Each node must point to a node in the other tree *such that* the node in the min tree <= the node in the max tree
	* Any left over node (if there are an odd number of elements) is put into the buffer
* During remove
	* Compare buffer to corresponding tree.
	* If the buffer wins, use that
	* Otherwise, take from the appropriate tree
	* put the corresponding node from the other tree onto the buffer
	* If there are now two nodes in the buffer, Insert the larger into the max tree, and the lesser into the min tree
	* Make the inserted nodes point to each other
	* *Note: the buffer only ever contains at most one element, since a second element calls for a pair of insertions.*
* The remove function runs in logarithmic time

###Leaf Correspondence###

* Like total correspondence, but only the leafs point to other nodes
	* The other nodes do not need to be leaves
	* The pointer is not bi-directional
	* This still works because the leafs of a min tree >= parents, and their corresponding leaves >= leafs of min tree
	* Same applies the other way
* Additional Constraints:
	* When an element is deleted, only the parent of that element can become a new leaf
	* Min & Max heaps do not satisfy this
	* During re-insertion from the buffer, insert the min, but only insert the max if the min is an external node
	* If another node becomes external, it must be matched to a corresponding element
		* It would be nice if the underlying queue could prevent nodes from becoming leafs in an insert
		* This is not the case

**There must be a way to pair newly external nodes if internal nodes become external**

Interval Heaps
--------------

* Each node has two elements (except possibly the last one)
* The range of each node contains the range of its children
* This is basically a total correspondence tree with only one tree
* For insertion with a node with only one element, try inserting there
	* If this violates the min heap/max heap, swap it with its parent until it doesn't 
	* This takes log(n) time
* For min/max removal, take the min/max from the last node, use it to replace the popped node at the top, then propagate down.
	* Complexity is still log n
	* After root, check against other element in node to ensure min/max
* There is an n time initialization operation
	* Fill the tree immediately
	* Swap if min/max are backwards
	* Fix local violations of containment property
	* Do this bottom up
* Removal (not covered yet) is log(n)
* These can conveniently find elements outside a range

###Cache Optimization in Array-based Binary Tree###

* Uniformly distributed keys
* Insert *bubbles* avg. 1.6 levels up the tree
	* Doesn't need as much optimization
* Remove propagates avg. height-1 levels down the tree
	* Higher order trees have fewer cache misses
	* Children are lined up in memory, so they don't incur as many cache misses
	* More children means fewer levels
	* Number of comparisons stays the same

