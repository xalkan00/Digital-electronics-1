## Lab prerequisites

1. *Digital* or *Binary comparator* compares the digital signals A, B presented at input terminal and produce outputs depending upon the condition of those inputs. Complete the truth table for 1-bit *Identity comparator* (A=B), and two *Magnitude comparators* (A>B, A<B). Note 1 represents true, 0 false.

    | **A** | **B** | **A>B** | **A=B** | **A<B** |
    | :-: | :-: | :-: | :-: | :-: |
    | 0 | 0 | 0 | 1 | 0 |
    | 0 | 1 | 0 | 0 | 1 |
    | 1 | 0 | 1 | 0 | 0 |
    | 1 | 1 | 0 | 1 | 0 |

    According to the truth table, create canonical SoP (Sum of Product) or PoS (Product of Sum) output forms as follows:

    &nbsp;

    ![equation](https://latex.codecogs.com/gif.latex?y_%7BA%3EB%7D%5E%7BSoP%7D%3DA%5Ccdot%20%5Cbar%7BB%7D)
    &nbsp;
    
    ![equation](https://latex.codecogs.com/gif.latex?y_%7BA%3DB%7D%5E%7BSoP%7D%3D%28%5Coverline%7BA%5Ccdot%20B%7D%29&plus;%28A%5Ccdot%20B%29)
    
    &nbsp;
    
    ![equation](https://latex.codecogs.com/gif.latex?y_%7BA%3CB%7D%5E%7BPoS%7D%3D%28%5Coverline%7BA&plus;B%7D%29%5Ccdot%20%28A&plus;%5Cbar%7BB%7D%29%5Ccdot%20%28A&plus;B%29)
    
    &nbsp;

    Create K-maps for all three functions.

    |  |  | **A** |
    | :-: | :-: | :-: |
    |  | 0 | 0 |
    | **B** | 0 | 1 |
    
    |  |  | **A** |
    | :-: | :-: | :-: |
    |  | 1 | 0 |
    | **B** | 0 | 1 | 
   
    |  |  | **A** |
    | :-: | :-: | :-: |
    |  | 0 | 0 |
    | **B** | 1 | 0 |

    Use the K-map to create the minimum ![equation](https://latex.codecogs.com/gif.latex?y_%7BA%3CB%7D%5E%7BPoS%2Cmin%7D) function.

    &nbsp;

    ![equation](https://latex.codecogs.com/gif.latex?y_%7BA%3CB%7D%5E%7BPoS%7D%3D%5Cbar%7BB%7DA&plus;A%3D%7B%5Coverline%7B%5Cbar%7BB%7DA%7D%7D%5Ccdot%20%5Cbar%7BA%7D)
    
    &nbsp;
