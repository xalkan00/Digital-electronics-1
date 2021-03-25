# CircuitVerse simulation - basic logic gates
A screenshot of our simulation schematic.


![and_gates](../../Images/01-logic-gates-1.png)

# Basic logic gates table

| **A** | **B** | **AND** | **NAND**| **OR** | **NOR** | **XOR** | **XNOR** | **NOT**(A) |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 | 0 | 1 | 0 | 1 | 1 |
| 0 | 1 | 0 | 1 | 1 | 0 | 1 | 0 | 1 |
| 1 | 0 | 0 | 1 | 1 | 0 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 | 1 | 0 | 0 | 1 | 0 |

# Verifying DeMorgan's law

Now we try to verify DeMorgan's law by running these equations (original *f* and its substitutes)

![equations](https://latex.codecogs.com/gif.latex?\begin{align*}&space;f&space;&&space;=&space;a\cdot\bar{b}&plus;\bar{b}\cdot\bar{c},\\&space;f_{AND}&space;&&space;=&space;\overline{\overline{a&space;\cdot&space;\bar{b}}\cdot\overline{\bar{b}\cdot\bar{c}}},\\&space;f_{OR}&&space;=&space;\overline{\bar{a}&space;&plus;&space;b}&space;&plus;&space;\overline{b&space;&plus;&space;c}.&space;\end{align*})


in CircruitVerse simulation.

# Simulation - DeMorgan's law

![demorgan](../../Images/01-logic-gates-2.png)

