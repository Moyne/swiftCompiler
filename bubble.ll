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

@.str.0 = constant [14 x i8] c"Array before:\00"
@.str.1 = constant [13 x i8] c"Array after:\00"
;GLOBAL INITIALIZATIONS OF GLOBAL VARIABLES THAT ARE STRINGS OR ARRAYS OF STRINGS
define void @globalinit(){
ret void
}

define void @bubble (i32* %arr,i32 %size){
%1 = alloca i32*
store i32* %arr, i32** %1
%2 = alloca i32
store i32 %size, i32* %2
%3= alloca i32
store i32 1,i32* %3
br label %for.cond.0
for.cond.0:
%4= load i32,i32* %3
%5= icmp eq i32 %4,1
br i1 %5, label %for.body.0, label %for.exit.0
for.body.0:
store i32 0,i32* %3
br label %for.init.1
for.init.1:
%6 = alloca i32, align 4
store i32 0,i32* %6
br label %for.cond.1
for.cond.1:
%7 = load i32,i32* %6
%8 = load i32,i32* %2
%9 = icmp slt i32 %7,%8
br i1 %9, label %for.body.1, label %for.exit.1
for.body.1:
%10= load i32,i32* %6
%11= load i32*,i32** %1
%12= getelementptr inbounds i32,i32* %11, i32 %10
%13= load i32,i32* %12
%14= load i32,i32* %6
%15= add nsw i32 %14,1
%16= load i32*,i32** %1
%17= getelementptr inbounds i32,i32* %16, i32 %15
%18= load i32,i32* %17
%19= icmp sgt i32 %13,%18
br i1 %19, label %if.body.0, label %if.elif.0.0
if.body.0:
%20= load i32,i32* %6
%21= add nsw i32 %20,1
%22= load i32*,i32** %1
%23= getelementptr inbounds i32,i32* %22, i32 %21
%24= load i32,i32* %23
%25= alloca i32
store i32 %24,i32* %25
%26= load i32,i32* %6
%27= add nsw i32 %26,1
%28= load i32*,i32** %1
%29= getelementptr inbounds i32,i32* %28, i32 %27
%30= load i32,i32* %6
%31= load i32*,i32** %1
%32= getelementptr inbounds i32,i32* %31, i32 %30
%33= load i32,i32* %32
store i32 %33,i32* %29
%34= load i32,i32* %6
%35= load i32*,i32** %1
%36= getelementptr inbounds i32,i32* %35, i32 %34
%37= load i32,i32* %25
store i32 %37,i32* %36
store i32 1,i32* %3
br label %if.exit.0.0
if.elif.0.0:
br label %if.exit.0.0
if.exit.0.0:
br label %for.inc.1
for.inc.1:
%38 = load i32,i32* %6
%39 = add nsw i32 %38,1
store i32 %39,i32* %6
br label %for.cond.1
for.exit.1:
br label %for.inc.0
for.inc.0:
%40 = add nsw i32 0,0
br label %for.cond.0
for.exit.0:
ret void
}
define void @main (){
call void () @globalinit()
%1= alloca [5 x i32]
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
%7 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.0 , i32 0, i32 0
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
br label %for.inc.2
for.inc.2:
%19 = load i32,i32* %11
%20 = add nsw i32 %19,1
store i32 %20,i32* %11
br label %for.cond.2
for.exit.2:
%21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
%22 = getelementptr inbounds [5 x i32],[5 x i32]* %1,i32 0,i32 0
call void (i32*,i32) @bubble(i32* %22,i32 4)
%23 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.1 , i32 0, i32 0
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
br label %for.inc.3
for.inc.3:
%35 = load i32,i32* %27
%36 = add nsw i32 %35,1
store i32 %36,i32* %27
br label %for.cond.3
for.exit.3:
%37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
ret void
}

