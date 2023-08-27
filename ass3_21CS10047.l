%{
    #define KEYWORD 10
    #define IDENTIFIER 11
    #define CONSTANT_INT 12
    #define CONSTANT_FLOAT 13
    #define CONSTANT_ENUM 14
    #define CONSTANT_CHAR 15
    #define STRING_LITERAL 16
    #define PUNCTUATOR 17
    #define MULTI_LINE_COMMENT 18
    #define SINGLE_LINE_COMMENT 19
    #define INVALID_TOKEN 20
%}

%x MULTI_LINE_COMMENT_BODY
%x SINGLE_LINE_COMMENT_BODY

KEYWORD         "auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"inline"|"int"|"long"|"register"|"restrict"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"|"_Bool"|"_Complex"|"_Imaginary"
PUNCTUATOR      "["|"++"|"/"|"?"|"="|","|"]"|"("|"{"|"}"|"."|"->"|"*"|"+"|"-"|"~"|"!"|"%"|"<<"|">>"|"<"|">"|"<="|">="|":"|";"|"..."|"*="|"/="|"%="|"+="|"-="|"<<="|"#"|"--"|")"|"&"|"=="|"^"|"|"|"&&"|">>="|"!="|"&="|"^="|"||"|"|"

IDENTIFIER      [A-Za-z_][A-Za-z0-9_]*

DIGIT           [0-9]
DIGIT_SEQ       {DIGIT}+
NONZERO_DIGIT   [1-9]
CONSTANT_INT    {NONZERO_DIGIT}{DIGIT}*|"0"
SIGN            [+-]
EXPONENT_PART   [eE]({SIGN}?){DIGIT_SEQ}
CONSTANT_FRAC   {DIGIT_SEQ}?\.{DIGIT_SEQ}|{DIGIT_SEQ}\.
CONSTANT_FLOAT  {CONSTANT_FRAC}({EXPONENT_PART}?)|{DIGIT_SEQ}{EXPONENT_PART}

CONSTANT_ENUM   {IDENTIFIER}

ESCAPE_SEQ      "\\\'"|"\\\""|"\\?"|"\\\\"|"\\a"|"\\b"|"\\f"|"\\n"|"\\r"|"\\t"|"\\v"

C_CHAR          [^\'\n\\]|{ESCAPE_SEQ}
C_CHAR_SEQ      {C_CHAR}+
CONSTANT_CHAR  \'{C_CHAR_SEQ}\'

S_CHAR          [^\"\n\\]|{ESCAPE_SEQ}
S_CHAR_SEQ {S_CHAR}+
STRING_LITERAL  \"({S_CHAR_SEQ}?)\"

WHITESPACE      [ \n\t]

%%

{KEYWORD} { return KEYWORD; }
{IDENTIFIER} { return IDENTIFIER; }
{CONSTANT_INT} { return CONSTANT_INT; }
{CONSTANT_FLOAT} { return CONSTANT_FLOAT; }
{CONSTANT_CHAR} { return CONSTANT_CHAR; }
{STRING_LITERAL} { return STRING_LITERAL; }
{PUNCTUATOR} { return PUNCTUATOR; }

"/*" { BEGIN(MULTI_LINE_COMMENT_BODY); }
<MULTI_LINE_COMMENT_BODY>"*/" { BEGIN(INITIAL); return MULTI_LINE_COMMENT; }
<MULTI_LINE_COMMENT_BODY>. { }
<MULTI_LINE_COMMENT_BODY>"\n" { }

"//" { BEGIN(SINGLE_LINE_COMMENT_BODY); }
<SINGLE_LINE_COMMENT_BODY>"\n" { BEGIN(INITIAL); return SINGLE_LINE_COMMENT; }
<SINGLE_LINE_COMMENT_BODY>. { }

{WHITESPACE} { }
. { return INVALID_TOKEN; }

%%