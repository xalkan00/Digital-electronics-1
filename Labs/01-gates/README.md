# 01-gates
[xalkan00-Digital-electronics-1](https://github.com/xalkan00/Digital-electronics-1)

<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/01-gates/Obrazky/Fnor.png" /> 

### De Morgan's Laws

```VHDL
architecture dataflow of gates is
begin
 
  
  f_o <= (a_i and (not b_i)) or ((not b_i) and (not c_i));
  
  fnand_o <= (a_i nand (not b_i)) nand ((not b_i) nand not(c_i));
 
  fnor_o <= (not((not (a_i) nor b_i) nor (b_i nor c_i)));

end architecture dataflow;
```

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






