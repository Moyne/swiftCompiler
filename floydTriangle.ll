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

@rows = global i32 10
;GLOBAL INITIALIZATIONS OF GLOBAL VARIABLES THAT ARE STRINGS OR ARRAYS OF STRINGS
define void @globalinit(){
ret void
}

define void @main (){
call void () @globalinit()
%1= alloca i32
store i32 1,i32* %1
br label %for.init.0
for.init.0:
%2 = alloca i32, align 4
store i32 0,i32* %2
br label %for.cond.0
for.cond.0:
%3 = load i32,i32* %2
%4 = load i32,i32* @rows
%5 = icmp sle i32 %3,%4
br i1 %5, label %for.body.0, label %for.exit.0
for.body.0:
br label %for.init.1
for.init.1:
%6 = alloca i32, align 4
store i32 0,i32* %6
br label %for.cond.1
for.cond.1:
%7 = load i32,i32* %6
%8 = load i32,i32* %2
%9 = icmp sle i32 %7,%8
br i1 %9, label %for.body.1, label %for.exit.1
for.body.1:
%10= load i32,i32* %1
%11= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %10)
%12= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%13= load i32,i32* %1
%14 = add nsw i32 %13,1
store i32 %14,i32* %1
br label %for.inc.1
for.inc.1:
%15 = load i32,i32* %6
%16 = add nsw i32 %15,1
store i32 %16,i32* %6
br label %for.cond.1
for.exit.1:
%17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.inc.0
for.inc.0:
%18 = load i32,i32* %2
%19 = add nsw i32 %18,1
store i32 %19,i32* %2
br label %for.cond.0
for.exit.0:
ret void
}

