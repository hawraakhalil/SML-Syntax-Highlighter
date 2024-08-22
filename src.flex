%{
    #include <stdio.h>
    FILE* outFile;  

    void printKeyword(const char* s) {
        fprintf(outFile, "<span style=\"color:#a0a000;\">%s</span>", s);
    }
    void print_BuiltIn(const char* s) {
        fprintf(outFile, "<span style=\"color:#00c000;\">%s</span>", s);
    }
    void print_Literals(const char* s) {
        fprintf(outFile, "<span style=\"color:#ff0000;\">%s</span>", s);
    }
    void print_Upper_Identifiers(const char* s) {
        fprintf(outFile, "<span style=\"color:#ff00ff;\">%s</span>", s);
    }
    void print_Lower_Identifiers(const char* s) {
        fprintf(outFile, "<span>%s</span>", s);
    }
    void print_Operators(const char* s) {
        fprintf(outFile, "<span style=\"color:#0000ff;\">%s</span>", s);
    }

    void print_Space (const char*s) {
         fprintf(outFile, s);
    }


%}


%%

    /* Rules for keywords */
val|datatype|of|fun|let|in|end|if|then|else|orelse|andalso|case  printKeyword(yytext);


    /* Rules for built-in types */
int|bool|string     print_BuiltIn(yytext);


    /* Rule for integer and boolean literals */
-?[0-9]+          print_Literals(yytext);
true|false        print_Literals(yytext);


    /* Rule for identifiers */
[A-Z][a-zA-Z_0-9]*     print_Upper_Identifiers(yytext);
[a-z_][a-zA-Z_0-9]*    print_Lower_Identifiers(yytext);


    /* Rules for operators and separators */
"+"|"-"|"*"|"|"|"=>"|"<="|">="|"="|"<"|">"|"::"|":"|"."|"["|"]"|","|"("|")"|";"    print_Operators(yytext);



    /* Rule for string literal */
    /* Hint: you can call input() to read the next character in the stream */
["]  {
        fprintf(outFile, "<span style=\"color: #ff0000;\">%s", yytext);
        char c = input();
        while (c != EOF) {
            if (c == '\\') {
                 fputc(c, outFile);
                c = input();
                if (c != EOF) {
                    fputc(c, outFile);
                    c = input();
                }
            }
            else if (c == '"' ) {
                    fputc(c, outFile);
                    fprintf(outFile, "</span>");
                    break;
                }
            else {
                    fputc(c, outFile);
                    c = input();
                }
            }
        }

    /* Rule for comment */
    /* Hint: you can call input() to read the next character in the stream */
    /* Hint: you can call unput(char) to return a character to the stream after reading it */

"(*" {
        fprintf(outFile, "<span style=\"color: #00aaff;\">%s", yytext);
        char c;
        while ((c = input()) != EOF) {
            fputc(c, outFile);
            if (c == '*') {
                c = input();
                if (c == ')') {
                    fputc(c, outFile);
                    fprintf(outFile, "</span>");
                    break;
                }
                else {
                    unput(c);
                }
            }
        }
    }

    /* Rule for whitespace */
[ ]            print_Space("&nbsp;");
[\t]           print_Space("&nbsp;&nbsp;&nbsp;&nbsp;");
[\n]           print_Space("<br>\n");
[\r]           print_Space("<br>\n");



    /* Catch unmatched tokens */
.               fprintf(stderr, "INVALID TOKEN: %s\n", yytext);

%%

int main(int argc, char** argv) {
    const char* inFileName = (argc > 1)?argv[1]:"test.sml";
    const char* outFileName = (argc > 2)?argv[2]:"test.html";
    yyin = fopen(inFileName, "r");
    outFile = fopen(outFileName, "w");
    fprintf(outFile, "<html>\n<body><tt>\n");
    yylex();
    fprintf(outFile, "</body>\n</html></tt>\n");
    fclose(yyin);
    fclose(outFile);
    return 0;
}
int yywrap() {
    return 1;
}

