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

@soag = global i32 31
@.str.0 = constant [13 x i8] c"Array before\00"
@.str.1 = constant [12 x i8] c"Array after\00"
;GLOBAL INITIALIZATIONS OF GLOBAL VARIABLES THAT ARE STRINGS OR ARRAYS OF STRINGS
define void @globalinit(){
ret void
}

define void @bubble (i32* %arr){
%1 = alloca i32*
store i32* %arr, i32** %1
%2= alloca i32,align 4
store i32 1,i32* %2
br label %for.cond.0
for.cond.0:
%3= load i32,i32* %2
%4= icmp eq i32 %3,1
br i1 %4, label %for.body.0, label %for.exit.0
for.body.0:
store i32 0,i32* %2
br label %for.init.1
for.init.1:
%5 = alloca i32, align 4
store i32 0,i32* %5
br label %for.cond.1
for.cond.1:
%6 = load i32,i32* %5
%7 = icmp slt i32 %6,4
br i1 %7, label %for.body.1, label %for.exit.1
for.body.1:
%8= load i32,i32* %5
%9= load i32*,i32** %1
%10= getelementptr inbounds i32,i32* %9, i32 %8
%11= load i32,i32* %10
%12= load i32,i32* %5
%13= add nsw i32 %12,1
%14= load i32*,i32** %1
%15= getelementptr inbounds i32,i32* %14, i32 %13
%16= load i32,i32* %15
%17= icmp sgt i32 %11,%16
br i1 %17, label %if.body.0, label %if.elif.0.0
if.body.0:
%18= load i32,i32* %5
%19= add nsw i32 %18,1
%20= load i32*,i32** %1
%21= getelementptr inbounds i32,i32* %20, i32 %19
%22= load i32,i32* %21
%23= alloca i32,align 4
store i32 %22,i32* %23
%24= load i32,i32* %5
%25= add nsw i32 %24,1
%26= load i32*,i32** %1
%27= getelementptr inbounds i32,i32* %26, i32 %25
%28= load i32,i32* %5
%29= load i32*,i32** %1
%30= getelementptr inbounds i32,i32* %29, i32 %28
%31= load i32,i32* %30
store i32 %31,i32* %27
%32= load i32,i32* %5
%33= load i32*,i32** %1
%34= getelementptr inbounds i32,i32* %33, i32 %32
%35= load i32,i32* %23
store i32 %35,i32* %34
store i32 1,i32* %2
br label %if.exit.0.0
if.elif.0.0:
br label %if.exit.0.0
if.exit.0.0:
br label %for.inc.1
for.inc.1:
%36 = load i32,i32* %5
%37 = add nsw i32 %36,1
store i32 %37,i32* %5
br label %for.cond.1
for.exit.1:
br label %for.inc.0
for.inc.0:
%38 = add nsw i32 0,0
br label %for.cond.0
for.exit.0:
ret void
}
define void @main (){
call void () @globalinit()
%1= alloca [5 x i32],align 4
%2 = getelementptr inbounds [5 x i32],[5 x i32]* %1,i32 0,i32 0
store i32 715,i32* %2
%3 = getelementptr inbounds [5 x i32],[5 x i32]* %1,i32 0,i32 1
store i32 14,i32* %3
%4 = getelementptr inbounds [5 x i32],[5 x i32]* %1,i32 0,i32 2
store i32 1,i32* %4
%5 = getelementptr inbounds [5 x i32],[5 x i32]* %1,i32 0,i32 3
store i32 99,i32* %5
%6 = getelementptr inbounds [5 x i32],[5 x i32]* %1,i32 0,i32 4
store i32 2,i32* %6
%7 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.0 , i32 0, i32 0
%8 = call i32 (i8*, ...) @printf(i8* %7)
%9= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.init.2
for.init.2:
%11 = alloca i32, align 4
store i32 0,i32* %11
br label %for.cond.2
for.cond.2:
%12 = load i32,i32* %11
%13 = icmp sle i32 %12,4
br i1 %13, label %for.body.2, label %for.exit.2
for.body.2:
%14= load i32,i32* %11
%15 = getelementptr inbounds [5 x i32],[5 x i32]* %1, i32 0, i32 %14
%16= load i32,i32* %15
%17= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %16)
%18= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.inc.2
for.inc.2:
%20 = load i32,i32* %11
%21 = add nsw i32 %20,1
store i32 %21,i32* %11
br label %for.cond.2
for.exit.2:
%22 = getelementptr inbounds [5 x i32],[5 x i32]* %1,i32 0,i32 0
call void (i32*) @bubble(i32* %22)
%23 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.1 , i32 0, i32 0
%24 = call i32 (i8*, ...) @printf(i8* %23)
%25= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%26 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.init.3
for.init.3:
%27 = alloca i32, align 4
store i32 0,i32* %27
br label %for.cond.3
for.cond.3:
%28 = load i32,i32* %27
%29 = icmp sle i32 %28,4
br i1 %29, label %for.body.3, label %for.exit.3
for.body.3:
%30= load i32,i32* %27
%31 = getelementptr inbounds [5 x i32],[5 x i32]* %1, i32 0, i32 %30
%32= load i32,i32* %31
%33= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %32)
%34= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.inc.3
for.inc.3:
%36 = load i32,i32* %27
%37 = add nsw i32 %36,1
store i32 %37,i32* %27
br label %for.cond.3
for.exit.3:
ret void
}

