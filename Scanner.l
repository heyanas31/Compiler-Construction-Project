%{
#include <stdio.h>
#include <string.h>
FILE *token;
FILE *error; 
int checking(const char *text);
%}

%option yylineno
DIGIT    [0-9]
ID       [a-zA-Z_][a-zA-Z0-9_]*

%%
\n          ;
[ \t]+      ;
"><".*"><"  ;
"//".*      ;

"agr"       { fprintf(token, "Line %d: KEYWORD -> if -> %s\n", yylineno, yytext); }
"wrna"      { fprintf(token, "Line %d: KEYWORD -> else -> %s\n", yylineno, yytext); }
"barbar"    { fprintf(token, "Line %d: KEYWORD -> for -> %s\n", yylineno, yytext); }
"dedo"      { fprintf(token, "Line %d: KEYWORD -> return -> %s\n", yylineno, yytext); }
"darost"    { fprintf(token, "Line %d: KEYWORD -> true -> %s\n", yylineno, yytext); }
"galat"     { fprintf(token, "Line %d: KEYWORD -> false -> %s\n", yylineno, yytext); }
"laina"     { fprintf(token, "Line %d: KEYWORD -> cin -> %s\n", yylineno, yytext); }
"likho"     { fprintf(token, "Line %d: KEYWORD -> cout -> %s\n", yylineno, yytext); }
"rakam"     { fprintf(token, "Line %d: KEYWORD -> int -> %s\n", yylineno, yytext); }
"lafz"      { fprintf(token, "Line %d: KEYWORD -> char -> %s\n", yylineno, yytext); }
"ruko"      { fprintf(token, "Line %d: KEYWORD -> break -> %s\n", yylineno, yytext); }
"khali"     { fprintf(token, "Line %d: KEYWORD -> void -> %s\n", yylineno, yytext); }
"yan"       { fprintf(token, "Line %d: KEYWORD -> or -> %s\n", yylineno, yytext); }
"aur"       { fprintf(token, "Line %d: KEYWORD -> and -> %s\n", yylineno, yytext); }
"ashariya"  { fprintf(token, "Line %d: KEYWORD -> float -> %s\n", yylineno, yytext); }

"*"         { fprintf(token, "Line %d: OPERATOR -> multiply -> %s\n", yylineno, yytext); }
"mult"      { fprintf(token, "Line %d: OPERATOR -> multiply -> %s\n", yylineno, yytext); }
"+"         { fprintf(token, "Line %d: OPERATOR -> addition -> %s\n", yylineno, yytext); }
"add"       { fprintf(token, "Line %d: OPERATOR -> addition -> %s\n", yylineno, yytext); }
"-"         { fprintf(token, "Line %d: OPERATOR -> subtraction -> %s\n", yylineno, yytext); }
"subtract"  { fprintf(token, "Line %d: OPERATOR -> subtraction -> %s\n", yylineno, yytext); }
"!"         { fprintf(token, "Line %d: OPERATOR -> negation -> %s\n", yylineno, yytext); }
"not"       { fprintf(token, "Line %d: OPERATOR -> negation -> %s\n", yylineno, yytext); }
"="         { fprintf(token, "Line %d: OPERATOR -> assignment -> %s\n", yylineno, yytext); }
"=="        { fprintf(token, "Line %d: OPERATOR -> equalto -> %s\n", yylineno, yytext); }
">"         { fprintf(token, "Line %d: OPERATOR -> greater -> %s\n", yylineno, yytext); }
"<"         { fprintf(token, "Line %d: OPERATOR -> lesser -> %s\n", yylineno, yytext); }
"/"         { fprintf(token, "Line %d: OPERATOR -> divide -> %s\n", yylineno, yytext); }
"div"       { fprintf(token, "Line %d: OPERATOR -> divide -> %s\n", yylineno, yytext); }

"("         { fprintf(token, "Line %d: PUNCTUATION -> left-parenthesis -> %s\n", yylineno, yytext); }
")"         { fprintf(token, "Line %d: PUNCTUATION -> right-parenthesis -> %s\n", yylineno, yytext); }
"{"         { fprintf(token, "Line %d: PUNCTUATION -> left-bracket -> %s\n", yylineno, yytext); }
"}"         { fprintf(token, "Line %d: PUNCTUATION -> right-bracket -> %s\n", yylineno, yytext); }
";"         { fprintf(token, "Line %d: PUNCTUATION -> semi-colon -> %s\n", yylineno, yytext); }
","         { fprintf(token, "Line %d: PUNCTUATION -> comma -> %s\n", yylineno, yytext); }

-?{DIGIT}+                      { fprintf(token, "Line %d: integer -> %s\n", yylineno, yytext); }
-?{DIGIT}+"."{DIGIT}+           { fprintf(token, "Line %d: float -> %s\n", yylineno, yytext); }
\"(\\.|[^"\\])*\"               { fprintf(token, "Line %d: string -> %s\n", yylineno, yytext); }
\'[^\\']\'                      { fprintf(token, "Line %d: char -> %s\n", yylineno, yytext); }
\'\\[nt\\\']\'                  { fprintf(token, "Line %d: char -> %s\n", yylineno, yytext); }

{ID}    { 
    if (checking(yytext)) 
    {
        fprintf(error, "Line %d: ERROR -> Invalid identifier '%s'\n", yylineno, yytext);
    } 
    else 
    {
        fprintf(token, "Line %d: identifier -> %s\n", yylineno, yytext);
    }
}

.       { fprintf(error, "Line %d: ERROR -> %s\n", yylineno, yytext); }

%%

int checking(const char *text) 
{
    const char *mywords[] = {"agr", "wrna", "barbar", "dedo", "darost", "galat", "laina", "likho", "rakam", "lafz", "ruko", "khali", "yan", "aur", "ashariya", "mult", "add", "subtract", "not", "div", NULL};
    
    const char **word = mywords;
    while (*word)
    {
        if (strstr(text, *word) != NULL) 
        {
            return 1;
        }
        word++;
    }
    return 0;
}

int main() 
{
    token = fopen("tokens.txt", "w");
    error = fopen("errors.txt", "w");
   
    yylex();
    fclose(token);
    fclose(error);
    return 0;
}