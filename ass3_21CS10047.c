#include <stdio.h>

int main() {
    int token;
    while(token = yylex()) {
        switch(token) {
            case KEYWORD: 
                printf("<KEYWORD, %d, %s>\n", token, yytext); 
                break;
            case IDENTIFIER: 
                printf("<IDENTIFIER, %d, %s>\n", token, yytext); 
                break;
            case CONSTANT_INT: 
                printf("<CONSTANT_INT, %d, %s>\n", token, yytext); 
                break;
            case CONSTANT_FLOAT: 
                printf("<FLOAT_CONSTANT, %d, %s>\n", token, yytext); 
                break;
            case CONSTANT_CHAR: 
                printf("<CONSTANT_CHAR, %d, %s>\n", token, yytext); 
                break;
            case STRING_LITERAL: 
                printf("<STRING_LITERAL, %d, %s>\n", token, yytext); 
                break;
            case PUNCTUATOR: 
                printf("<PUNCTUATOR, %d, %s>\n", token, yytext); 
                break;
            case MULTI_LINE_COMMENT: 
                printf("<MULTI_LINE_COMMENT, %d>\n", token);  
                break;
            case SINGLE_LINE_COMMENT: 
                printf("<SINGLE_LINE_COMMENT, %d>\n", token); 
                break;
            default:
                printf("<INVALID_TOKEN, %d, %s>\n", token, yytext);
                break;
        }
    }
    return 0;
}