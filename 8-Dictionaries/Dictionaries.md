Dictionaries
============
------------

*Lecture 16-17*

*A collection of data organized by keys*

**Dictionary With Duplicates:** Different values may have the same keys (this is not a "pure" dictionary, but may be modeled by a "pure" dictionary)

**Static Dictionary:** Does not change once created

**Dynamic Dictionary:** Can change once created

Operations:

Static Operations (Required for all Dictionaries, even ones that don't change):

* Initialize
* get(key)

Dynamic Operations (Required when the Dictionary can change)

* put(key, element)
* remove(key)

###Note: Hash Tables will usually be the best data structure.###

* Expected time for get, put, and remove are all O(1).
* Worst time depends on overflow handling
	* Any other dictionary structure can be used for overflow handling
	* (e.g. balanced search trees)
* Thus, the worst-case time complexity for a Hash Table is no worse than any other data structure, but expected time is constant

**However, some operations are not supported by hash tables**

* Not suitable for nearest match queries
	* Find the element *closest* to the given key
* Not suitable for range queries
	* Find the elements between two given keys
* Not suitable for indexed operations
	* Find the n'th smallest key

###Recall the [Bin Packing](#bin_packing) problem from Lectures 5-6 on Tournament Trees###

Best Fit Method:

* Items are packed in given order
* Pack each item into the bin with the least available space, but enough space to fit the item
* If no bin can fit the item, add a new bin

Binary Search Tree
------------------

*Hopefully, this data structure is familiar*

* Left child of each node $<$ node
* Right child of each node $\geq$ node

Using a balanced Binary Search Tree, use the available capacity as the key, and the bin index as the value. Finding the smallest bin with enough space takes log(n) time, and re-adding this bin with it's new remaining space also takes log(n) time.  Because this is done for n Items, *the complexity of the Best Fit method with a balanced Binary Search Tree is $O(n \log(n))$*.

Indexed Binary Search Tree
--------------------------

*A Binary Search tree that stores the number of nodes in its left sub-tree*

The number of nodes to the left of the given node must be the rank of the node *within it's own subtree*. Similarly, the rank of a child to the left (relative to its parent) will euqal its S value (relative to its parent). Because the nodes to the left of the right child come between the parent and the child, the rank of a child to the right must be the child's value, plus its parent's rank, plus 1 (for moving up from the parent). In summary:

Let S be the number of nodes on the left branch of a tree:

* **Root:** Rank must be its S value
* **Left Child:** Rank(parent) + S - parent.S 
	* Because: Rank - Rank(parent) = S - parent.S
* **Right Child:** Rank must be S + Rank(parent) + 1

Using this, you can navigate down a tree towards any desired index in O(log(n)) time. Also, insertion and deletion only affect their parent node, giving them O(log(n)) complexity as well.

Static Dictionaries
-------------------

**Failure Node:** The null node between two successive keys. Reached when a search is made for an element that is not in the tree.

If you know how often each thing will be searched for, you can skew trees to optimize for better performance (recall [Huffman Trees](#huffman-trees)). This can account for both Nodes and Failure Nodes.

Let:

* Indexing start at 1
* $S_i$ = Node at index i
* $F_i$ = Failure node between index i and i+1
* $p_i$ = Probability for key = $S_i$
* $q_i$ = Probability for $S_i <$ key $< S_{i+1}$ (leading to a Failure Node)
* D(n)  = Distance from a Node to the root

**Cost of *n* Failure Nodes:** $\sum_{i=0}^n q_i * (D(F_i)-1)$

**Cost of *n* existing Nodes:** $\sum_{i=1}^n p_i * D(S_i)$

###Brute Force###

1. Try Every Root
2. Recursively calculate the cost of the left and right branches
	* Base case is only one node
3. Select the optimal root (weight(L)+cost(L)+weight(R)+cost(R)

This is $O(N^2)$

