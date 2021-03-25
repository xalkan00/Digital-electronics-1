# Lab prerequisites
## Truth table - comparator

| A | B | A>B | A=B | A<B|
| :-: | :-: | :-: | :-: | :-: |
|0 | 0| 0| 1| 0|
|0 | 1| 0| 0| 1|
| 1| 0| 1| 0| 0|
| 1| 1| 0| 1| 0|

## Canonical SoP and PoS forms with maps

![SoPgreater](https://latex.codecogs.com/gif.latex?y_{A>B}^{SoP}&space;=&space;A\cdot&space;\bar{B})
||B||
|:-:|:-:|:-:|
| 0 | 0 ||
| 1 | 0|A|


![SoPequalto](https://latex.codecogs.com/gif.latex?y_{A=B}^{SoP}&space;=&space;\bar{A}\cdot\bar{B}&plus;A\cdot&space;B)

||B||
|:-:|:-:|:-:|
| 1 | 0 ||
| 0 | 1|A|


![PoSless](https://latex.codecogs.com/gif.latex?y_{A<B}^{PoS}&space;=&space;(A&plus;B)\cdot(\bar{A}&plus;B)\cdot&space;(\bar{A}&plus;\bar{B}))

||B||
|:-:|:-:|:-:|
| 0 | 1 ||
| 0 | 0|A|

![PoSminless](https://latex.codecogs.com/gif.latex?y_{A<B}^{PoS,min}&space;=&space;B\cdot&space;\bar{A})
