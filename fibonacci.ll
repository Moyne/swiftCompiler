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

@iterations = global i32 10
@.str.0 = constant [182 x i8] c"This program calculates the fibonacci values for the array specified(it is correct for every result representable in a signed integer of 32 bits, so until 46), here are the results:\00"
@.str.1 = constant [31 x i8] c"The result of the fibonacci of\00"
@.str.2 = constant [4 x i8] c"is:\00"
;GLOBAL INITIALIZATIONS OF GLOBAL VARIABLES THAT ARE STRINGS OR ARRAYS OF STRINGS
define void @globalinit(){
ret void
}

define i32 @fibonacci (i32 %num){
%1 = alloca i32
store i32 %num, i32* %1
%2= load i32,i32* %1
%3= icmp eq i32 %2,0
br i1 %3, label %if.body.0, label %if.elif.0.0
if.body.0:
ret i32 0
br label %if.exit.0.0
if.elif.0.0:
%5= load i32,i32* %1
%6= icmp eq i32 %5,1
br i1 %6, label %if.body.0.0, label %if.elif.0.1
if.body.0.0:
ret i32 1
br label %if.exit.0.0
if.elif.0.1:
br label %if.exit.0.0
if.exit.0.0:
%8= load i32,i32* %1
%9= sub i32 %8,1
%10=call i32 (i32) @fibonacci(i32 %9)
%11= load i32,i32* %1
%12= sub i32 %11,2
%13=call i32 (i32) @fibonacci(i32 %12)
%14= add nsw i32 %10,%13
ret i32 %14
ret i32 -1
}
define void @main (){
call void () @globalinit()
%1= alloca [10 x i32]
%2 = getelementptr inbounds [10 x i32],[10 x i32]* %1,i32 0,i32 0
store i32 22,i32* %2
%3 = getelementptr inbounds [10 x i32],[10 x i32]* %1,i32 0,i32 1
store i32 15,i32* %3
%4 = getelementptr inbounds [10 x i32],[10 x i32]* %1,i32 0,i32 2
store i32 10,i32* %4
%5 = getelementptr inbounds [10 x i32],[10 x i32]* %1,i32 0,i32 3
store i32 12,i32* %5
%6 = getelementptr inbounds [10 x i32],[10 x i32]* %1,i32 0,i32 4
store i32 3,i32* %6
%7 = getelementptr inbounds [10 x i32],[10 x i32]* %1,i32 0,i32 5
store i32 8,i32* %7
%8 = getelementptr inbounds [10 x i32],[10 x i32]* %1,i32 0,i32 6
store i32 1,i32* %8
%9 = getelementptr inbounds [10 x i32],[10 x i32]* %1,i32 0,i32 7
store i32 0,i32* %9
%10 = getelementptr inbounds [10 x i32],[10 x i32]* %1,i32 0,i32 8
store i32 5,i32* %10
%11 = getelementptr inbounds [10 x i32],[10 x i32]* %1,i32 0,i32 9
store i32 32,i32* %11
%12 = getelementptr inbounds [182 x i8], [182 x i8]* @.str.0 , i32 0, i32 0
%13 = call i32 (i8*, ...) @printf(i8* %12)
%14= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.init.0
for.init.0:
%16 = alloca i32, align 4
store i32 0,i32* %16
br label %for.cond.0
for.cond.0:
%17 = load i32,i32* %16
%18 = load i32,i32* @iterations
%19 = icmp slt i32 %17,%18
br i1 %19, label %for.body.0, label %for.exit.0
for.body.0:
%20 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.1 , i32 0, i32 0
%21= load i32,i32* %16
%22 = getelementptr inbounds [10 x i32],[10 x i32]* %1, i32 0, i32 %21
%23= load i32,i32* %22
%24 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.2 , i32 0, i32 0
%25= load i32,i32* %16
%26 = getelementptr inbounds [10 x i32],[10 x i32]* %1, i32 0, i32 %25
%27= load i32,i32* %26
%28=call i32 (i32) @fibonacci(i32 %27)
%29 = call i32 (i8*, ...) @printf(i8* %20)
%30= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%31= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %23)
%32= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%33 = call i32 (i8*, ...) @printf(i8* %24)
%34= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%35= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %28)
%36= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.inc.0
for.inc.0:
%38 = load i32,i32* %16
%39 = add nsw i32 %38,1
store i32 %39,i32* %16
br label %for.cond.0
for.exit.0:
ret void
}

