External Sorting
================
----------------

*Lectures 3-4*

* Efficient external sorting techniques can be similar to cache optimization
	* Algorithms can be arranged to use memory in cache-friendly strips
		* e.g. in a matrix, try to iterate over rows before columns, because rows are usually stored sequentially, allowing them to be cached together.
		* Prefetch can sometimes mitigate cache misses, but:
			* Not always
			* Still requires energy
* Input and Output are usually provided as 1 block buffers
	* 1 block is the amount of memory an I/O operation uses at once
		* Typically fixed
	* When an output buffer is full, it is flushed to I/O all at once
	* When an input buffer is empty, it is filled from I/O all at once

External Quicksort
------------------

*Instead of having a single pivot as the middle section, use a range of values. This prevents the entire middle range from undergoing further I/O operations*

1. Divide available memory into four segments
	* Input (unsorted list)
	* Lesser Output
	* Greater Output
	* Middle (uses as much space as possible; to be sorted locally)
		* Initially filled from input
		* In simpler merge sorts, this would be a single pivot value
2. Each time a value is read, we must see if it is greater, or less than the middle segment's range

	~~~python
	#pythonic pseudocode:
	if value >= max(MiddleValues):
		GreaterOutput.write(value)
	else if value <= min(MiddleValues):
		LesserOutput.write(value)
	else:
		if len(LesserOutput) < len(GreaterOuput):
			LesserOutput.write(min(MiddleValues))
			MiddleValues.removeMin()
			MiddleValues.add(value)
		else:
			GreaterOutput.write(max(MiddleValues))
			MiddleValues.removeMax()
			MiddleValues.add(value)
	~~~

3. Once the input has been read completely, sort the middle section with an internal sort. Recursively apply this algorithm to the lesser and greater sections.

**A double ended priority queue is required for Step 2**

External Mergesort
------------------

Let *run* = a sorted subsection of a mergesort

1. Generate initial runs based on size of available memory
2. Merge runs 
	* Use three blocks of memory
		1. Input 1 (Run 1)
		2. Input 2 (Run 2)
		3. Output
	* Compare the first values of run 1 and run 2, and move the lower value to output
3. Repeat recursively until only 1 run remains containing all sorted data

--------------------------------------------------------------------------------

###Example:###

Given:

* 5 blocks memory (+ room for program/variables/etc.)
* 100 records per block of memory
* 10000 records (100 blocks) to sort on disk

Let:

* *$T_{IO}$* = Time to read/write a block of data
* *$T_{IS}$* = Time for an internal sort on a memory-load of data
* *$T_{IM}$* = Time to merge a block of data

The time required per step is:

1. $200T_{IO} + 20T_{IS}$
2. $200T_{IO} + 100T_{IM}$ (regardless of level)
3. $T_{Step1} + T_{Step2}*ceil(log2(len(InitialRuns)))$

--------------------------------------------------------------------------------

###For better speed, use a higher order merge###

*(merge more than 2 runs at once)*

* Number of merges will go down by a factor of $log_2(order)$
* I/O time per merge will remain the same
* Merge time is $log_2(order)$ using tournament tree

**A Tournament Tree is required for $log_2(order)$ merging**
