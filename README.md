# From Swift to LLVM with JFlex and Cup
## Background
This report analyzes some details of a compiler built to recognize some of the features of the Swift programming language and create some LLVM IR code, this intermediate rappresentation is between the source code and machine code, it is used by the backend, in our case LLVM, to generate code independent from the machine used.

Swift is a compiled language developed by Apple, it is derivative from Objective C, and puts its focus into memory safety and type safety, it is very powerful thanks to a high degree of optimization during the compiling phase, it also provides a lot of features familiar to us like classes, generics and other high level abstractions, to declare a variable we use the ''**var**'' keyword, while for a constant we use the ''**let**'' keyword, we can declare a variable directly doing something like this ''**var a=2**'', in this way the compiler infer the type of the variable a from the expression associated, but we can also declare a variable with type annotation, to decide clearly the type in the following way ''**var a : Int**'', this was a quick introduction to some basics of the language, to check more about the Swift programming language you can find here its documentation : [[https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html]] .

## Implemented parts

Here follows the list of parts of the Swift programming language recognized by the compiler:
- Data types:
- - basic data types:
- - - Int
- - - Double
- - - String
- - - - Strings accept string interpolation
- - aggregate data types:
- - - Arrays
- - - - Multidimensional arrays of homogenous type
- Variables
- - global variables
- - - declaration only specifying only the type(for arrays an initiliazition with the declaration is needed because otherwise that variable is unusable)
- - - declaration and assignment with type annotation
- - - direct initialization
- - local variables
- - - declaration only specifying only the type(for arrays an initiliazition with the declaration is needed because otherwise that variable is unusable)
- - - declaration and assignment with type annotation
- - - direct initialization
- Constants
- - global constants
- - -declaration only specifying only the type(for arrays an initiliazition with the declaration is needed because otherwise that variable is unusable)
- - - declaration and assignment with type annotation
- - - direct initialization
- - local constants
- - - declaration only specifying only the type(for arrays an initiliazition with the declaration is needed because otherwise that variable is unusable)
- - - declaration and assignment with type annotation
- - - direct initialization
- Functions
- - support parameter list
- - - any data type is supported, also multidimensional arrays through a specific mechanism added where if a function require an array of n dimensions, the functions will need n-1 additional parameters that specify the size of those dimensions
- - - inout parameters are supported so a function can modify a variable
- - return type
- - - void but void doesn't need a return in that case
- - - other primitive data types like Int, Double, String
- Output
- - print
- - - print of swift that accept a list of parameters that will be printed separetely with a space, strings accept string interpolation also here
- - - println
- - - print of swift that accept a list of parameters that will be printed separetely with a space, then after the parameter list a new line will be printed, strings accept string interpolation also here
- operators
- - arithmetic operators
- - - sum +
- - - - Accepted also with strings, string concatenation is supported
- - - subtraction -
- - - multiplication   *
- - - division /
- - bitwise operators
- - - and &
- - - or |
- - - not ~
- - - xor ^
- - relational operators(also between strings)
- - - equal ==
- - - not equal !=
- - - greater   *
- - - graeter or equal   *=
- - - less <
- - - less or equal <=
- - logical operators
- - - and &&
- - - or ||
- - assignment operators
- - - simple assignment =
- - - assign and increment +=
- - - - Accepted also with strings, string concatenation is supported
- - - assign and decrement -=
- - - assign and multiply   *=
- - - assign and divide /=
- control statement
- - for in loop
- - - for i in [integer value,constant or variable] [...,..<] [integer value,constant or variable]
- - while loop
- - if statements
- - - if elif1... elifN else supported
- - - if elif else supported
- - - if else supported
- - - if alone supported
- Instructions
- - Declaration
- - Assignment
- - - Can assign any primitive data type but not arrays(except in their declaration)
- - Return statements
- - - Return alone
- - - Return exp ,with an expression
- - Functions
- - Break instruction if we are in a while or for loop
- - Continue instruction if we are in a while or for loop
- - Expression

## Compiler

The compiler is made of two main parts, the scanner and the parser, the scanner is built thanks to JFlex and the parser through Cup.

### Scanner

The scanner is built with the Jflex tool, its role is to scan an input file(our source code), read a set of characters that matches one of the rules given and generate a list of tokens that will be received and handled after by our parser.
In our case we want to match the symbols in the Swift programming language.

#### Snippet of the Swift scanner

<code none[enable_line_numbers="true"]>
%state STRINGINTERPOLATION
id=[\_a-zA-Z][\_a-zA-Z0-9]*
int=  [0-9] | [1-9][0-9]*
double =  ((([1-9][0-9]*\.[0-9]+ ) | (0\.[0-9]+)) (e|E('+'|'-')?[0-9]+)?)
string= \"([^\"\\]|(\\n))*\"
stringInterpolationStart=\"([^\"\\]|(\\n))*\\\(
stringInterpolationIntermediate=\)([^\"\\]|(\\n))*\\\(
stringInterpolationEnd=\)([^\"\\]|(\\n))*\"
nl = \r|\n|\r\n
ws = [ \t]
%%
...
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
...
"for" { return symbol(sym.FOR); }
"while" { return symbol(sym.WHILE); }
"in" { return symbol(sym.IN); }
"if" { return symbol(sym.IF); }
"else if" { return symbol(sym.ELIF); }
...
"_" { return symbol(sym.USCORE); }
{id} { return symbol(sym.ID,yytext()); }
{ws}|{nl}       {;}
"/*" ~ "*/"     {;}
. {System.out.println("SCANNER ERROR: "+yytext());}
</code>

The first section is the declaration section, here there are defined some regular expression that can be used inside rules, for example one declaration is about doubles, they can be matched if there is a digit bigger than 0 followed by a list of digits from 0 to 9 then followed by a dot and a list of digits then this number can be followed by an exponential.

After the %% we can find the rules section, here when a rule is matched an action is performed, in the double case when that declaration is matched we transform that double into a //DOUBLEVAL// symbol.

Other rules can be matched, here above the most important ones are shown, an important one is a rule about string interpolations, in that case two rules, one for a intermediate part of a string that has an interpolation inside, and one used when we reach the end of string are used only when an exclusive state is activated, this state is called STRINGINTERPOLATION and it is activated by the first part of the string that notes that the specific strings has at least one interpolation inside.

Other rules are used to match simple keywords used in Swift like func, var, let etc. and transform them into symbols.

### Parser 

The parser is the second part of the compiler developed, its jobe is the one to take as an input from the scanner a stream of symbols and put them together following some grammar rules defined, and if an action is associated to that grammar rule execute it as well.

Here follows an example of how this process works:
<code Swift> var x,y,z : Int = 3 </code>
This code is turned by the scanner into the following tokens : ''**VAR ID C ID C ID COL INT EQ INTVAL**'' .

Here follows a snippet of the rules that helps the parser match this Swift declaration.
<code>
DEC::= LET IDlist TYPE | VAR IDlist TYPE | LET IDINITlist | VAR IDINITlist;
IDlist::= IDlist C ID | ID ; //this is used for type annotations
IDINITlist::= IDINITlist C INIT | INIT;
INIT::= ID EQ EXP | ID EQ ARRVALE; //this is for direct initializations
TYPE::= COL Tlist | COL TList EQ VAL | COL TList EQ MINUS VAL | COL TList EQ ARRVALE;
TList::= QO TList QC | T;
T::= STRING | DOUBLE | INT;
VAL::= DOUBLEVAL | INTVAL | STR;
</code>
In this case ID is reduced into IDlist, then IDlist C ID is reduced into IDlist, this happens another time and then INT is reduced into T that is immediately reduced into TList, next follows INTVAL that is reduced into VAL, after this COL TList EQ VAL is reduced into TYPE and after all this sequence of VAR IDlist TYPE is reduced into DEC.

#### Data structures 

In this paragraph the key data structures used to help the parser generate an output are showed and analyzed
<code Java>
    public enum operations{
        ADD,MUL,DIV,SUB,LESS,GRT,LSE,GRE,EQ,NEQ
    };
    public class Scope{
        public HashMap<String,Value> variables;
        public HashMap<String,Value> constants;
        public Scope(){
            this.variables=new HashMap<String,Value>();
            this.constants=new HashMap<String,Value>();
        }
    }
    public class Tuple{
        public Value value;
        public String name;
        public Tuple(String name,Value value){
            this.name=name;
            this.value=value;
        }
    }
    public class Parameter{
        public boolean argLabel;
        public String name;
        public String label;
        public Value type;
        public boolean arrDim=false;
        public Parameter(Value type,String name){
            this.argLabel=false;
            this.name=name;
            this.type=type;
        }
        public Parameter(Value type,String name,String label){
            ...
        }
        ...
    }
    public class Function{
        public String name;
        public String retType;
        public ArrayList<Parameter> pars;
        public StringBuffer functionOutput=new StringBuffer();
        public Scope scope;
        public int regId=0;
        public boolean returned;
        public int arrayNum=0;
        public Function(String name,String retType,ArrayList<Parameter> pars){
            this.name=name;
            this.retType=retType;
            this.pars=pars;
            this.returned=false;
        }
        public Function(String name){
            this.name=name;
        }
        ...
        public String irDec(){
            return retType+" ("+pars.stream().map(e->e.type.irDec()).collect(Collectors.joining(","))+") @"+name;
        }
    }
    public class Attribute{
        public String type;
        public int regId;
        public boolean immediate;
        public Object immediateValue;
        public boolean arrFunc=false;
        public boolean arrVar=false;
        public String associatedVarName;
        public ArrayList<String> dimensions;
        public ArrayList<Integer> dimensionsInt;
        public boolean variable=false;
        public String getRegVariable;
        public Attribute(String type){
            this.type=type;
            this.immediate=false;
        }
        public Attribute(String type,int regId){
            ...
        }
        public Attribute(Object immediateValue,String type){
            ...
        }
        public Attribute(String type,int regId,String associatedVarName){
            ...
        }
        public Attribute(String type,String associatedVarName,int regId,ArrayList<String> dimensions){
            ...
        }
        public Attribute(String type,String associatedVarName,ArrayList<Integer> dimensionsInt,int regId){
            ...
        }
        public Attribute(String type,String getReg,String associatedVarName){
            ...
        }
        public void setReg(int regId){
            this.regId=regId;
        }
        public String getReg(){
            if(this.variable)   return this.getRegVariable;
            if(this.immediate) return this.immediateValue.toString();
            else    return "%"+this.regId;
        }
    }
    public class ArrayDec{
        public String type;
        public ArrayList<Attribute> value;
        public ArrayList<ArrayDec> arraysInside;
        public boolean closed;
        public boolean last;
        public boolean allImmediates;
        public ArrayDec(String type,ArrayList<Attribute> value,boolean closed,boolean allImmediates){
            this.type=type;
            this.value=value;
            this.closed=closed;
            this.last=true;
            this.allImmediates=allImmediates;
        }
        public ArrayDec(ArrayList<ArrayDec> arraysInside,String type,boolean closed,boolean allImmediates){
            ...
        }
        public void close(){
            this.type="["+arraysInside.size()+" x "+this.type+"]";
            this.closed=true;
        }
        public int level(){
            if(this.last) return 1;
            else return this.arraysInside.get(0).level();
        }
        public String printValue(String type){
            ...
        }
        public String getBaseType(){
            if(this.last) return this.value.get(0).type;
            else return this.arraysInside.get(0).getBaseType();
        }
        public ArrayList<Integer> getDimensions(){
            ...
        }
    }
    public class Value{
        public boolean integer=false,str=false,array=false,doub=false,funcPar=false,inoutPar=false,global=false;
        public boolean initialized,primitive;
        public int sizeInt=0,pointerAllocated=(-1);
        public String name;
        public ArrayList<String> dimensionsParameters=new ArrayList<String>();
        public ArrayList<Integer> dimensions=new ArrayList<Integer>();
        public Object immediateInitialization;
        //copy of already existing value
        public Value(Value o){
            ...
        }
        public Value(String type){
            if(type.equals("i32")){
                this.integer=true;
                this.sizeInt=32;
                this.primitive=true;
            }
            else if(type.equals("double")){
                this.doub=true;
                this.primitive=true;
            }
            else if(type.equals("i8*")){
                this.str=true;
                this.primitive=false;
            }
        }
        public Value(int intSize){
            ...
        }
        public Value(boolean str){
            ...
        }
        ...
        public void addArrLevel(){
            if(!this.array){
                this.array=true;
                this.dimensions=new ArrayList<Integer>();
                this.dimensions.add(10);
            }
            else this.dimensions.add(10);
        }
        public void addArrLevel(int i){
            if(!this.array){
                this.array=true;
                this.dimensions=new ArrayList<Integer>();
                this.dimensions.add(i);
            }
            else this.dimensions.add(i);
        }
        public void addFunctionDimension(String x){
            this.dimensionsParameters.add(x);
        }
        public boolean equal(Value o){
            return this.irDec().equals(o.irDec());
        }
        public String getBaseType(){
            if(this.str) return "i8*";
            else if(this.integer) return "i"+this.sizeInt;
            else if(this.doub) return "double";
            else return "ERROR";
        }
        ...
        public String getReg(){
            if(this.global) return "@"+this.name;
            else return "%"+this.pointerAllocated;
        }
        public String irDec(){
            if(this.array){
                if(this.funcPar)    return this.getBaseType()+"*";
                else{
                    StringBuffer res=new StringBuffer();
                    for(int i=0;i<this.dimensions.size();i++){
                        res.append("["+this.dimensions.get(i)+" x ");
                        if(i==this.dimensions.size()-1){
                            res.append(this.getBaseType());
                            for(int j=0;j<=i;j++) res.append("]");
                        }
                    }
                    return res.toString();
                }
            }
            else{
                if(this.funcPar && this.inoutPar && !this.str) return this.getBaseType()+"*";
                else return this.getBaseType();
            }
        }
        public boolean inoutNeedsDeref(){
            return this.funcPar && this.inoutPar && this.primitive && !this.array;
        }
        ...
    }
    //list of variables used
    public ArrayList<Scope> scopes;
    public StringBuffer outputBuffer;
    public StringBuffer errorBuffer;
    public StringBuffer globalBuffer;
    public StringBuffer globalInitializations;
    public int globalInitializationsId;
    public int errors;
    public int semErrors;
    public int synErrors;
    public HashMap<String,Function> functions;
    public int regid;
    public int stringIndex;
    public boolean inFunction;
    public String functionName;
    public int currentIf;
    public int currentFor;
    public boolean inConditional;
    public ArrayList<String> callingFunction;
    public ArrayList<Integer> callingFunctionPar;
    public ArrayList<Integer> forloops;
</code>
The variables used by the parser are the following:
  * ''scopes'' -> this variable is a list of all the active scopes in that specific moment, a scope is generated by a function or a control block like an if, this variable is initialized inserting a new scope that acts as the global scope, this variable is very useful so when a variable is needed we search in the ones that are in one of the scopes in the scope list
  * ''outputBuffer'' -> this variable is a string that has the LLVM IR code that will be the output if no error is present
  * ''errorBuffer'' -> this variable contains all the error messages that may appear during the parsing
  * ''globalBuffer'' -> this variable contains all the global initializations and dependency declarations
  * ''globalInitializations'' -> this variable is used when we do a global declaration of a string or array of strings, these initializations are done in a function called before of the start of the main
  * ''errors'' -> this variable is a counter of all of the errors matched at that time
  * ''semErrors'' -> this variable serves as a counter for all the semantic errors
  * ''synErrors'' -> this variable serves as a counter for all the syntax errors
  * ''functions'' -> this variable is a map of all the function declared at that point, so if there is a call to a function that is not declared we can catch a semantic error
  * ''stringIndex'' -> this variable is the index of the next string that will be declared
  * ''inFunction'' -> this is a boolean that checks if we are currently in a function or not
  * ''functionName'' -> this is the name of the current function
  * ''currentIf'' -> this variable contains the index of the following if block
  * ''currentFor'' -> this variable contains the index of the following while or for block
  * ''inConditional'' -> this is a boolean that checks if we are currently inside a while or for block, so if a break or continue statement appears we can check that semantic error
  * ''callingFunction'' -> this is a list of strings of the nested list of function calls, so if we have something like foo(foo(add(1,3),4),6) we can check if the one in our level at that time has the right parameters, so if the parser is parsing add(1,3) it can checks that 1 and 3 are of the right types that add requires
  * ''callingFunctionPar'' -> this variable is used with the former one, this is a list of counters of the parameter to be checked
  * ''forLoops'' -> this variable is used to keep track of nested for or while loops

The following are the structures used by the parser:
  * ''operations'' -> this is an enumeration useful to keep track of the available operations, so it makes adding new operations quite easy
  *  ''Scope'' -> this is a class useful to keep track of the variables and contants in a specific scope block
  *  ''Tuple'' -> this is a class used internally by the parser to keep track of a pair value and id to create a list of variables or constants, and also is used to get the variable and constant required and understanding if it was a variable or a constant
  *  ''Parameter'' -> this is a class, like the name suggest, used to keep track of parameter informations like label name etc.
  *  ''Function'' -> this is a class that is the key structure to represent a function, it holds informations regarding the return type, its parameters and much more
  *  ''Attribute'' -> this is probably the most used class, it is involved in any expression, so it holds informations about the llvm ir register id it use, its type, if the value it represents is an immediate it holds its value, or if the value it holds is an array it holds useful informations about that array
  *  ''ArrayDec'' -> this class is used when defining an array, so it has inside a list of ArrayDec or Attribute so we can initialize the variable or constant with this array
  *  ''Value'' -> finally the class that represents variables and constants, it holds information about the type of the variable/constant, the pointer id of allocation used in llvm ir to read it and use it as an attribute and other useful information

Following there are a few example to analyze better how some pieces of the parser work and how the output is generated
==== Grammar start ====
The grammar start symbol is PROG and represents a list of statements, statements that are separated by either a new line or a semicolon ;, that is reduced to PROG when the file is completed, these statement can be either function, a declaration or an assignment or any base statement like a function call, a return, a break or continue .
<code Java>
PROG::= STMS {: ... ; :} ;
STMS::= STMS STM | ;
STM::=BASESTM SEP | NL | FUNCTION | error SEP {: ... ; :};
BASESTM::= ASS | PROC | DEC | RET | BREAK {: ... ; :} | CONTINUE {: ... ; :} | error BASESTM {: ... ; :};
</code>

#### Functions and arrays 

The functions are handled thanks to the non terminals FUNCDef and FUNCTION, FUNCDef is the symbol used to match the definition of the function so it matches the keyword func the name of the function, its parameter and the return value expected, while FUNCTION matches a FUNCDef symbol and a list of functional statements inside graphs {}.

Parameters are recognized thanks to the symbol PARElist that rappresent a list that can be empty or not, in the last case the symbol PARlist is reduced into PARElist, a parameter is represented by the symbol PAR that exploits the symbol FTYPE, a symbol quite similar to the TYPE symbol but that provides also the possibility to understand if a parameter is of the inout type.

<code Java>
FUNCTION::=FUNCDef:f GO FSTMTS GC {:
    if(f!=null){
        if(!f.returned){
            if(f.retType.equals("void"))    f.functionOutput.append("\nret void");
            else    semError("Didn't have a return statement and function isn't of type void");
        }
        else{
            if(f.retType.equals("i32")) f.functionOutput.append("\nret i32 -1");
            else if(f.retType.equals("double"))  f.functionOutput.append("\nret double -1.0");
            else if(f.retType.equals("i8*"))    f.functionOutput.append("\nret i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0)");
            else f.functionOutput.append("ret void");
        }
        outputBuffer.append("{"+f.functionOutput+"\n}");
        inFunction=false;
        functionName=null;
        scopes.remove(scopes.size()-1);
    }
:};
FUNCDef::=FUNC ID:name {:
    inFunction=true;
    functionName=name;
    Function f=new Function(name);
    functions.put(name,f);
:} BO PARElist:l BC RETVAL:r{:
    Function f=functions.get(name);
    outputBuffer.append("\ndefine "+r+" @"+name+" ("+l.stream().map(e->e.type.irDec()+" %"+e.name).collect(Collectors.joining(","))+")");
    if(r.equals("i8*")){
        //this is done so if the user tries to return a string variable we won't have any memory problem because we'll copy what he wants in a global buffer accessible from also outside the function
        globalBuffer.append("\n@.str."+name+".ret.arr = global [200 x i8] zeroinitializer");
        globalBuffer.append("\n@.str."+name+".ret = global i8* getelementptr inbounds([200 x i8],[200 x i8]* @.str."+name+".ret.arr,i32 0,i32 0)");
    }
    f.setPars(l);
    f.setRet(r);
    f.scope=new Scope();
    scopes.add(f.scope);
    if(name.equals("main")) f.functionOutput.append("\ncall void () @globalinit()");
    l.stream().filter(e->!e.arrDim).forEach(e->{
        if(!e.type.inoutNeedsDeref()){
            f.functionOutput.append("\n%"+(++f.regId)+" = alloca "+e.type.irDec());
            Value v=new Value(e.type);
            v.setReg(f.regId);
            f.functionOutput.append("\nstore "+e.type.irDec()+" %"+e.name+", "+e.type.irDec()+"* %"+f.regId);
            if(!f.scope.constants.containsKey(e.name) && !f.scope.variables.containsKey(e.name)){
                if(e.type.inoutPar) f.scope.variables.put(e.name,v);
                else    f.scope.constants.put(e.name,v);
            }
            else semError("Parameter with the same name already declared");
        }
        else{
            f.functionOutput.append("\n%"+(++f.regId)+" = alloca "+e.type.irDec());
            int reg=f.regId;
            f.functionOutput.append("\nstore "+e.type.irDec()+" %"+e.name+", "+e.type.irDec()+"* %"+f.regId);
            f.functionOutput.append("\n%"+(++f.regId)+" = load "+e.type.irDec()+","+e.type.irDec()+"* %"+reg);
            if(!f.scope.constants.containsKey(e.name) && !f.scope.variables.containsKey(e.name)){
                Value v=new Value(e.type);
                v.setReg(f.regId);
                f.scope.variables.put(e.name,v);
            }
            else semError("Parameter with the same name already declared");
        }
    });
    RESULT=f;
:} ... ;
RETVAL::=ARROW T:t {:RESULT=t.irDec();:}| {:RESULT="void";:};

PARElist::=PARlist:l {:RESULT=l;:} | {:RESULT=new ArrayList<Parameter>();:};

PARlist::= PARlist:l C PAR:p {:
    l.add(p);
    if(p.type.array){
        int dim=p.type.dimensions.size();
        for(int i=0;i<dim-1;i++){
            Value x=new Value(32);
            x.setInout(false);
            x.initialized=true;
            Parameter pfor=new Parameter(x,"dim."+functions.get(functionName).arrayNum+"."+i);
            pfor.setArrayDim();
            l.add(pfor);
            p.type.addFunctionDimension("dim."+functions.get(functionName).arrayNum+"."+i);
        }
        if(dim>1) functions.get(functionName).arrayNum++;
    }
    RESULT=l;
:}| PAR:p {:
    ArrayList<Parameter> l=new ArrayList<Parameter>();
    l.add(p);
    if(p.type.array){
        int dim=p.type.dimensions.size();
        for(int i=0;i<dim-1;i++){
            Value x=new Value(32);
            x.setInout(false);
            x.initialized=true;
            Parameter pfor=new Parameter(x,"dim."+functions.get(functionName).arrayNum+"."+i);
            pfor.setArrayDim();
            l.add(pfor);
            p.type.addFunctionDimension("dim."+functions.get(functionName).arrayNum+"."+i);
        }
        if(dim>1) functions.get(functionName).arrayNum++;
    }
    RESULT=l;
:} ... ;
PAR::= ID:label ID:name FTYPE:f {:RESULT=new Parameter(f,name,label);:}| ID:name FTYPE:f {:RESULT=new Parameter(f,name,name);:}| USCORE ID:name FTYPE:f{:RESULT=new Parameter(f,name);:};
 
FTYPE::= COL INOUTF:i TList:t {:t.setInout(i);t.initialized=true;RESULT=t;:};

TList::= QO TList:t QC {:
    t.addArrLevel();
    RESULT=t;
:}| T:t {:RESULT=t;:} ... ;

T::=STRING {:RESULT=new Value(true);:}| DOUBLE {:RESULT=new Value(false);:}| INT{:RESULT=new Value(32);:} ;

INOUTF::=INOUT {:RESULT=true;:} | {:RESULT=false;:};
</code>
So let's check an example of that works for then generating an output.

If we have something like this:<code Swift>func binarySearch(_ arr : [Int],_ search: Int,_ low: Int,_ high: Int) -> Int {...}</code>
The scanner will transform this in a set of tokens like the following one : ''**FUNC ID BO USCORE ID COL QO INT QC C USCORE ID COL INT C USCORE ID COL INT C USCORE ID COL INT BC ARROW INT GO ... GC**''
So each INT will be transformed into a TList(other than the last one that will be just a T because arrays as return values are not supported yet), then also QO TList QC will be reduced into TList again, after this each pair of COL empty symbol(no parameter here is of inout type) TList will be reduced into FTYPE, and finally each USCORE ID FTYPE is reduced into PAR and from then the PARList is created, at the end FUNCDef is reduced from FUNC ID BO PARElist BC RETVAL and we are close to the finish line.
After this steps something like this is generated in the output:
<code ASM>
define i32 @binarySearch (i32* %arr,i32 %search,i32 %low,i32 %high){}
</code>
As mentioned in a comment in the FUNCDef definition, we need to treat in a different way Strings when they are returned, to do so we generate a global variable to hold its result, so we don't have memory problem when accessing the character pointer returned by the function, so if we have a function **strtest** we'll generate a pointer @.str.strtest.ret, and when we try to return a value thanks to strcpy we copy that value in the @.str.strtest.ret location, let's check a quick example
<code Swift>
func strtest(...) -> String {
    ...
    let st=...
    return st
    ...
}
</code>
This code will be translated into:
<code ASM>
;global declarations
@.str.strtest.ret.arr = global [200 x i8] zeroinitializer
@.str.strtest.ret = global i8* getelementptr inbounds([200 x i8],[200 x i8]* @.str.strtest.ret.arr,i32 0,i32 0)
;we are inside the function here and before we have the declaration and initialization of st, that has the pointer stored into %10
%14= load i8*,i8** %10
%15= load i8*,i8** @.str.strtest.ret
%16= call i8* (i8*,i8*) @strcpy(i8* %15,i8* %14) ; %15 is the return that we want, while %14 represents st
ret i8* %15
</code>
Also another interesting thing happens when we have multidimensional arrays, here to manage them correctly a new mechanism is defined, where in case we have an array of N dimensions, the function in the LLVM IR form will have N-1 new parameters that represent the N-1 key dimensions for us, the outer dimension is not important because to access an array we don't need it so we don't receive it.

Here is an example of how that process works:<code Swift>func printarr(_ arr:[[[Int]]]){...}</code>
This section of code is translated into:''**FUNC ID BO USCORE ID COL QO QO QO INT QC QC QC BC GO ... GC**''
This get translated into something like this:
<code ASM>
define void @printarr (i32* %arr,i32 %dim.0.0,i32 %dim.0.1){}
</code>
The parameters to this function are a pointer and 2 integer values because the original array received is expected to be 3 dimensional.

After this we can check how these types of arrays are treated thanks to the IDARR symbol:
<code Java>
IDARR::= IDARR:i QO EXP:a QC {:
    if(i==null || a==null) RESULT=null;
    else if(i.arrFunc){
        if(i.dimensions.size()>0){
            ArrayList<String> s=new ArrayList<String>();
            for(int j=0;j<i.dimensions.size();j++){
                if(j==0)    if(a!=null) append("\n%"+getId()+"= mul i32 %"+i.dimensions.get(j)+","+a.getReg());
                else{
                    int oldId=getCurrentId();
                    append("\n%"+getId()+"= mul i32 %"+oldId+",%"+i.dimensions.get(j));
                    s.add(i.dimensions.get(j));
                }
            }
            int lastId=getCurrentId();
            append("\n%"+getId()+"= add nsw i32 %"+lastId+","+i.getReg());
            RESULT=new Attribute(i.type,i.associatedVarName,getCurrentId(),s);
        }
        else{
            append("\n%"+getId()+"= add nsw i32 "+a.getReg()+","+i.getReg());
            int lastId=getCurrentId();
            Tuple t=getValue(i.associatedVarName);
            Value v=null;
            if(t!=null) v=t.value;
            String baseType=v.getBaseType();
            append("\n%"+getId()+"= load "+i.type+","+i.type+"* "+v.getReg());
            int loadId=getCurrentId();
            append("\n%"+getId()+"= getelementptr inbounds "+baseType+","+i.type+" %"+loadId+", i32 %"+lastId);
            RESULT=new Attribute(baseType,getCurrentId(),i.associatedVarName);
        }
    }
    else{
        String ir=i.type;
        append("\n%"+getId()+" = getelementptr inbounds "+i.type+","+i.type+"* "+i.getReg()+", i32 0, i32 "+a.getReg());
        String subir=ir.substring(1,ir.length()-1);
        String newType;
        if(subir.indexOf("[")<0){
            newType=subir.substring(subir.indexOf("x")+2,subir.length());
            RESULT=new Attribute(newType,getCurrentId(),i.associatedVarName);
        }
        else{
            newType=subir.substring(subir.indexOf("["),subir.length());
            ArrayList<Integer> subdim=new ArrayList<Integer>();
            for(int at=1;at<i.dimensionsInt.size();at++) subdim.add(i.dimensionsInt.get(at));
            RESULT=new Attribute(newType,i.associatedVarName,subdim,getCurrentId());
        }
    }
:} | ID:i QO EXP:a QC {:
    Tuple t=getValue(i);
    Value v=null;
    if(t!=null) v=t.value;
    if(a==null) RESULT=null;
    else if(v==null){
        semError("Value "+i+" has not been declared yet");
        RESULT=null;
    }
    else if(!v.array){
        semError("Value "+i+" is not an array");
        RESULT=null;
    }
    else if(!v.initialized){
        semError("Value "+i+" has not been initialized yet");
        RESULT=null;
    }
    else{
        if(v.funcPar && v.dimensions.size()>1){
            ArrayList<String> s=new ArrayList<String>();
            for(int j=0;j<v.dimensionsParameters.size();j++){
                if(j==0)    append("\n%"+getId()+"= mul i32 %"+v.dimensionsParameters.get(j)+","+a.getReg());
                else{
                    int oldId=getCurrentId();
                    append("\n%"+getId()+"= mul i32 %"+oldId+",%"+v.dimensionsParameters.get(j));
                    s.add(v.dimensionsParameters.get(j));
                }
            }
            RESULT=new Attribute(v.irDec(),i,getCurrentId(),s);
        }
        else if(v.funcPar && v.dimensions.size()==1){
            String baseType=v.getBaseType();
            append("\n%"+getId()+"= load "+baseType+"*,"+baseType+"** "+v.getReg());
            int loadId=getCurrentId();
            append("\n%"+getId()+"= getelementptr inbounds "+baseType+","+baseType+"* %"+loadId+", i32 "+a.getReg());
            RESULT=new Attribute(baseType,getCurrentId(),i);
        }
        else{
            String ir=v.irDec();
            String reg=v.getReg();
            append("\n%"+getId()+" = getelementptr inbounds "+ir+","+ir+"* "+reg+", i32 0, i32 "+a.getReg());
            String subir=ir.substring(1,ir.length()-1);
            String newType;
            if(subir.indexOf("[")<0){
                newType=subir.substring(subir.indexOf("x")+2,subir.length());
                RESULT=new Attribute(newType,getCurrentId(),i);
            }
            else{
                newType=subir.substring(subir.indexOf("["),subir.length());
                ArrayList<Integer> subdim=new ArrayList<Integer>();
                for(int at=1;at<v.dimensions.size();at++) subdim.add(v.dimensions.get(at));
                RESULT=new Attribute(newType,i,subdim,getCurrentId());
            }
        }
    }
:};
</code>
Throughtought the code a clear difference between arrays that are parameters(in the first case,the recursive one, i.arrFunc, this is because on the class Attribute there is a property called arrFunc that tells us this, while on the second case because we retrieve the Value object we need to check the v.funcPar property that tells us that a certain thing is a parameter) and normal arrays, the first ones are a simple pointer so we need to calculate first the offset from it and then accessing it, here is an example from the previous function printArr of how the offset is calculated:<code Swift>print(arr[a][b][c])</code>
We need to calculate it doing dim1*size2*size3*...*sizeN + dim2*size3*...*sizeN + ... + dim3, so in this N is 3 case dim1 is a while dim2 is b and dim3 is c, while size2 is %dim.0.0 and size3 is %dim.0.1, so we need to apply a * %dim.0.0 * %dim.0.1 + b * %dim.0.1 + c, so the output generated to build the offset and using it to access the value to print is:
<code ASM>
%14= load i32,i32* %2 ; %2 represents the pointer to the variable a
%15= mul i32 %dim.0.0,%14
%16= mul i32 %15,%dim.0.1
%17= load i32,i32* %5 ; %5 represents the pointer to the variable b
%18= mul i32 %dim.0.1,%17
%19= add nsw i32 %18,%16
%20= load i32,i32* %11 ; %11 represents the pointer to the variable c
%21= add nsw i32 %20,%19 ; %21 is the FINAL OFFSET
%22= load i32*,i32** %1 ; %1 contains the pointer to the array used arr
%23= getelementptr inbounds i32,i32* %22, i32 %21 ; %23 contains the pointer to arr[a][b][c]
%24= load i32,i32* %23 ; %24 now contains the element arr[a][b][c]
%25= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %24)
%26= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
</code>
Here we load the values needed and multiply them accordingly and then after we get the final offset that is stored into %21, we load the array into %22 and thanks to the getelementptr inbounds instruction we receive the pointer to the element that is pointed by the array plus the offset, after we get this pointer we access it thanks to the load instruction and then print it.

If arr was a normal array and not a parameter of a function this process will be much different in fact we will move through the array for each dimension with the getelementptr inbounds instruction, that in this case is used only once, so if we would want to access arr2[a][b][c] and for example arr2 was of type int[2][3][4] the output would look like this:
<code ASM>
%14= load i32,i32* %2 ; %2 represents the pointer to the variable a
%15= getelementptr inbounds [2 x [3 x [4 x i32]]],[2 x [3 x [4 x i32]]]* %1,i32 0,i32 %14
%16= load i32,i32* %5 ; %5 represents the pointer to the variable b
%17= getelementptr inbounds [3 x [4 x i32]],[3 x [4 x i32]]* %15,i32 0,i32 %16
%18= load i32,i32* %11 ; %11 represents the pointer to the variable c
%19= getelementptr inbounds [4 x i32],[4 x i32]* %17,i32 0,i32 %18
%20= load i32,i32* %19
%21= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %20)
%22= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
</code>
Here as we can see we call getelementptr inbounds for every subscript [], and also here getelementptr inbounds works in a slightly different way because it receives the type of the structure, its pointer and then a list of indexes, the first index is alway 0, because for example %15 is a pointer to a structure of type [3 x [4 x i32]] and we want to access the element that pointer points to, so we use index 0, after that we have another index that in this case was %16, %16 contained the value of b, so after we get the structure the pointer %15 pointed to we want to receive a pointer to the Bth element of that structure, so in this case the the Bth [4 x i32] array.

#### Strings and string interpolation mechanism and print/println functions

Strings are a basic type of Swift, so in this compiler it was a big focus to manage them, in this compiler they are managed thanks to a buffer of 200 characters, so the maximum size of a single string is 199(the last one will be dedicated to the \00 character), in this compiler string interpolation and string concatenation are supported just like in Swift, also the new line character is managed differently because in needs to be translated into \0A.

The level of string support acquired is thanks mainly to the use of 4 functions from the C standard library, sprintf, strcat,strcmp and strcpy, sprintf is used mainly to print to a string buffer a value like an integer or a double, this is done thanks to 2 constants initialized called @.str.int and @.str.double, other 2 constants are initialized for the space character and the newline character, these 2 are @.str.space and @.str.newline.

Strcpy instead is used mainly to store results,strcmp is used only with comparisons, and lastly strcat is used to do string concatenation.

Let's check how string constants and string interpolation works:
<code Java>
STR::= STRINGVAL:s {:
    int len=s.length()+1;
    int indexs=-2;
    while(indexs!=(-1)){
        if(indexs!=(-2)){
            len--;
            indexs+=2;
            indexs=s.indexOf("\\n",indexs);
        }
        else indexs=s.indexOf("\\n",0);
    }
    s=s.replace("\\n", "\\0A");
    globalBuffer.append("\n@.str."+(++stringIndex)+" = constant ["+len+" x i8] c\""+s+"\\00\"");
    int id;
    if(inFunction){
        append("\n%"+getId()+" = getelementptr inbounds ["+len+" x i8], ["+len+" x i8]* @.str."+stringIndex+" , i32 0, i32 0");
        RESULT=new Attribute("i8*",getCurrentId());
    }
    else{
        globalInitializations.append("\n%"+(++globalInitializationsId)+" = getelementptr inbounds ["+len+" x i8], ["+len+" x i8]* @.str."+stringIndex+" , i32 0, i32 0");
        Attribute att=new Attribute("i8*",globalInitializationsId);
        att.immediate=true;
        RESULT=att;
    }
:}| STRINGVALS:s STRINGVALINTERP:i STRINGVALE:e{: ...; :} ;

STRINGVALINTERP::= STRINGVALINTERP:i STRINGVALI:s EXP:e {:
    int expPointer,expGep,finalArrPointer,finalGepPointer;
    int len=s.length()+1;
    int indexs=-2;
    while(indexs!=(-1)){
        if(indexs!=(-2)){
            len--;
            indexs+=2;
            indexs=s.indexOf("\\n",indexs);
        }
        else    indexs=s.indexOf("\\n",0);
    }
    s=s.replace("\\n", "\\0A");
    globalBuffer.append("\n@.str."+(++stringIndex)+" = constant ["+len+" x i8] c\""+s+"\\00\"");
    append("\n%"+getId()+" = alloca [200 x i8], align 1");
    finalArrPointer=getCurrentId();
    append("\n%"+getId()+" = alloca [20 x i8], align 1");
    expPointer=getCurrentId();
    append("\n%"+getId()+" = getelementptr inbounds [20 x i8], [20 x i8]* %"+expPointer+" , i32 0, i32 0");
    expGep=getCurrentId();
    if(e!=null){
        if(e.type.equals("i32"))   append("\n%"+getId()+" = call i32 (i8*,i8*, ...) @sprintf(i8* %"+expGep+",i8* getelementptr inbounds([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 "+e.getReg()+")");
        else if(e.type.equals("double"))   append("\n%"+getId()+" = call i32 (i8*,i8*, ...) @sprintf(i8* %"+expGep+",i8* getelementptr inbounds([4 x i8], [4 x i8]* @.str.double, i32 0, i32 0), double "+e.getReg()+")");
        else{
            semError("String interpolation is allowed only with expressions that are either doubles or integers");
            append("\n%"+getId()+" = call i32 (i8*,i8*, ...) @sprintf(i8* %"+expGep+",i8* getelementptr inbounds([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 -1)");
        }
    }
    else    append("\n%"+getId()+" = call i32 (i8*,i8*, ...) @sprintf(i8* %"+expGep+",i8* getelementptr inbounds([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 -1)");
    append("\n%"+getId()+" = getelementptr inbounds [200 x i8],[200 x i8]* %"+finalArrPointer+",i32 0,i32 0");
    finalGepPointer=getCurrentId();
    append("\n%"+getId()+" = call i8* (i8*,i8*) @strcpy(i8* %"+finalGepPointer+",i8* %"+i+")");
    append("\n%"+getId()+" = call i8* (i8*,i8*) @strcat(i8* %"+finalGepPointer+",i8* getelementptr inbounds (["+len+" x i8], ["+len+" x i8]* @.str."+stringIndex+",i32 0,i32 0))");
    append("\n%"+getId()+" = call i8* (i8*,i8*) @strcat(i8* %"+finalGepPointer+",i8* %"+expGep+")");
    RESULT=finalGepPointer;
:}| EXP:e {: ...; :};
</code>
STR represents a string that can be a normal string or one with some interpolation inside, in the first case we receive STRINGVAL from the scanner and we just translate each new line into \0A and then store this value as a global constant, and then return an Attribute object, otherwise we expect to receive a STRINGVAL and then either an expression and then STRINGVALE token from the parser, or instead of just an expression we may receive a flow of expression STRINGVALI and expression.

STRINGVALI is any part of a string that is between two interpolations, so in a string like "the result of x is \(x),while the result of y is \(y), and for z is \(z).!", the scanner will return us STRINGVALS for the string "the result of x is ", and will return us STRINGVALI for the strings ",while the result of y is " and ", and for z is ", and lastly it will return us STRINGVALE for the last part so ".!".

During this part each STRINGVALS, STRINGVALS and STRINGVALE is stored as a constant named always @.str.(here instert its index), while for expressions we always accept 20 characters, this is to permit to reach the maximum integer 32 bits number to be printed and also longer doubles.

Let's check an example of how this process generates an output for the following example: <code Swift>println("The result of \(a)/\(b) is:",x)</code>
<code ASM>
;this is global
@.str.1 = constant [2 x i8] c"/\00"
@.str.2 = constant [15 x i8] c"The result of \00"
@.str.3 = constant [5 x i8] c" is:\00"
...
;this is inside the function where the println is called
%14= load double,double* %1 ; %1 is the pointer to the variable a
%15 = alloca [20 x i8], align 1
%16 = getelementptr inbounds [20 x i8], [20 x i8]* %15 , i32 0, i32 0
%17 = call i32 (i8*,i8*, ...) @sprintf(i8* %16,i8* getelementptr inbounds([4 x i8], [4 x i8]* @.str.double, i32 0, i32 0), double %14)
%18= load double,double* %2 ; %2 is the pointer to the variable b
%19 = alloca [200 x i8], align 1
%20 = alloca [20 x i8], align 1
%21 = getelementptr inbounds [20 x i8], [20 x i8]* %20 , i32 0, i32 0
%22 = call i32 (i8*,i8*, ...) @sprintf(i8* %21,i8* getelementptr inbounds([4 x i8], [4 x i8]* @.str.double, i32 0, i32 0), double %18)
%23 = getelementptr inbounds [200 x i8],[200 x i8]* %19,i32 0,i32 0
%24 = call i8* (i8*,i8*) @strcpy(i8* %23,i8* %16)
%25 = call i8* (i8*,i8*) @strcat(i8* %23,i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1,i32 0,i32 0))
%26 = call i8* (i8*,i8*) @strcat(i8* %23,i8* %21)
%27 = alloca [200 x i8], align 1
%28 = getelementptr inbounds [200 x i8], [200 x i8]* %27 , i32 0, i32 0
%29 = call i8* (i8*,i8*) @strcpy(i8* %28,i8* getelementptr inbounds([15 x i8], [15 x i8]* @.str.2, i32 0, i32 0))
%30 = call i8* (i8*,i8*) @strcat(i8* %28,i8* %23)
%31 = call i8* (i8*,i8*) @strcat(i8* %28,i8* getelementptr inbounds([5 x i8], [5 x i8]* @.str.3 , i32 0, i32 0))
%32= load double,double* %3 ; %3 is the pointer to the variable x
%33 = call i32 (i8*, ...) @printf(i8* %28)
%34= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%35= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([4 x i8],[4 x i8]* @.str.double,i32 0,i32 0),double %32)
%36= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
</code>
Now we can take a quick look at how the print and the println functions are managed
<code Java>
PROC::= ... | PRINTP:nln BO HEXPLE:l BC{:
        l.forEach(p->{
            if(p.type.equals("i8*"))    append("\n%"+getId()+" = call i32 (i8*, ...) @printf(i8* "+p.getReg()+")");
            else if(p.type.equals("i32"))   append("\n%"+getId()+"= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 "+p.getReg()+")");
            else if(p.type.equals("double"))   append("\n%"+getId()+"= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([4 x i8],[4 x i8]* @.str.double,i32 0,i32 0),double "+p.getReg()+")");
            else    semError("Can't print a type that is not a string, double or integer");
            append("\n%"+getId()+"= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))");
        });
        if(nln)   append("\n%"+getId()+" = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))");
:} ;
PRINTP::=PRINT {: RESULT=false; :} | PRINTLN {: RESULT=true; :};
HEXPLE::=HEXPL:l {:RESULT=l;:} | {:RESULT=new ArrayList<Attribute>();:};
HEXPL::= HEXPL:l C EXP:e {:
    if(e!=null) l.add(e);
    RESULT=l;
:} | EXP:e {:
    ArrayList<Attribute> l=new ArrayList<Attribute>();
    if(e!=null) l.add(e);
    RESULT=l;
:};
</code>
So we have the PROC symbol that is used whenever any function get called, and then the PRINTP symbol that looks if this was an instance of a print or if it was a println, then we use the symbol HEXPLE that represents a comma separated list of heterogenous attributes that can be also empty, we take this list and call the printf function accordingly of the type of attribute received, so if it was a string we just call printf and give that pointer, otherwise we call printf with @.str.int or @.str.double and passing also the value of the attribute, after each step a space is printed, and if the call was to println a new line is printed at the end.

So if we call println without any parameter we will just print a new line, while if we pass a list of attributes to a print function also after the last one we'll print a space, this may be useful in many cases to avoid having strings starting with spaces.

#### Control blocks 
Each control block(if, while, for) like a function generate a new scope, for and while blocks are treated in a similar way, in fact both of them use the same currenFor variable, this is because they both can have inside a break or continue statement, and also because with one of them we can generate the other.

While for the if block things are different, so let's check it, a complete if block can be retrieved thanks to this grammar:
<code Java>
IFCOMPLETEBLOCK::= IFCC:ifc NL {:
    append("\nif.elif."+ifc.type+"."+ifc.regId+" : ");
    append("\nbr label %if.exit."+ifc.type+".0");
    append("\nif.exit."+ifc.type+".0:");
:} | IFCC:ifc NL ELSE {:
    append("\nif.elif."+ifc.type+"."+ifc.regId+" : ");
    scopes.add(new Scope());
:} GO CONDSTMS GC {:
    append("\nbr label %if.exit."+ifc.type+".0");
    append("\nif.exit."+ifc.type+".0:");
    scopes.remove(scopes.size()-1);
:} ;

IFCC::= IFCC:ifc NL ELIF {:
    append("\nif.elif."+ifc.type+"."+ifc.regId+" : ");
:} COND:cond {:
    append("\nbr i1 "+cond.getReg()+", label %if.body."+ifc.type+"."+ifc.regId+", label %if.elif."+ifc.type+"."+(ifc.regId+1));
    append("\nif.body."+ifc.type+"."+ifc.regId+" : ");
    scopes.add(new Scope());
:} GO CONDSTMS GC {:
    append("\nbr label %if.exit."+ifc.type+".0");
    ifc.setReg(ifc.regId+1);
    scopes.remove(scopes.size()-1);
    RESULT=ifc;
:} | IFCOND:ifc {:RESULT=ifc;:} ;

IFCOND::= IFCONDDEC:ifNum GO CONDSTMS GC {:
    append("\nbr label %if.exit."+ifNum+".0");
    scopes.remove(scopes.size()-1);
    RESULT=new Attribute(""+ifNum,0);
:} ;

IFCONDDEC::= IF COND:cond {:
    int currIf=currentIf++;
    append("\nbr i1 "+cond.getReg()+", label %if.body."+currIf+", label %if.elif."+currIf+".0");
    append("\nif.body."+currIf+" : ");
    scopes.add(new Scope());
    RESULT=currIf;
:};
</code>
This type of grammar and its semantics for the following code<code Swift>
if search==arr[mid] {
    return mid;
}
else if search>arr[mid]  {
    return binarySearch(arr,search,mid+1,high)
}
else {
    return binarySearch(arr,search,low,mid-1)
}</code>
generate the following output:
<code ASM>
...
%19= icmp eq i32 %14,%18
br i1 %19, label %if.body.1, label %if.elif.1.0
if.body.1:
%20= load i32,i32* %13
ret i32 %20
br label %if.exit.1.0
if.elif.1.0:
...
%27= icmp sgt i32 %22,%26
br i1 %27, label %if.body.1.0, label %if.elif.1.1
if.body.1.0:
...
br label %if.exit.1.0
if.elif.1.1:
...
br label %if.exit.1.0
if.exit.1.0:
</code>
So we have two different indexes for a if block, the index that makes the if block unique, the first one, and the second one that represents the Ith elif/else part of the block, in this way we can guarantee that a complete block will be working, also in this example we can see that else if and else are treated slightly differently, else part dive directly into the body without checking a condition etc.

#### Attributes and expressions 

An expression is matched recursively as any expression with an operator that is then followed by another expression, but at the lowest level an expression is just an attribute, so what's an attribute? An attribute here is considered any of the following things: a variable/constant(ID), an immediate value(VAL for numbers like 1,1.0, while STR for strings like "imm"), a variable/constant that is array accessed(IDARR) or a function call(PROC).
So the basic grammar for expressions is like this:
<code Java>
EXP::= EXP:e PLUS EXP:a {:
    if(e==null || a==null)  RESULT=null;
    else if(!e.type.equals(a.type)){
        semError("Type mismatch in assignment");
        RESULT=e;
    }
    else if(!e.type.equals("double") && !e.type.equals("i32") && !e.type.equals("i8*")){
        semError("Can do substractions only on integeres,strings and doubles!");
        RESULT=e;
    }
    else{
        int id;
        if(e.type.equals("i8*")){
            append("\n%"+getId()+"= alloca [200 x i8]");
            int newArr=getCurrentId();
            append("\n%"+getId()+"= getelementptr inbounds [200 x i8],[200 x i8]* %"+newArr+",i32 0, i32 0");
            id=getCurrentId();
            append("\n%"+getId()+" = call i8* (i8*,i8*) @strcpy(i8* %"+id+",i8* "+e.getReg()+")");
            append("\n%"+getId()+" = call i8* (i8*,i8*) @strcat(i8* %"+id+",i8* "+a.getReg()+")");
            RESULT=new Attribute("i8*",id);
        }
        else{
            if(e.immediate){
                if(a.immediate) append("\n%"+getId()+"= "+getIrOp(operations.ADD,e.type)+" "+e.type+" "+e.immediateValue+","+a.immediateValue);
                else append("\n%"+getId()+"= "+getIrOp(operations.ADD,e.type)+" "+e.type+" "+e.immediateValue+","+a.getReg());
            }
            else{
                if(a.immediate) append("\n%"+getId()+"= "+getIrOp(operations.ADD,e.type)+" "+e.type+" "+e.getReg()+","+a.immediateValue);
                else append("\n%"+getId()+"= "+getIrOp(operations.ADD,e.type)+" "+e.type+" "+e.getReg()+","+a.getReg());
            }
        }
        id=getCurrentId();
        RESULT=new Attribute(e.type,id);
    }
:}| ATTR:a {:
    RESULT=a;
:} | other operators ... ;

ATTR::= PROC:p {:
    RESULT=p;
:} | ID:i {:
    Tuple t=getValue(i);
    Value v=null;
    if(t!=null) v=t.value;
    if(v==null) RESULT=null;
    else if(!v.initialized){
        semError("Value "+i+" hasn't already been initialized before this expression");
        RESULT=null;
    }
    else{
        String type=v.irDec();
        String reg=v.getReg();
        int id;
        ...
        else{
            if(v.inoutPar && !v.array)  type=v.getBaseType();
            if(type.equals("double") || type.equals("i32") || type.equals("i8*")){
                append("\n%"+getId()+"= load "+type+","+type+"* "+reg);
                id=getCurrentId();
                RESULT=new Attribute(type,id,i);
            }
            else{
                semError("Can't use an array in an expression");
                RESULT=null;
            }
        }
    }
:} | VAL:v {:
    RESULT=v;
:} | IDARR:i {:
    int id;
    if(i==null) RESULT=null;
    else{
        Tuple t=getValue(i.associatedVarName);
        Value v=null;
        if(t!=null) v=t.value;
        String type=v.irDec();
        ...
        else{
            if(i.type.equals("i32") || i.type.equals("double") || i.type.equals("i8*")){
                append("\n%"+getId()+"= load "+i.type+","+i.type+"* "+i.getReg());
                id=getCurrentId();
                RESULT=new Attribute(i.type,id);
            }
            else RESULT=null;
        }
    }
:} ;
</code>
The operations have a precedence queue so we don't have a conflict based on them, where the plus has the least precedence while the unary minus operator has the biggest precedence factor, all of the operators have a left precedence rule.

An interesting fact about the expressions regards the binary ones where the binary not is implemented with a binary xor with -1, this is done because the result is the same and LLVM IR doesn't have implemented the binary not.

#### Error handling and restrictions

The compiler like shown in many examples above is able to recognize a lot of semantics errors, but it is also able to recognize many syntax errors, here are some of the semantic errors it can catch:
  *variable or constant not declared
  *constant already initialized
  *variable or constant already declared inside that same scope
  *variable or constant used before initialization
  *incompatibility on assignment
  *''main'' function not found
  *missing return statement in a non void function
  *wrong return type
  *calling a function that hasn't been declared yet
  *calling a function with a non adequate list of parameters
  *non static initialization for global variables/constants
  *type annotation doesn't match with type of initialization, ex. var z : String=2
  *string interpolation with something else than an Int or a Double
  *heterogenous arrays
  *doing operations on strings that are not concatenations
  *binary operations on something that is not an Int
  *continue or break statement while not in while or for block
Here are some of the syntax ones instead:
  *error in a declaration
  *type annotation missing and no initialization
  *error in a direct initialization
  *error in an expression
  *error in string interpolation
  *errors related to arrays like missing ]
  *errors in a list of attributes, like during a list of parameters etc.
  *errors in a function declaration
  *errors in a control block declaration
  *general statement error
And other ones, but there are also some restrictions on the syntax accepted:
  *if the last statement is not a function it needs to finish either with a new line or a semicolon ;
  *the last statement of a function or a control block must be followed by a new line or a semicolon
    *so if, else if, else, while, for, functions must be something like:<code Swift>
    definition of block{
        ...
    }</code>
  *if multiple function are in the same line and they are not separeted by a semicolon ; that error will not be detected
  *main function must be present
  *array variables must be initialized immediatly(similarly to Swift)

##### The programmer's welcome : Hello world!

Let's check a simple hello world program in Swift
<file Swift helloWorld.swift>
func main(){
    println("Hello world!")
}
</file>
Feeding this code to this compiler calling ''java Main helloWold.swift'' the following LLVM IR code will be generated:
<file ASM helloWorld.ll>
;DEPENDENCY DECLARATIONS
declare i32 @printf(i8*, ...)
declare i32 @sprintf(i8*,i8*, ...)
declare i8* @strcat(i8*,i8*)
declare i8* @strcpy(i8*,i8*)
declare i32 @strcmp(i8*,i8*)
@.str.newline = constant [2 x i8] c"\0A\00"
@.str.int = constant [3 x i8] c"%d\00"
@.str.double = constant [4 x i8] c"%lf\00"
@.str.space = constant [2 x i8] c" \00"
;GLOBAL DECLARATIONS

@.str.0 = constant [13 x i8] c"Hello world!\00"
;GLOBAL INITIALIZATIONS OF GLOBAL VARIABLES THAT ARE STRINGS OR ARRAYS OF STRINGS
define void @globalinit(){
ret void
}

define void @main (){
call void () @globalinit()
%1 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.0 , i32 0, i32 0
%2 = call i32 (i8*, ...) @printf(i8* %1)
%3= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
ret void
}
</file>
This output should be saved into a file.ll(for example doing ''java Main helloWorld.swift >> helloWorld.ll'') and then started with the LLVM suite thanks to the lli command, so doing ''lli helloWorld.ll'', doing that "Hello world!" will be printed

### How to run it

  - Install, if you have not already done so, the //llvm// package: ''sudo apt install llvm''
  - Download the **Swift compiler** and extract it
  - Open the terminal, go to the folder where the compiler is extracted and run: ''make''
  - Take a ''.swift'' file (from the examples or write a code supported by the compiler)
  - Run the compiler, passing the ''.swift'' file as input and redirecting the output in a ''.ll'' file
  - ''java Main [filename].swift > [filename].ll''
  - Run the output file with the command **lli**: ''lli [filename].ll''

