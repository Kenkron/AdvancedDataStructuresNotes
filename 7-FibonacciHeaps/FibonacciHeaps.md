Fibonacci Heaps
===============

*Lectures 14-*

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

Min Fibonacci Heap
------------------

* Collection of min trees
* Minimum size of the n'th min tree is the n'th fibonacci number
* Like a Binomial Heap, each node points to its next child
* *unlike* a Binomial Heap:
	* each node points to its previous child (children are in a doubl linked list)
	* each node points to its parent
	* each node stores a "child cut": whether it has lost a child since it became a child of this parent



Djikstra's Algorithm
--------------------

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

* **RemoveMin()** to remove from the unvisited set (done O(n) times)
* **Decrese()** to decrese the distance values connected to a visited node (done O(e) times)

Overall complexity of these operations for various data structures:

* **Array:** $O(n^2)$
* **Min Heap:** $O(n\log(n)+e\log(n))$
* **Fibonacci Heap:** $O(n\log(n) + e)$

