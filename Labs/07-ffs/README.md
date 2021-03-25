# 07-ffs
[xalkan00-Digital-electronics-1](https://github.com/xalkan00/Digital-electronics-1)

## 1- Preparation tasks (done before the lab at home). Submit:
### 1.1 Characteristic equations and completed tables for D, JK, T flip-flops.

   | **D** | **Qn** | **Q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | No change |
   | 0 | 1 | 0 | Reset |
   | 1 | 0 | 0 | Reset |
   | 1 | 1 | 1 | Set |

   | **J** | **K** | **Qn** | **Q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | 0 | No change |
   | 0 | 0 | 1 | 1 | No change |
   | 0 | 1 | 0 | 0 | Reset |
   | 0 | 1 | 1 | 0 | Reset |
   | 1 | 0 | 0 | 1 | Set |
   | 1 | 0 | 1 | 1 | Set |
   | 1 | 1 | 0 | 1 | Toggle |
   | 1 | 1 | 1 | 0 | Toggle |

   | **T** | **Qn** | **Q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | No change |
   | 0 | 1 | 1 | No change |
   | 1 | 0 | 1 | Toggle |
   | 1 | 1 | 0 | Toggle  |


## 2- D latch. Submit:

### 2.1 VHDL code listing of the process p_d_latch with syntax highlighting,
``` VHDL

```
### 2.2 Listing of VHDL reset and stimulus processes from the testbench tb_d_latch.vhd file with syntax highlighting and asserts,
``` VHDL

```
### 2.3 Screenshot with simulated time waveforms; always display all inputs and outputs. The full functionality of the entity must be verified.

<img src="  " />

## 3- Flip-flops. Submit:

### 3.1 VHDL code listing of the processes p_d_ff_arst, p_d_ff_rst, p_jk_ff_rst, p_t_ff_rst with syntax highlighting,
proces p_d_ff_arst
``` VHDL


```
proces p_d_ff_rst
``` VHDL


```
proces p_jk_ff_rst
``` VHDL


```
proces p_t_ff_rst
``` VHDL


```

### 3.2 Listing of VHDL clock, reset and stimulus processes from the testbench files with syntax highlighting and asserts,
``` VHDL


```

### 3.3 Screenshot with simulated time waveforms; always display all inputs and outputs. The full functionality of the entities must be verified.


<img src="  " />

## 4- Shift register. Submit:

### 4.1 Image of the shift register schematic. The image can be drawn on a computer or by hand. Name all inputs, outputs, components and internal signals.

<img src=" " />
