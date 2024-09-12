
%{
#include <stdio.h>


extern int yylineno;
	

int id_declaration=1;
char *temp_list[200];
int ctr=0;
struct symbol{

char* var;
long type;
struct symbol* next;
};
struct symbol* symbol_table[100];


struct symbol* add_symbol(struct symbol * p,char* var ){


    struct symbol* head =p;
	struct symbol* q= (struct symbol*)malloc(sizeof(struct symbol));
	q->var=var;
	//q->type=0;
	if(!p){
           
		p=q;
		head=p;
		
            
	}else{

          if(strcmp(p->var,var)==0){
          printf("error: duplicate variable %s \n",var);
			return head;
           }
		 while(p->next){
			 p=p->next;
			if(strcmp(p->var,var)==0){ 
			printf("error: duplicate variable %s \n",var);
			return head;
           }
		 }
		 p->next =q;
		

	}

	return head;
}

void insert_into_symbol_table(char* var){

 char *s=var;
 int length=0;
 while(*s!='\0'){
   length++;
   s++;
 }
 char * t = malloc(sizeof(char)*length);
strcpy(t,var);

 int key=0;
 for(int i=0;i<length;i++){
  key=key+var[i];
 }

 int slot=key%100;

            
 symbol_table[slot] = add_symbol(symbol_table[slot],var);

}

struct symbol* find_symbol(char* var){

char *s=var;
 int length=0;
 while(*s!='\0'){
   length++;
   s++;
 }
 int key=0;
 for(int i=0;i<length;i++){
  key=key+var[i];
 }

 int slot=key%100;
 
 struct symbol* h= symbol_table[slot];
 if(!h)
 return NULL;
 else{
 
 while(h){
			 
			if(strcmp(h->var,var)==0){ 
			return h;
           }
           h=h->next;
 }
 return NULL;
}
}





void print_type_mismatch_error(char* type){

printf("error:type mismatch at line %d \n", yylineno);
}

%}

%union{
	int ival; 
	double dval; 
	char *sval; 
}

%type <ival> term factor type exp 
%token PROGRAM 1 
%token VAR 2 
%token BGN 3
%token EN 4
%token END_DOT 5
%token <ival>INTEGER_TYPE 6
%token <dval>REAL 7
%token FOR 8
%token READ 9
%token WRITE 10
%token TO 11
%token DO 12
%token SEMICOLON 13
%token COLON 14
%token COMMA 15
%token ASSIGN 16
%token ADD 17
%token MINUS 18
%token MUL 19
%token DIV 20
%token OPEN_PAREN 21
%token CLOSE_PAREN 22
%token <sval> ID 23
%token <ival> NUM 24
%token <dval> NUM_REAL 25

%type <sval> id

%%

 prog              : PROGRAM prog-name VAR{id_declaration=1;} dec-list{id_declaration=0;} BGN  
                              stmt-list END_DOT
                ;
  prog-name        : id 
  ;
  dec-list         :  dec |dec-list SEMICOLON dec
  ;
  dec              :id-list COLON type {
                              //assign_types
                              // empty_the_list
                             // printf("%d ctr",ctr);
                              for(int i=0;i<ctr;i++){
                             // printf("finding symbol %s",temp_list[i]);
                                struct symbol* h = find_symbol(temp_list[i]);
                                  h->type=$3;
                              }
                                for(int i=0;i<ctr;i++){
                               temp_list[i]=NULL;
                              }
                              ctr=0;
                              }
  ;
  type             :INTEGER_TYPE {$$=INTEGER_TYPE;}| REAL {$$=REAL;} 
  ;
  id-list          :id {
                          if(id_declaration){insert_into_symbol_table($1); 
                         
                          temp_list[ctr]=$1;
                            ctr++;
                          }  else{
                           			 if(find_symbol($1)==0){ printf("error:line %d : %s variable not defined\n",yylineno,$1);
                           			 
                           			 }// type is not determined yet.
                          // add_to_temp_table;
                          
                        }
                        }
                          | id-list COMMA id {
                                             if(id_declaration){insert_into_symbol_table($3);    
                                            
                          			temp_list[ctr]=$3;
                           			 ctr++;      
                           			 }  else{
                           			 if(find_symbol($3)==0){ printf(" error:line %d : %s variable not defined\n",yylineno,$3);
                           			 
                           			 }
                           			 
                           			 
                                          
                                             }
                                             }
  ;
  stmt-list        : stmt | stmt-list SEMICOLON stmt 
  ;
  stmt             : assign | read | write | for 
  ;
  assign           : id ASSIGN exp {  if(find_symbol($1)==0){ printf("error:line %d : %s variable not defined\n",yylineno,$1); }else{
  
                                               if(find_symbol($1)->type!=$3){ // these are just integers
                                 
                                                        print_type_mismatch_error("");
                                 }
                                               }
  
                                    }
  ;
  exp               : term { $$=$1;
                       }| exp ADD term{
  				 
   				 if($1!=$3){ // these are just integers
                                 
                                 print_type_mismatch_error("");
                                 } else{
                                 
                                    $$=$3;
                                 }
                                 } | exp MINUS term {  if($1!=$3){
                                 
                                 print_type_mismatch_error("");
                                 } else{
                                 
                                    $$=$3;
                                 } }
 ;
  term              : factor{ $$=$1;
                        } | term MUL factor{
                                 if($1!=$3){
                                 
                                print_type_mismatch_error("");
                                 } else{
                                 
                                    $$=$3; // we are just concerned about types
                                 }
                                 
                                 }| term DIV factor { if($1!=$3){
                                 
                                   print_type_mismatch_error("");
                                 } else{
                                 
                                    $$=$3; // we are just concerned about types
                                 }}
  ;
  factor            : id {
  				struct symbol* h = find_symbol($1);
  				if(h==NULL){ printf(" Error: variable %s not defined\n",$1); }else{
  				  $$=h->type; // we need to get this from symbol table
  				//  printf("  Variable %s type %d\n",$1,$$);
  				  
  				  
  				
                           }
                           }| NUM {$$ = INTEGER_TYPE; }| NUM_REAL{ $$=REAL;} | OPEN_PAREN exp CLOSE_PAREN
 ;
  read              : READ OPEN_PAREN id-list CLOSE_PAREN
 ;
  write             : WRITE OPEN_PAREN id-list CLOSE_PAREN
 ;
  for               : FOR index-exp DO body 
 ;
  index-exp         : id ASSIGN exp TO exp { if($3!=INTEGER_TYPE || $5!=INTEGER_TYPE) {
  							printf("Error: Expect integer expressions in For\n");
                                            }}
 ;
  body              : stmt | BGN stmt-list EN
  
  id:ID		{$$ = yyval.sval; }
 ;
 
 %%
 
 #include<stdlib.h>
#include<stdio.h>
#include<string.h>


 main(int argc, char **argv)
{
yyparse();
}
yyerror(char *s)
{
  printf("error: %s at line %d\n", s,yylineno);
}
