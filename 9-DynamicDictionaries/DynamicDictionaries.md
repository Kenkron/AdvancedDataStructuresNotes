Binary Search Trees
===================

*Lectures 18-21*

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
	* Initializaion of a heap requires the values sorted be sorted, which must take $n\log(n)$ time
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
			* A renamed red-black tree

AVL Tree
--------

Let:

* H(tree) = height of tree
* L = left child
* R = right child
* **Balance Factor** = H(L) - H(R)
* A = a node where 2 < Balance Factor < 2 for this node, but none of its children

A tree is an AVL Tree iff for every node, the balance factor is between -1 and 1 (inclusive).

###Insertion:###

* Insert as for any binary tree
* Propogate new nodes
* Fix imbalances in propogations

If, during propogation, a balance factor of 2 or -2 is created, all subtrees are guaranteed to have an initial balance factor of zero.  If the initial balance was non-zero, either an inbalance would have been created sooner (if the value moved further from zero), or the subtree's height would not have changed (if the value moved towards zero). There are four possible cases for imbalance that are solved differently. 

* LL: Added to left child of left child
	* Left child moves to A
	* A becomes the right child of Left
	* A's left node becomes Left's previous right node
* RL: Added to right child (B)'s left child (C)
	* C moves to A
* RR: Added to right child (B)'s right child (C)
	* B moves to A
	* A becomes the left child of B
	* A's right node becomes Right's previous left node
* LR: Added to left child (B)'s right child (C)
	* C moves to A
	* B's new right node is C's previous left node
	* A's new left node is C's previous right node
	* Correct balance factors

###Removal###

Remove deletes a node somewhere.  Let Q be the parent of the deleted node.  The balance factor of Q will change, and it's parents may as well.  If an imbalance is found, categorize it based on the child from which the removal occurs. If the balance factor of a node is -2, and the left child has a balance factor of 1, it is called an R1 imbalance.

* **R1/R0 imbalance**: Rotate the left child to the root, and root to the right child
* **R-1 imbalance**: Put the left$\rightarrow$right child at the root, and make the root the right child.
* **L1 imbalance**: Put the right$\rightarrow$left child at the root, and make the root the left child.
* **L0/L-1 imbalance**: Rotate right child to the root, and root to the left child

Red Black Trees
---------------

*This is a 2-3-4 tree by a different name/description*

A Red Black tree is a Balanced Binary Search Tree where each node stores a color: either *red* or *black*. The height is at most $2\log(n)$ External Nodes are empty, and are used as placeholders. It must satisfy the following requirements:

* The root must be black
* All external nodes must be black
* There cannot be two red nodes in a row
* There must be the same number of black nodes in each path from root to external

Red Black Trees require only one rotation for every insert/delete.  This is useful for priority queues, which may require an $O(\log(n))$ operation for each rotation.

###Insertion###

Let: 

* P = a new red node
* PP = P's parent
* GP = PP's parent

Insertion:

* Newly inserted node becomes red by default
* If P and PP are both red:
	* If GP's other child is red
		* Switch PP and it's sibling to black, and GP to red
		* Propogate the both red check up the tree
	* If GP's other child is black
		* If it's LL rotation
			* Aame as AVL Tree
			* Do a rotation where PP take's GP's place and becomes black
			* GP becomes PP's child and becomes red
		* If it's LR rotation 
			* Aame as AVL Tree
			* Do a rotation where P take's GP's place and becomes black
			* GP becomes P's child and becomes red

###Deletion###

For rebalancing when a black node is removed:

* If a black leaf node is deleted, let it be Y
* If a black node wiht one child is deleted, let it's child be Y
* A degree 2 node is replaced with another node, and this other node determines Y based on the previous two rules
* A red node with one or fewer children does nor create a black node deficiency, so no rebalancing is needed
* Let PY be the parent of Y
* Let C be the other child of PY
* Let V be the number of red children of C

If Y exists, it is a deficient node:

* If y is red, make it black.
* If y is black:
	* (If y is the root, do nothing)
	* For a right removal where PY is black, C is black, and V = 0:
		* Change the color of V to red
		* This does not solve the problem, it just moves it up the tree
	* For a right removal where PY is red, C is black, and V = 0:
		* Change the color of V to red
		* change PY to black
		* This does solve the problem
	* For a right removal where C is black and V = 1:
		* Do an LL rotation or LR rotation (depending on the side of the red child)
	* For a right removal where C is black and V = 2:
		* Do an LR rotation

###Join/Split###

Let:

* Rank(x) = numer of black nodes from x to an external node (excluding x)
	* Same as # black pointers
	* If this node is external, it's rank is zero
	* Recall external empty nodes are considered black

There is another definition of red-black tree saying that the rank of a parent node is greater than or equal to its child's rank, and the rank of a grandparent node must be 1 or 2 greater than its grandchild.

Let:

* M = New value to join
* S = Binary search tree to join, with all elements < M
* B = Binary search tree to join, with M < all elements

**Join: O(log(n))**

* If rank(S) == rank(B)
	* M becomes the new root
	* S becomes the left branch
	* B becomes the right branch
* If rank(S) > rank(B)
	* Follow right part of S until you reach a node with the same rank as B
	* Do the insert there, with M as the new subroot, etc.
	* M must be red to preserve red-black property 
	* If you end up with two red nodes in a row, use insertion rules to fit.
* Mirror for rank(S) < rank(B)

**Split: Normal BST O(log(n))**

* If a node is less than m, add it, with it's left child to S
	* It's right child becomes the new original root
	* Mirror this for a node greater than m
	* Each addition will leave an unused branch on the most recent node of both S and B
	* This is where you put each subsequent node
* If you run into M, that becomes the separate node, and It's left and right children become the ends of S and B respectively.
* This does not guarantee balance

**Split: Red Black Tree O(log(n))**

*Done in two passes*

* Use the normal split technique, but do joins at each level.
