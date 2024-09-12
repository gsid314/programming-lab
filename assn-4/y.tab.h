/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    PROGRAM = 258,
    VAR = 259,
    BEGIN = 260,
    INTEGER = 262,
    REAL = 263,
    NUM = 264,
    NUM_REAL = 265,
    ID = 266,
    READ = 267,
    WRITE = 268,
    DO = 269,
    FOR = 270,
    TO = 271,
    END = 272,
    EOL = 273,
    ADD = 274,
    MINUS = 275,
    MUL = 276,
    COMMA = 277,
    SEMICOLON = 278,
    COLON = 279,
    ASSIGN = 280,
    OPEN_PAREN = 281,
    CLOSE_PAREN = 282
  };
#endif
/* Tokens.  */
#define PROGRAM 258
#define VAR 259
#define BEGIN 260
#define INTEGER 262
#define REAL 263
#define NUM 264
#define NUM_REAL 265
#define ID 266
#define READ 267
#define WRITE 268
#define DO 269
#define FOR 270
#define TO 271
#define END 272
#define EOL 273
#define ADD 274
#define MINUS 275
#define MUL 276
#define COMMA 277
#define SEMICOLON 278
#define COLON 279
#define ASSIGN 280
#define OPEN_PAREN 281
#define CLOSE_PAREN 282

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
