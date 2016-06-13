Fibonacci Heaps
---------------

*Lectures 14-15*

*Binomial heaps will soon be obselete*

* Terible Actual Complexity
	* O(n) remove min
	* O(n) remove
	* O(n) decrease key
	* ( O(1) insert and meld )
* Good Amortized complexity
	* O(log(n)) remove min
	* O(log(n)) remove
	* O(1) decresed key
* Proof for these complexities is in another Power Point

###Min Fibonacci Heap###

* Collection of min trees
* Minimum size of the n'th min tree is the n'th fibonacci number
* Like a Binomial Heap, each node points to its next child
* *Unlike* a Binomial Heap:
	* each node points to its previous child (children are in a doubl linked list)
	* each node points to its parent
	* each node stores a "child cut": whether it has lost a child since it became a child of this parent
* Like a Binomial Heap:
	* Insert adds a one node tree
		* When a node is made a child, set it's ChildCut to False
	* Meld combines two top level lists
	* Remove min requires pairwise combining of euqal degree trees
* *Unlike* a Binomial Heap:
	* Remove(Node n):
		* Take it out of tree ( O(1) )
			* This is possible because of the parent pointer
		* Merge it's children ( O(1) )
			* This is O(1) because a doubley linked list is used
		* Nullify pointers to old node ( O(Node Degree) )
		* Perform a Cascading Cut
	* DecreaseKey(Node n, Amount m):
		* Compare new value to parent
		* If n is smaller, remove n and re-add it as a new top level tree
		* Perform a Cascading Cut:
	* Cascading Cut (Decrease Key has removed a child)		
		* If ChildCut of the parent is false:
			* set ChildCut to True
		* else:
			* Move the parent node to the top level
			* Perform a Cascading Cut on the parent node's old parent
		* This adds work proportional to the size of the tree, making Remove and DecreseKey O(n)

###Example: Djikstra's Algorithm###

*In a network, find shortest path from one node to another *

* Assign a distance to each node (initial value = infinity)
* Consider the starting node "visited", with a distance value of 0
* As long as the destination node is unvisited, do the following:
	* For each unvisited node connected to the newly visited node, 
		* Sum the visited node's distance and the length of the connecting edge
		* If this sum less than the connected node's distance, make it is the connected node's new distance
	* Find the unvisited node with the lowest distance, and visit it
* The edges used to assign the shortest paths to each node leading up to the destination form the shortest path

Let:

* *n* represent the number of nodes
* *e* represent the number of edges
	* depending on the graph, *e* may be between $n$ and $n^2$

Djikstra's Algorithm requires a data structure for distance values with:

* **RemoveBest()** to remove from the unvisited set (done O(n) times)
* **Decrese()** to decrese the distance values connected to a visited node (done O(e) times)

Overall complexity of these operations for various data structures:

* **Array:** $O(n^2)$
* **Min Heap:** $O(n\log(n)+e\log(n))$
* **Fibonacci Heap:** $O(n\log(n) + e)$

Pairing Heaps
-------------

*Worse complexity than fibonacci heap, but better average run time (and easier to program)*

O(log(n)) time for:

* Insert
* Remove best
* Meld
* Remove
* Decrease key

Unlike a fibonacci/binomial heap, this structure has only a single top node.

Each node stores:

* First Child
* Left/Right siblings
	* Children form a doubly linked list, but it is not circular
	* Left pointer of first node is parent
* Data

Operations:

* Meld:
	* Tree with worse root becomes leftmost subtree of other tree
* Insert:
	* Create a 1 element pairing heap, then meld
* Improve Key:
	* Increase, then move yourself out of the tree and meld
	* If key belonged to a left most node, don't forget to change the parent pointer
* Remove Best:
	* Remove the top node
	* Meld all sub-trees
	* Bad Way (gives O(n) complexity):
		* Don't use the meld operation on the first sub-tree with every other sub-tree, or you can get a flat/tall subtree
	* Good Ways (give O(log(n)) complexity):
		* Two Pass
			* First Pass: pair up the subtrees and meld the pairs
			* Second Pass: meld the last most subtree with every other subtree, goint from last to first
			* The second pass is basically the bad way, but backwards
		* Miltipass
			* pair up the subtrees, meld the pairs, and repeat until there is only one tree
* Remove Nonroot
	* Remove node
	* Meld it's children with root (using either Two Pass or Multipass, as in Remove Best)
