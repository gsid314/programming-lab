%option noyywrap
DIGIT [0-9]
ID [a-z][a-z0-9]*
WHITESPACE [ \n\t]+
%%
{DIGIT}+ {
printf( "integer %s (%d)\n", yytext,
atoi( yytext ) );installNum(); 
}

";" printf( "end of expression marker %s\n", yytext );
FOR  printf( "keyword %s\n", yytext );

BEGIN    printf( "keyword %s\n", yytext ); 

END   printf( "keyword %s\n", yytext ); 

END\.  printf( "keyword: %s\n", yytext ); 

PROGRAM  printf( "keyword %s\n", yytext ); 
 
VAR  printf( "keyword: %s\n", yytext ); 

READ  printf( "keyword %s\n", yytext ); 

DO     printf( "keyword %s\n", yytext );

WRITE  printf( "keyword %s\n", yytext );

INTEGER  printf( "keyword %s\n", yytext );

TO   printf( "keyword %s\n", yytext );

DIV   printf( "keyword %s\n", yytext );


{ID}  printf( "identifier %s\n", yytext ); installID();
"+"  printf( "operator %s\n", yytext );
"-"  printf( "operator %s\n", yytext );
"*" printf( "operator %s\n", yytext );
"," printf( "variable def separator %s\n", yytext );

":" printf( "separator %s\n", yytext );
":=" printf("assignment operator %s\n",yytext);
"(" printf("Open parenthesis\n");
")" printf("Closed parenthesis\n");
"{"[^}\n]*"}" 
[ \n\t]+ 
. printf("Unrecognized character %s\n",yytext);
%%
#include<stdlib.h>
#include<stdio.h>
#include<string.h>
struct symbol{

char* var;
char* type;
struct symbol* next;
};

struct num_constant{

  int num;
  struct num_constant* next;
};

struct symbol* symbol_table[100];
struct num_constant* num_table[100];


struct symbol* add_symbol(struct symbol * p,char* var ){


    struct symbol* head =p;
	struct symbol* q= (struct symbol*)malloc(sizeof(struct symbol));
	q->var=var;
	if(!p){
           
		p=q;
		head=p;
            
	}else{

          if(strcmp(p->var,var)==0){
			return head;
           }
		 while(p->next){
			 p=p->next;
			if(strcmp(p->var,var)==0){ return head;
           }
		 }
		 p->next =q;

	}

	return head;
}

struct num_constant* add_num(struct num_constant* p,int n ){



    struct num_constant* head =p;
	struct num_constant* q= (struct num_constant*)malloc(sizeof(struct num_constant));
	q->num=n;
	if(!p){
         
		p=q;
		head=p;
	}else{
   
          if(p->num==n){
			return head;
           }
		 while(p->next){
			 p=p->next;
			if(p->num==n){ return head;
           }
		 }
		 p->next =q;

	}

	return head;
}

void insert_into_num_table( int n){

int slot = n%100;
 num_table[slot] = add_num(num_table[slot],n);

}
void insert_into_symbol_table(char* var,int length){

 char * t = malloc(sizeof(char)*length);
strcpy(t,var);

 int key=0;
 for(int i=0;i<length;i++){
  key=key+var[i];
 }

 int slot=key%100;
 symbol_table[slot] = add_symbol(symbol_table[slot],var);

}

void print_symbol_table(){
	for(int i=0;i<100;i++){
	struct symbol* q =symbol_table[i];
           while(q){
             printf("slot %d %s \n",i,q->var);
             q=q->next;
           }
 }
}

void print_num_table(){
	for(int i=0;i<100;i++){
	struct num_constant* q =num_table[i];
           while(q){
             printf("slot %d %d\n",i,q->num);
             q=q->next;
           }
 }
}

void installID(){
char * t = malloc(sizeof(char)*yyleng);
char *m=t;
for(int i=0;i<yyleng;i++){
m[i]=yytext[i];
}

insert_into_symbol_table(t,yyleng);
}

void installNum(){
insert_into_num_table(atoi(yytext));
}
main( argc, argv )
int argc;
char **argv;
{
++argv, --argc; 
if ( argc > 0 )
yyin = fopen( argv[0], "r" );
else
yyin = stdin;
yylex();
printf("symbol table:\n");
print_symbol_table();
printf("num table:\n");
print_num_table();

}
