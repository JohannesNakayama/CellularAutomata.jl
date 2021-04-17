# CellularAutomata.jl

[SO FAR, THIS README IS A MORE OR LESS UNSTRUCTURED BRAIN DUMP! DO NOT REGARD THIS AS RELIABLE INFORMATION!]

This repository contains a very basic implementation of elementary cellular automata. So far, the code only affords cellular automata where each cell update is only contingent on its own current state and the state of its two neighbors.

Cellular automata are a very useful tool to express computation as a discrete mathematical structure. They have a strikingly diverse range of application areas, from biology to physics, social science, and many more. 

In thermodynamics, most systems move towards a state of maximum entropy or--more colloquially--chaos. However, biological system often do not adhere to this principle. No matter what scope one applies to life, the emergence of order from a chaotic state is observable. 

The core idea of expressing the emergence of order in terms of cellular automata is to provide a toolkit of discrete structures in which these kinds of systems can be formally described. 

It is convenient to start with finite cellular automata which have a finite number of states N. 
You can think of these cellular automata as a one-dimensional lattice with periodic boundary conditions, or--put simply--a graph whose vertices and edges form a circle.

In elementary cellular automata, the subsequent state of a cell is contingent on the current value of that cell as well as the value of the two adjacent cells (or neighbors if you think about it in a graph theoretical way). 

To build an intuition about cell updates, think about it this way: The cell update can be thought of as a function which maps "cell triples" to a new state, i.e., a function {0, 1}^3 -> {0, 1}. The domain of this function has a cardinality of 2^3 = 8 and the and the codomain a cardinality of size 2. There are 256 possible update rules under these constraints and there is a convenient numbering system for them called Wolfram codes:
The possible triples interpreted as 3-bit binary number and are arranged in descending order (from 111 to 000). Each triple is then mapped to a bit representing the new cell state. These eight bits themselves can then be interpreted as a binary number again, and their decimal representation is simply used as the name of the rule.

Here is an example:
![](media/rule_30_wolfram_code.png)


Elementary cellular automata are often displayed as a sequence of state iterations from top to bottom:

![](media/rule30.png)

In this case, white cells represent cells with state 1 and black cells represent cells with state 0.







