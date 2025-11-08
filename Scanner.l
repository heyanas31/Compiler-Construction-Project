%{
#include <stdio.h>
int line_num = 1;
%}

DIGIT    [0-9]
ID       [a-zA-Z_][a-zA-Z0-9_]*

%%

\n        { line_num++; }
[ \t]+    ;

"><".*"><"    ;  /* Ignore custom comments */
"//".*        ;  /* Ignore single line comments */

"agr"       { printf("Line %d: KEYWORD_IF -> %s\n", line_num, yytext); }
"wrna"      { printf("Line %d: KEYWORD_ELSE -> %s\n", line_num, yytext); }
"barbar"    { printf("Line %d: KEYWORD_FOR -> %s\n", line_num, yytext); }
"dedo"      { printf("Line %d: KEYWORD_RETURN -> %s\n", line_num, yytext); }
"darost"    { printf("Line %d: KEYWORD_TRUE -> %s\n", line_num, yytext); }
"galat"     { printf("Line %d: KEYWORD_FALSE -> %s\n", line_num, yytext); }
"laina"     { printf("Line %d: KEYWORD_CIN -> %s\n", line_num, yytext); }
"likho"     { printf("Line %d: KEYWORD_COUT -> %s\n", line_num, yytext); }
"rakam"     { printf("Line %d: KEYWORD_INT -> %s\n", line_num, yytext); }
"lafz"      { printf("Line %d: KEYWORD_CHAR -> %s\n", line_num, yytext); }
"ruko"      { printf("Line %d: KEYWORD_BREAK -> %s\n", line_num, yytext); }
"khali"     { printf("Line %d: KEYWORD_VOID -> %s\n", line_num, yytext); }
"yan"       { printf("Line %d: KEYWORD_OR -> %s\n", line_num, yytext); }
"aur"       { printf("Line %d: KEYWORD_AND -> %s\n", line_num, yytext); }
"ashariya"  { printf("Line %d: KEYWORD_FLOAT -> %s\n", line_num, yytext); }

"*"     { printf("Line %d: OPERATOR_MULTIPLY -> %s\n", line_num, yytext); }
"+"     { printf("Line %d: OPERATOR_ADDITION -> %s\n", line_num, yytext); }
"-"     { printf("Line %d: OPERATOR_SUBTRACT -> %s\n", line_num, yytext); }
"!"     { printf("Line %d: OPERATOR_NEGATION -> %s\n", line_num, yytext); }
"="     { printf("Line %d: OPERATOR_ASSIGNMENT -> %s\n", line_num, yytext); }
"=="    { printf("Line %d: OPERATOR_EQUALTO -> %s\n", line_num, yytext); }
">"     { printf("Line %d: OPERATOR_GREATER -> %s\n", line_num, yytext); }
"<"     { printf("Line %d: OPERATOR_LESSER -> %s\n", line_num, yytext); }
"/"     { printf("Line %d: OPERATOR_DIVIDE -> %s\n", line_num, yytext); }

"("     { printf("Line %d: PUNC_LEFTPARENTHESIS -> %s\n", line_num, yytext); }
")"     { printf("Line %d: PUNC_RIGHTPARENTHESIS -> %s\n", line_num, yytext); }
"{"     { printf("Line %d: PUNC_LEFTBRACKET -> %s\n", line_num, yytext); }
"}"     { printf("Line %d: PUNC_RIGHTBRACKET -> %s\n", line_num, yytext); }
";"     { printf("Line %d: PUNC_SEMICOLON -> %s\n", line_num, yytext); }

{ID}        { printf("Line %d: IDENTIFIER -> %s\n", line_num, yytext); }
{DIGIT}+    { printf("Line %d: INTEGER -> %s\n", line_num, yytext); }
{DIGIT}+"."{DIGIT}+  { printf("Line %d: FLOAT -> %s\n", line_num, yytext); }
\"([^"\\]|\\[\\"tn])*\"  { printf("Line %d: STRING -> %s\n", line_num, yytext); }
\'[^']\'    { printf("Line %d: CHAR -> %s\n", line_num, yytext); }

.           { printf("Line %d: ANY ERROR -> %s\n", line_num, yytext); }

%%

int main() {
    yylex();
    return 0;
}