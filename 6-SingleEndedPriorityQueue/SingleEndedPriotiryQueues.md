Single Ended Priority Queues
============================

*Lecture 11-12*

*Because Heaps aren't good enough*

Leftist Tree
------------

* All the features of a heap
* Can meld two leftist trees in log time

* **S Value**: min distance to an external node
* Each internal node is provided an S value
* Tree must satisfy: S value on the right <= S value on the left
* During a merge of two trees:
	* The tree with the lesser top is chosen as the root
	* The other tree is merged with the rightmost node (recursively)
	* If there is no rightmost node, the other tree becomes the rightmost node
	* Then, if the min distance is messed up, swap the children
* Merge is log(n) time because it only follows the rightmost child
* Merge can be used to insert (merge a tree, and a tree of size 1)
* Merge can be used to remove (merge the branches of the previous winner
* Initialization is done in O(n) time
	* Make everything a single node leftist tree
	* Merge 2 repeatedly
* Arbitrary Remove
	* Meld it's children
	* Attach
	* Fix S value

Skew Heap
---------

* Leftist tree without storing s value
* In meld, swap every time
* The worst case complexity is not logarithmic
* The amortized complexity is logarithmic

Min Binomial Heap
-----------------

* Stored as a First Child Next Sibling tree, with circular sibling pointers
* Point to child with smallest root
* During insert
	* just add more siblings to the root
	* swap root pointer if the new one is smaller
* To Merge: Meld circular lists at top level
* *I don't like where this is going.  These operations lead to order n time*
* Remove:
	* copy and remove 1 node down
	* reinsert children
	* Update pointer (this is order s (number of subtrees))
* So far, everything leads to trivial trees in a giant list
* To fix this, we're going to replace the Remove function with one that sucks less
	* It will ensure no two trees have the same degree
	* Add a degree field to trees
	* Make a table to keep track of degrees
	* Fuse trees of the same degree
	* This ensures that all trees are binomial trees



**Binomial Trees**:

* Each level of binomial heap is the shape of it's predecessor, plus it's predecessor attached to the root.
* The base case is a single node
* The max degree of a binomial tree in a binomial heap <= log(n) after n operations

*Note that, if you take a binomial tree, and arrange it based on it's pointers, you get a full binary tree*

Take the following tree:

~~~
             A
            /|\
           / | \
          /  |  \
         /   |   \
        B    C    D
       /|    |
      / |    |
     /  |    |
    /   |    |
   E    F    G
   |
   |
   |
   |
   H
~~~

Because a node only points to its first child and next sibling, the tree's
pointers look more like this:

~~~
             A
            /
           / 
          /  
         /   
      >-B----C----D->
       /     |
      /      |
     /       |
    /        |
 >-E----F->  G
   |
   |
   |
   |
   H
~~~

If you rearrange this so that the tree structure is based on the pointers, you 
get a full binary tree, with an awkward extra node at the root, and an 
occasional pointer looping back to an earlier point in the tree.  In this way,
it's easy to see why a binomial tree can be traversed in log(n) time.

~~~
         A
         |
         |
         |
         B <-----+
        / \      |
       /   \     |
      /     \    |
     /       \   |
    E <+      C  |
   / \ |     / \ |
  /   \|    /   \|
 H     F   G     D
~~~

