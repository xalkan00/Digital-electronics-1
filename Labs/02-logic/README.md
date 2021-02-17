# Lab 2: Combinational logic

#### Contents

1. [Lab prerequisites](#Lab-prerequisites)



## Lab prerequisites

Digital or Binary comparator compares the digital signals A, B presented at input terminal and produce outputs depending upon the condition of those inputs. Complete the truth table for 2-bit Identity comparator (B equals A), and two Magnitude comparators (B is greater than A, B is less than A). Note that, such a digital device has four inputs and three outputs/functions.

|**B[1:0]**|**A[1:0]**|**B>A**|**B=A**|**B<A**|
| :-: | :-: | :-: | :-: | :-: |
| 0 0 | 0 0 | 0 | 1 | 0 | 
| 0 0 | 0 1 | 0 | 0 | 1 | 
| 0 0 | 1 0 | 0 | 0 | 1 | 
| 0 0 | 1 1 | 0 | 0 | 1 | 
| 0 1 | 0 0 | 1 | 0 | 0 | 
| 0 1 | 0 1 | 0 | 1 | 0 | 
| 0 1 | 1 0 | 0 | 0 | 1 | 
| 0 1 | 1 1 | 0 | 0 | 1 | 
| 1 0 | 0 0 | 1 | 0 | 0 | 
| 1 0 | 0 1 | 1 | 0 | 0 | 
| 1 0 | 1 0 | 0 | 1 | 0 | 
| 1 0 | 1 1 | 0 | 0 | 1 | 
| 1 1 | 0 0 | 1 | 0 | 0 |
| 1 1 | 0 1 | 1 | 0 | 0 | 
| 1 1 | 1 0 | 1 | 0 | 0 | 
| 1 1 | 1 1 | 0 | 1 | 0 |   
  
| **B1,B0\A[1,0]** | **00** | **01** | **11** | **10** |
| :-: | :-: | :-: | :-: | :-: |
| 00 |  |  |  |  |
| 01 | 1 |  |  |  |
| 11 | 1 | 1 |  | 1 |
| 10 | 1 | 1 |  |  |

| **B1,B0\A1,A0** | **00** | **01** | **11** | **10** |
| :-: | :-: | :-: | :-: | :-: |
| 00 | 0 |  |  |  |
| 01 | 0 | 0 |  |  |
| 11 | 0 | 0 | 0 | 0 |
| 10 | 0 | 0 |  | 0 |

| **B1,B0\A1,A0** | **00** | **01** | **11** | **10** |
| :-: | :-: | :-: | :-: | :-: |
| 00 | 1 |  |  |  |
| 01 |  | 1 |  |  |
| 11 |  |  | 1 |  |
| 10 |  |  |  | 1 |
