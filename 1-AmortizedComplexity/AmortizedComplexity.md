Amortized Complexity
====================

*Lectures 1-2*

Amortized complexity is an upper bound lower than than worst-case complexity.

**Overcharge**: difference between the predicted cost and the actual cost of an operation

**Potential**: Sum of overcharges for all operations so far

Let:

* A = the amortized cost of an operation
* C = the Actual cost of an operation
* P = the potential of an operation (the sum of all overcharges leading up to that operation)

Amortized complexity must satisfy P(n)>=0 for all n. Thus, a single algorithm may have multiple amortized complexities.

Methods to find Amortized Complexity:

* Aggregate Method
	* Figure out how much everything costs, then find upper bound from that
	* Not useful: Amortized Complexity is used to estimate bounds, but this method uses bounds to calculate Amortized Complexity
* Accounting method
	* Guess amortized cost
	* Show that P(n)-P(0) >= 0
		* e.g. proof by induction
		* Show that it is true for 1
		* Show that, if it's true for k, it must be true for k+1
* Potential Method
	* Try to guess a potential function
		* A(i) = C(i)+P(i)
	* Apply this to a known cost to find amortized cost
		* $\Delta$P = P(i) - (Pi-1)
		* Amortized Cost = ActualCost + $\Delta$P
	* Show that P(n)-P(0) >= 0
