import java_cup.runtime.*;

%%

%class Lexer
%unicode
%cup
%line
%column
id=[\_a-zA-Z][\_a-zA-Z0-9]*
int= [+-]? [0-9] | [1-9][0-9]*
double = [+-]? ((([0-9]+\.[0-9]*) | ([0-9]*\.[0-9]+)) (e|E('+'|'-')?[0-9]+)?)
string= \"[a-zA-Z0-9\_]*\"
stringInterpolationStart=\"[^\"\(\)]*\\\(
stringInterpolationIntermediate=\)[^\"\(\)]*\\\(
stringInterpolationEnd=\)[^\"\(\)]*\"
nl = \r|\n|\r\n
ws = [ \t]
%{
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
	
  }
%}
%%
"+" { return symbol(sym.PLUS); }
"*" { return symbol(sym.MUL); }
"/" { return symbol(sym.DIV); }
"-" { return symbol(sym.MINUS); }
{double} { System.out.println("SCANNER :: DOUBLE found: "+yytext());return symbol(sym.DOUBLEVAL,new Double(yytext())); }
{int} { System.out.println("SCANNER :: INT found: "+yytext());return symbol(sym.INTVAL,new Integer(yytext())); }
{string} { return symbol(sym.STRINGVAL,yytext().substring(1,yytext().length()-1)); }
{stringInterpolationStart} { System.out.println("SCANNER :: STRINGVALSTART found: "+yytext().substring(1,yytext().length()-2));return symbol(sym.STRINGVALS,yytext().substring(1,yytext().length()-2)); }
{stringInterpolationIntermediate} { System.out.println("SCANNER :: STRINGVALINTERMEDIATE found: "+yytext().substring(1,yytext().length()-2));return symbol(sym.STRINGVALI,yytext().substring(1,yytext().length()-2)); }
{stringInterpolationEnd} { System.out.println("SCANNER :: STRINGVALEND found: "+yytext().substring(1,yytext().length()-1));return symbol(sym.STRINGVALE,yytext().substring(1,yytext().length()-1)); }
"inout" { return symbol(sym.INOUT); }
"class" { return symbol(sym.CLASS); }
"String" { return symbol(sym.STRING); }
"Double" { return symbol(sym.DOUBLE); }
"Int" { return symbol(sym.INT); }
"let" { return symbol(sym.LET); }
"var" { return symbol(sym.VAR); }
"func" { System.out.println("SCANNER :: FUNC found");return symbol(sym.FUNC); }
"->" { System.out.println("SCANNER :: -> found");return symbol(sym.ARROW); }
"for" { return symbol(sym.FOR); }
"while" { return symbol(sym.WHILE); }
"in" { return symbol(sym.IN); }
"if" { return symbol(sym.IF); }
"else if" { return symbol(sym.ELIF); }
"else" { return symbol(sym.ELSE); }
"," { return symbol(sym.C); }
"=" { return symbol(sym.EQ); }
":" { return symbol(sym.COL); }
"(" { System.out.println("SCANNER :: ( found");return symbol(sym.BO); }
")" { System.out.println("SCANNER :: ) found");return symbol(sym.BC); }
"{" { System.out.println("SCANNER :: { found");return symbol(sym.GO); }
"}" { System.out.println("SCANNER :: } found");return symbol(sym.GC); }
"==" { return symbol(sym.EQUAL); }
">" { return symbol(sym.GREATER); }
">=" { return symbol(sym.GREATEREQ); }
"<" { return symbol(sym.LESS); }
"<=" { return symbol(sym.LESSEQ); }
"&&" { return symbol(sym.AND); }
"||" { return symbol(sym.OR); }
"!" { return symbol(sym.NOT); }
"." { System.out.println("SCANNER ::  found");return symbol(sym.DOT); }
"[" { return symbol(sym.QO); }
"]" { return symbol(sym.QC); }
"_" { System.out.println("SCANNER :: _ found");return symbol(sym.USCORE); }
{id} { System.out.println("SCANNER :: ID found: "+yytext());return symbol(sym.ID,yytext()); }
{ws}|{nl}       {;}
"/*" ~ "*/"     {;}
. {System.out.println("SCANNER ERROR: "+yytext());}
