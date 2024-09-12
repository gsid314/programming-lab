OS: Ubuntu 20.04 LTS

Installations(if not present):
sudo apt install flex
sudo apt install bison
sudo apt install gcc

Compile:

flex lex.l
bison -d parser.y
gcc -o out parser.tab.c lex.yy.c -lfl

Run:

./out <prog.txt


Output:
If no errors, no output is displayed.
In case of semantic and syntax errors, errors with corresponding line numbers are shown

Syntax errors:
1. If language is not constructed according to the grammar, bison displays "syntax error at line <line_no>" and exits. No further processing is done.

for example :
1. missing prog name
2. Spelling mistake in keyword.
3. Missing semicolons
4. Missing END or END.
5. Wrongly formed FOR expression.
etc.

Semantic errors:

1. Undefined variables in expressions, assignments, READ, WRITE
2. Type mismatch in expressions. It is expected that both operands be of either REAL or INTEGER
3. Type mismatch between LHS and RHS in assignments
4. Duplicate definitions
5. FOR index exp should be integer type.



Implementation Details:
Identifier values are read from yytext and stored into yyval.sval. yyval is a standard type made available by bison. It is overriden in parser.y to use a custom type at runtime.
 The id node stores the identifier values. exp, term, factor nodes store the type value as that is needed to check type mismatch in expressions.
 
 During processing declaration section, variables are stored into symbol table. Since type is available later, variables are stored in a temp table. When type is available, symbol table is updated to 
 contain the type information for these variables. 
 
 
 
 Known issue:
 1. Sometimes type mismatch gives the line number 1 more than actual. Not sure why it happens.
 2. If in an expression, there is a type mismatch, error travel upwards and we may see same error repeated multiple times.
 
 Info:
 exp-1 contains a lot of semantic errors. Can be used to check for errors
 prog.txt contains the standard code from beck's book. It has no errors.
 
