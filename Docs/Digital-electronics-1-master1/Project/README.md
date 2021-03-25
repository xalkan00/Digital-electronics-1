# ALU (Arithmetic Logic Unit) jednotka

## Zadanie projektu
Vlastní ALU (Arithmetic Logic Unit) jednotka. Možnost výběru instrukcí a vstupních hodnot za chodu aplikace. Výstup na 7segmentovém displeji.

## Základné informácie
ALU jednotka vykonáva základné logické, aritmetické operácie a iné operácie s bitmi. Vytvorili sme 4-bitovú jednotku, ktorá vie teda previesť 16 rôznych operácií (bližšie v tabuľke v sekcii "Funkcie"). Vstup a výstup sú riadené doskou CoolRunner-II CPLD a rozširujúcou CPLD doskou. Projekt nebol kvôly krízovej situácií otestovaný na fyzickej jednotke.

## Funkcie
*A a B považujeme za vstupy, Y za výstup, C za prenosový bit*
<table>
<tr><td><b>Riadiací signál</b></td><td><b>Funkcia</b></td><td><b>Popis</b></td></tr>
<tr><td> 0000 </td><td> Y = A + B </td><td> Súčet </td></tr>
<tr><td> 0001 </td><td> Y = A + B + C </td><td> Súčet s prenosom </td></tr>
<tr><td> 0010 </td><td> Y = A - B </td><td> Rozdiel </td></tr>
<tr><td> 0011 </td><td> Y = A - B - C </td><td> Rozdiel s prenosom </td></tr>
<tr><td> 0100 </td><td> Y= A * B </td><td> Súčin </td></tr>
<tr><td> 0101 </td><td> Y = A + 1 </td><td> Inkrementácia </d></tr>
<tr><td> 0110 </td><td> Y = A - 1 </td><td> Dekrementácia </td></tr>
<tr><td> 0111</td><td> Y = A and B </td><td> Logický súčin </td></tr>
<tr><td> 1000 </td><td> Y = A or B  </td><td> Logický súčet</td></tr>
<tr><td> 1001</td><td> Y = A xor B </td><td> Exkluzivní logický súčet</td></tr>
<tr><td> 1010 </td><td> Y = not A </td><td> Logická negace </td></tr>
<tr><td> 1011 </td><td> Y = A >> 1 </td><td> Rotácia doprava </td></tr>
<tr><td> 1100 </td><td> Y = (A + C) >> 1 </td><td> Rotácia doprava s prenosom</td></tr>
<tr><td> 1101</td><td> Y = A << 1 </td><td> Rotácia doľava </td></tr>
<tr><td> 1110 </td><td> Y = (A + C) << 1 </td><td> Rotácia doľava  s prenosom</td></tr>
<tr><td> 1111 </td><td> Y = AH <=> AL</td><td> Prehádzanie bitov </td></tr>
</table>

## Zapojenie
### Orientačná schéma pre TOP
![top](https://github.com/akostelanska/Digital-electronics-1/blob/master/Project/Images/TOP_level.PNG)
### Celkové zapojenie ALU jednotky
![celkové zapojenie](https://github.com/akostelanska/Digital-electronics-1/blob/master/Project/Images/sch%C3%A9ma.jpg)

### Jednotlivé funkčnú jednotky

#### Súčet
##### Numericky sčíta hodnoty A a B na vstupe, neberie ohľad na carry bit.
![súčet](https://github.com/akostelanska/Digital-electronics-1/blob/master/Project/Images/scitanie.PNG)
#### Súčet s prenosom
##### Numericky sčíta hodnoty na vstupe, s ohľadom na carry bit. <br>
![súčet s carry](https://github.com/akostelanska/Digital-electronics-1/blob/master/Project/Images/scitanie%2Bcarry.PNG)
#### Rozdiel
##### Numericky odčíta hodnoty so vstupu, bez zahrnutia prípadných carry bitov. <br>
![rozdiel](https://github.com/akostelanska/Digital-electronics-1/blob/master/Project/Images/odcitanie.PNG)
#### Rozdiel s prenosom
##### Nemericky odčíta hodnoty so vstupu, prípadný carry bit zahrnie. <br>
![rozdiel s prenosom](https://github.com/akostelanska/Digital-electronics-1/blob/master/Project/Images/odcitanie%2Bcarry.PNG)
#### Súčin
##### Vynásobí hodnoty na vstupe. <br>
![násobenie](https://github.com/akostelanska/Digital-electronics-1/blob/master/Project/Images/nasobenie.PNG)
#### Inkrementácia
##### Zvýši hodnotu A zo vstupu o 1. <br>
![inkrement](https://github.com/akostelanska/Digital-electronics-1/blob/master/Project/Images/increment.PNG)
#### Dekrementácia
##### Zníži hodnotu A zo vstupu o 1. <br>
![dekrement](https://github.com/akostelanska/Digital-electronics-1/blob/master/Project/Images/dekrement.PNG)
#### Logický súčin
##### Prevedie funkciu AND medzi hodnotami, ktoré sú privedené a vstup ALU. <br>
![and](https://github.com/akostelanska/Digital-electronics-1/blob/master/Project/Images/and.PNG)
#### Logický súčet
##### Prevedie logický OR s hodnotami na vstupe. <br>
![or](https://github.com/akostelanska/Digital-electronics-1/blob/master/Project/Images/or.PNG)
#### Exkluzivní logický súčet
##### Prevedie funkciu XOR s hodnotami na vstupe. <br>
![xor](https://github.com/akostelanska/Digital-electronics-1/blob/master/Project/Images/xor.PNG)
#### Logická negácia
##### Zneguju hodnotu A privedenú na vstup. 
![negácia](https://github.com/akostelanska/Digital-electronics-1/blob/master/Project/Images/negacia.PNG)
#### Rotácia vpravo
##### Prevedie rotáciu hodnoty A na vstupe o 1 bit doprava. 
#### Rotácia vľavo
##### Prevedie rotáciu hodnoty A na vstupe o 1 bit doľava.


## Simulácia
Simulácia pre sčítačku <br>
![simulacia](https://github.com/akostelanska/Digital-electronics-1/blob/master/Project/Images/ADDER_simulation.PNG)

## Použité zdroje
https://www.xilinx.com/support/documentation/boards_and_kits/ug501.pdf <br>
https://en.wikipedia.org/wiki/Arithmetic_logic_unit#Functions <br>
https://github.com/tomas-fryza/Digital-electronics-1/wiki
