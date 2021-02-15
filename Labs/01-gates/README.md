# 01-gates
[xalkan00-Digital-electronics-1](https://github.com/xalkan00/Digital-electronics-1)

<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/01-gates/Obrazky/F.png" /> 

### Verification of De Morgan's laws of function f(c,b,a).
#### VHDL code

```VHDL
architecture dataflow of gates is
begin
 
  
  f_o <= (a_i and (not b_i)) or ((not b_i) and (not c_i));
  
  fnand_o <= (a_i nand (not b_i)) nand ((not b_i) nand not(c_i));
 
  fnor_o <= (not((not (a_i) nor b_i) nor (b_i nor c_i)));

end architecture dataflow;
```
### Funkce F
<a href="https://www.codecogs.com/eqnedit.php?latex=\begin{align*}&space;f(c,b,a)&space;=&~&space;\overline{b}\cdot&space;a&space;&plus;&space;\overline{c}\cdot&space;\overline{b}\\&space;f(c,b,a)_{\textup{NAND}}&space;=&(\overline{\overline{\overline{b}\cdot&space;a}).(\overline{\overline{c}\cdot&space;\overline{b}}})\\&space;f(c,b,a)_{\textup{NOR}}&space;=&(\overline{\overline{\overline{b}\&space;&plus;&space;a})&plus;(\overline{\overline{c}\&space;&plus;&space;\overline{b}}})\\&space;\end{align*}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\begin{align*}&space;f(c,b,a)&space;=&~&space;\overline{b}\cdot&space;a&space;&plus;&space;\overline{c}\cdot&space;\overline{b}\\&space;f(c,b,a)_{\textup{NAND}}&space;=&(\overline{\overline{\overline{b}\cdot&space;a}).(\overline{\overline{c}\cdot&space;\overline{b}}})\\&space;f(c,b,a)_{\textup{NOR}}&space;=&(\overline{\overline{\overline{b}\&space;&plus;&space;a})&plus;(\overline{\overline{c}\&space;&plus;&space;\overline{b}}})\\&space;\end{align*}" title="\begin{align*} f(c,b,a) =&~ \overline{b}\cdot a + \overline{c}\cdot \overline{b}\\ f(c,b,a)_{\textup{NAND}} =&(\overline{\overline{\overline{b}\cdot a}).(\overline{\overline{c}\cdot \overline{b}}})\\ f(c,b,a)_{\textup{NOR}} =&(\overline{\overline{\overline{b}\ + a})+(\overline{\overline{c}\ + \overline{b}}})\\ \end{align*}" /></a>



| **C** | **B** |**A** |**F** |**F NAND**|**F NOR**|
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 | 1 | 1 |
| 0 | 0 | 1 | 0 | 0 | 0 |
| 0 | 1 | 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 | 0 | 0 |
| 1 | 0 | 0 | 1 | 1 | 1 |
| 1 | 0 | 1 | 1 | 1 | 1 |
| 1 | 1 | 0 | 0 | 0 | 0 |
| 1 | 1 | 1 | 0 | 0 | 0 |

### VHDL simulatione 
Signal F, Fnand
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/01-gates/Obrazky/F%2C%20Fnand.png" /> 

Signal Fnor
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/01-gates/Obrazky/Fnor.png" />


[xalkan00,Verification of De Morgan's laws of function f(c,b,a), EDA Playground](https://www.edaplayground.com/x/KM47)

### Poznamka
když jsem chtel zobrazit tři signaly v jednom simulaci , tak se mi nic neukazalo, musel jsem zobrazit signal Fnor zvlašt 

### Verification of Distributive laws.
#### VHDL code

<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/01-gates/Obrazky/x.png"/>


``` VHDL
entity gates is
    port(           -- Vstupni data
        x_i    : in  std_logic;         
        y_i    : in  std_logic;         
        z_i    : in  std_logic;    
        			-- vystupni data
        f1_o    : out std_logic;
        f2_o    : out std_logic;
        f3_o    : out std_logic;
        f4_o    : out std_logic
       
    );
end entity gates;

------------------------------------------------------------------------
-- Architecture body for basic gates
------------------------------------------------------------------------
architecture dataflow of gates is
begin
 
  
  f1_o <= ((x_i and y_i) or (x_i and z_i));
  f2_o <= (x_i and (y_i or Z_i));
  f3_o <= ((x_i or y_i) and (x_i or z_i));
  f4_o <= (x_i or (y_i and z_i));

end architecture dataflow;
```

[xalkan00, Verification of Distributive laws, EDA Playground](https://www.edaplayground.com/x/en6)
