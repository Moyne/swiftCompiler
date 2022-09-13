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

@.str.0 = constant [17 x i8] c"Division with 0!\00"
@.str.1 = constant [2 x i8] c"/\00"
@.str.2 = constant [15 x i8] c"The result of \00"
@.str.3 = constant [5 x i8] c" is:\00"
;GLOBAL INITIALIZATIONS OF GLOBAL VARIABLES THAT ARE STRINGS OR ARRAYS OF STRINGS
define void @globalinit(){
ret void
}

define i32 @division (double %a,double %b,double* %x){
%1 = alloca double
store double %a, double* %1
%2 = alloca double
store double %b, double* %2
%3 = alloca double*
store double* %x, double** %3
%4 = load double*,double** %3
%5= load double,double* %2
%6= fcmp oeq double %5,0.0
br i1 %6, label %if.body.0, label %if.elif.0.0
if.body.0:
ret i32 -1
br label %if.exit.0.0
if.elif.0.0:
br label %if.exit.0.0
if.exit.0.0:
%8= load double,double* %1
%9= load double,double* %2
%10= fdiv double %8,%9
store double %10,double* %4
ret i32 1
ret i32 -1
}
define void @main (){
call void () @globalinit()
%1= alloca double
store double 225.15,double* %1
%2= alloca double
store double 3.151,double* %2
%3= alloca double
store double 0.0,double* %3
%4= load double,double* %1
%5= load double,double* %2
%6=call i32 (double,double,double*) @division(double %4,double %5,double* %3)
%7= alloca i32
store i32 %6,i32* %7
%8= load i32,i32* %7
%9= icmp eq i32 %8,-1
br i1 %9, label %if.body.1, label %if.elif.1.0
if.body.1:
%10 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.0 , i32 0, i32 0
%11 = call i32 (i8*, ...) @printf(i8* %10)
%12= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %if.exit.1.0
if.elif.1.0:
%14= load double,double* %1
%15 = alloca [20 x i8], align 1
%16 = getelementptr inbounds [20 x i8], [20 x i8]* %15 , i32 0, i32 0
%17 = call i32 (i8*,i8*, ...) @sprintf(i8* %16,i8* getelementptr inbounds([4 x i8], [4 x i8]* @.str.double, i32 0, i32 0), double %14)
%18= load double,double* %2
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
%32= load double,double* %3
%33 = call i32 (i8*, ...) @printf(i8* %28)
%34= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%35= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([4 x i8],[4 x i8]* @.str.double,i32 0,i32 0),double %32)
%36= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %if.exit.1.0
if.exit.1.0:
ret void
}

