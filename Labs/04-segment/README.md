# 01-segment
[xalkan00-Digital-electronics-1](https://github.com/xalkan00/Digital-electronics-1)
## 1) Preparation tasks (done before the lab at home). Submit:

#### Figure or table with connection of 7-segment displays on Nexys A7 board,



#### Decoder truth table for common anode 7-segment display.

| **Hex** | **Input** | **a** | **b** | **c** | **d** | **e** | **f** | **g** |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0000 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
| 1 | 0001 | 1 | 0 | 0 | 1 | 1 | 1 | 1 |
| 2 | 0010 | 0 | 0 | 1 | 0 | 0 | 1 | 0 |
| 3 | 0011 | 0 | 0 | 0 | 0 | 1 | 1 | 0 |
| 4 | 0100 | 1 | 0 | 0 | 1 | 1 | 0 | 0 |
| 5 | 0101 | 0 | 1 | 0 | 0 | 1 | 0 | 0 |
| 6 | 0110 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| 7 | 0111 | 0 | 0 | 0 | 1 | 1 | 1 | 0 |
| 8 | 1000 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 9 | 1001 | 0 | 0 | 0 | 1 | 1 | 0 | 0 |
| A | 1010 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| b | 1011 | 1 | 1 | 0 | 0 | 0 | 0 | 0 |
| C | 1100 | 0 | 1 | 1 | 0 | 0 | 0 | 1 |
| d | 1101 | 1 | 0 | 0 | 0 | 0 | 1 | 0 |
| E | 1110 | 0 | 1 | 1 | 0 | 0 | 0 | 0 |
| F | 1111 | 0 | 1 | 1 | 1 | 0 | 0 | 0 |


## 3) LED(7:4) indicators. Submit:
   
   Turn LED(4) on if input value is equal to 0, ie "0000"
      
   Turn LED(5) on if input value is greater than 9
   
   Turn LED(6) on if input value is odd, ie 1, 3, 5, ...
    
   Turn LED(7) on if input value is a power of two, ie 1, 2, 4, or 8
    
| **Hex** | **Inputs** | **LED4** | **LED5** | **LED6** | **LED7** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0000 |  |  |  |  |
| 1 | 0001 |  |  |  |  |
| 2 | 0010 |  |  |  |  |
| 3 | 0011 |  |  |  |  |
| 4 | 0100 |  |  |  |  |
| 5 | 0101 |  |  |  |  |
| 6 | 0110 |  |  |  |  |
| 7 | 0111 |  |  |  |  |
| 8 | 1000 |  |  |  |  |
| 9 | 1001 |  |  |  |  |
| A | 1010 |  |  |  |  |
| b | 1011 |  |  |  |  |
| C | 1100 |  |  |  |  |
| d | 1101 |  |  |  |  |
| E | 1110 |  |  |  |  |
| F | 1111 |  |  |  |  |
