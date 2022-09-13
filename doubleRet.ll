;DEPENDENCY DECLARATIONS
declare i32 @printf(i8*, ...)
declare i32 @sprintf(i8*,i8*, ...)
declare i8* @strcat(i8*,i8*)
declare i8* @strcpy(i8*,i8*)
@.str.newline = constant [2 x i8] c"\0A\00"
@.str.int = constant [3 x i8] c"%d\00"
@.str.double = constant [4 x i8] c"%lf\00"
@.str.space = constant [2 x i8] c" \00"
;GLOBAL DECLARATIONS

@.str.0 = constant [41 x i8] c"This is the result of the function doub:\00"
;GLOBAL INITIALIZATIONS OF GLOBAL VARIABLES THAT ARE STRINGS OR ARRAYS OF STRINGS
define void @globalinit(){
ret void
}

define double @doub (i32 %a){
%1 = alloca i32
store i32 %a, i32* %1
%2= load i32,i32* %1
%3= icmp eq i32 %2,0
br i1 %3, label %if.body.0, label %if.elif.0.0
if.body.0:
ret double 124.1
br label %if.exit.0.0
if.elif.0.0:
br label %if.exit.0.0
if.exit.0.0:
ret double -1.0
}
define void @main (){
call void () @globalinit()
%1 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.0 , i32 0, i32 0
%2=call double (i32) @doub(i32 1)
%3 = call i32 (i8*, ...) @printf(i8* %1)
%4= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%5= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([4 x i8],[4 x i8]* @.str.double,i32 0,i32 0),double %2)
%6= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
ret void
}

