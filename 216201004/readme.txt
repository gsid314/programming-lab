OS: Ubuntu 20.04

Steps to run:
sudo apt install flex (if flex is not installed)
flex lex.l
gcc lex.yy.c
./a.out <source.txt
./a.out <source2.txt

Output:
First we list all the tokens identified as per the rules in lex.l
Then, the contents of symbol table are printed. Slot number and its contents are displayed. Since chaining has been used to resolve collisions, one slot may point to more than one identifier string
Then, the contents of num table are printed, which holds the integer constants as per the lex rules.
Symbols not in the language of the grammar are shown as Unrecognized character

Imp points:
1. The action corresponding to a rule does not have a return statement, which typically should be there when used with yacc. If return is used, scanner returns after just finding one token.


