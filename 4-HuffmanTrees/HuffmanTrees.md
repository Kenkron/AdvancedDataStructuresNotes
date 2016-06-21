Huffman Trees
=============
-------------

*Lecture 7-8*

**WEPL**: Weighted External Path Length = $\sum$ Weight (e.g. size) of External Node $\times$ Length of Path to the Tree Root

**Huffman Tree**: A tree with the minimum WEPL

Huffman Trees are useful when it is known that some External Nodes will be accessed more often than others. The tree is made more efficient by giving common External Nodes a greater weight, thus putting them closer to the root of the tree (at the cost of putting uncommon External Nodes further from the root).

###Binary Huffman Tree creation###

Binary Huffman Tree can be created with a greedy algorithm

* Let every External Node start out as an independent tree
* Combine the two trees with the smallest weight into a single tree with their combined weight.
* Repeat until there is only one tree (n-1 combines)

**You can use a min heap to find the smallest weights**

##Higher Order Huffman Tree Generation###

* Greedy algorithm does not work in cases where there are not enough nodes to fill the tree
* The solution is to add 0 weight nodes at the outset to ensure a full tree
* For a tree of order k
	* Each merge reduces the number of trees by k-1
	* After s merges, r + q + s(k-1) = 1 for a full tree
		* where s is the number of merges
		* r is the number of initial trees
		* q is the number of added 0 weight nodes
	* Number of zeros to add is 
		* if (r-1)mod(k-1): 0
		* else: k-1-(r-1)mod(k-1) 

Application to Efficient Run Merging
------------------------------------

*Merging trees of the same size is more efficient than merging trees of different sizes, but tournament tree run generation makes different sized runs.*

* A Huffman Tree can pair merges as efficiently as possible
	* Each merge's cost is the length of its children
	* Thus, each runs cost is multiplied by its distance to the origin
* Remember to use an "End of Run" marker (e.g. null terminator) to mark the end of a run
* For each run in merge, store a queue of input buffers for the run.
* Continuously add input buffers to the run that will run out first
	* Heuristically determined (e.g. add a buffer to the smallest queue)
	* Use 2k buffers (where k is the number of merging runs) 
		* To ensure each buffer has a waiting replacement for when it runs out
		* To ensure that, if a run needs another buffer, there is always an available buffer to read into.
		* Proof by contradiction
* If you finish a run for a merge, you might be able to start loading the next run for the next merge (maybe)
