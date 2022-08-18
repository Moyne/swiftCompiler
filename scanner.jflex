import java_cup.runtime.*;

%%

%class Lexer
%unicode
%cup
%line
%column
%state STRINGINTERPOLATION
id=[\_a-zA-Z][\_a-zA-Z0-9]*
int=  [0-9] | [1-9][0-9]*
double =  ((([0-9]+\.[0-9]*) | ([0-9]*\.[0-9]+)) (e|E('+'|'-')?[0-9]+)?)
string= \"[a-zA-Z0-9\_]*\"
stringInterpolationStart=\"[^\"\(\)]*\\\(
stringInterpolationIntermediate=\)[^\"\(\)]*\\\(
stringInterpolationEnd=\)[^\"\(\)\r\n\t]*\"
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
{double} { return symbol(sym.DOUBLEVAL,new Double(yytext())); }
{int} { return symbol(sym.INTVAL,new Integer(yytext())); }
{string} { return symbol(sym.STRINGVAL,yytext().substring(1,yytext().length()-1).replace("\n","\\"+"0A")); }
{stringInterpolationStart} { yybegin(STRINGINTERPOLATION);return symbol(sym.STRINGVALS,yytext().substring(1,yytext().length()-2).replace("\n","\\"+"0A")); }
<STRINGINTERPOLATION> {stringInterpolationIntermediate} { return symbol(sym.STRINGVALI,yytext().substring(1,yytext().length()-2).replace("\n","\\"+"0A")); }
<STRINGINTERPOLATION> {stringInterpolationEnd} { yybegin(YYINITIAL);return symbol(sym.STRINGVALE,yytext().substring(1,yytext().length()-1).replace("\n","\\"+"0A")); }
"print" { return symbol(sym.PRINT); }
"inout" { return symbol(sym.INOUT); }
"String" { return symbol(sym.STRING); }
"Double" { return symbol(sym.DOUBLE); }
"Int" { return symbol(sym.INT); }
"let" { return symbol(sym.LET); }
"var" { return symbol(sym.VAR); }
"func" { return symbol(sym.FUNC); }
"->" { return symbol(sym.ARROW); }
"for" { return symbol(sym.FOR); }
"while" { return symbol(sym.WHILE); }
"in" { return symbol(sym.IN); }
"if" { return symbol(sym.IF); }
"else if" { return symbol(sym.ELIF); }
"else" { return symbol(sym.ELSE); }
"break" { return symbol(sym.BREAK); }
"continue" { return symbol(sym.CONTINUE); }
"return" { return symbol(sym.RETURN); }
"," { return symbol(sym.C); }
"=" { return symbol(sym.EQ); }
":" { return symbol(sym.COL); }
"(" { return symbol(sym.BO); }
")" { return symbol(sym.BC); }
"{" { return symbol(sym.GO); }
"}" { return symbol(sym.GC); }
"==" { return symbol(sym.EQUAL); }
">" { return symbol(sym.GREATER); }
">=" { return symbol(sym.GREATEREQ); }
"<" { return symbol(sym.LESS); }
"<=" { return symbol(sym.LESSEQ); }
"&&" { return symbol(sym.AND); }
"&" { return symbol(sym.DEREF); }
"||" { return symbol(sym.OR); }
"!" { return symbol(sym.NOT); }
"." { return symbol(sym.DOT); }
"[" { return symbol(sym.QO); }
"]" { return symbol(sym.QC); }
"_" { return symbol(sym.USCORE); }
{id} { return symbol(sym.ID,yytext()); }
{ws}|{nl}       {;}
"/*" ~ "*/"     {;}
. {System.out.println("SCANNER ERROR: "+yytext());}
