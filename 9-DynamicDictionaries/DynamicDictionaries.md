Dynamic Dictionaries
====================

Binary Search Trees
------------------

* Put: O(Height)
	* Search for this key until you find a failure node or duplicate
* Remove: O(Height)
	* If this node has no child, just remove it
	* If this node has one child, replace it with its child
	* If this node has two children, replace this node with the removal of either:
		* The leftmost child on the right branch
		* The rightmost child on the left branch
* Find Max/Min: O(Height)/O(1)
	* Follow the Right/Left branches
	* Remove the last one
	* Can be easily adapted to have O(1) by just keeping a pointer to max/min
* Initialize: O($n\log(n)$)
	* Initializaion of a heap requires the values sorted, which must take $n\log(n)$ time
* Meld: O(n)
	* Meld requires O(n) because it is known that two sorted sequences require linear number of compares

###Balanced Binary Search Tree###

* **Full Binary Tree:** Every level is filled
	* Only possible when $n=2^k-1$
* **Complete Binary Tree:** Every level, except possibly the last, is filled. 
	* Unable to insert/delete in logarithmic time
* **Balanced Search Tree:** Difference between children is below a constant value
	* Height Balanced
		* AVL trees
	* Weight Balanced
	* Degree Balanced
		* 2-3 trees
		* 2-3-4 trees
		* red-black trees

AVL Tree
--------

Let:

* H(tree) = height of tree
* L = left child
* R = right child
* **Balance Factor** = H(L) - H(R)

A tree is an AVL Tree iff for every node, the balance factor is between -1 and 1 (inclusive).



