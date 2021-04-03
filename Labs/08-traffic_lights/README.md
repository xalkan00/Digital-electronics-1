# 08-traffic_lights
[xalkan00-Digital-electronics-1](https://github.com/xalkan00/Digital-electronics-1)

## 1- Preparation tasks (done before the lab at home). Submit:

### 1.1 Completed state table,

| **Input P** | `0` | `0` | `1` | `1` | `0` | `1` | `0` | `1` | `1` | `1` | `1` | `0` | `0` | `1` | `1` | `1` |
| :-- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| **Clock** | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) |
| **State** | A | A | B | C | C | D | A | B | C | D | B | B | B | C | D | B |
| **Output R** | `0` | `0` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `0` | `1` | `0` |

### 1.2 Figure with connection of RGB LEDs on Nexys A7 board and completed table with color settings.

| **RGB LED** | **Artix-7 pin names** | **Red** | **Yellow** | **Green** |
| :-: | :-: | :-: | :-: | :-: |
| LD16 | N15, M16, R12 | `1,0,0` | `1,1,0` | `0,1,0` |
| LD17 | N16, R11, G14 | `1,0,0` | `1,1,0` | `0,1,0` |


## 2-Traffic light controller. Submit:

### 2.1 Listing of VHDL code of sequential process p_traffic_fsm with syntax highlighting,
``` VHDL

```
### 2.2 Listing of VHDL code of combinatorial process p_output_fsm with syntax highlighting,
``` VHDL

```
### 2.3 Screenshot(s) of the simulation, from which it is clear that controller works correctly.

<img src="   " />

## 3-Smart controller. Submit:

### 3.1 State table,

<img src="   " />

### 3.2 State diagram,

<img src="   " />

### 3.3 Listing of VHDL code of sequential process p_smart_traffic_fsm with syntax highlighting.

``` VHDL

```

