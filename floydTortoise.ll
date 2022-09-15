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

@.str.0 = constant [18 x i8] c"Here is the list:\00"
@.str.1 = constant [3 x i8] c"->\00"
@.str.2 = constant [1 x i8] c"\00"
@.str.3 = constant [1 x i8] c"\00"
@.str.4 = constant [23 x i8] c"\0AFound a cycle of size\00"
@.str.5 = constant [24 x i8] c"that starts at position\00"
@.str.6 = constant [13 x i8] c"in this list\00"
@.str.7 = constant [36 x i8] c"\0ADidn't find any cycle in this list\00"
;GLOBAL INITIALIZATIONS OF GLOBAL VARIABLES THAT ARE STRINGS OR ARRAYS OF STRINGS
define void @globalinit(){
ret void
}

define i32 @cycleDetection (i32* %arr,i32 %size,i32 %start,i32* %mu,i32* %lam){
%1 = alloca i32*
store i32* %arr, i32** %1
%2 = alloca i32
store i32 %size, i32* %2
%3 = alloca i32
store i32 %start, i32* %3
%4 = alloca i32*
store i32* %mu, i32** %4
%5 = load i32*,i32** %4
%6 = alloca i32*
store i32* %lam, i32** %6
%7 = load i32*,i32** %6
%8= load i32,i32* %3
%9= alloca i32
store i32 %8,i32* %9
%10= load i32,i32* %3
%11= alloca i32
store i32 %10,i32* %11
%12= load i32,i32* %9
%13= load i32*,i32** %1
%14= getelementptr inbounds i32,i32* %13, i32 %12
%15= load i32,i32* %14
store i32 %15,i32* %9
%16= load i32,i32* %11
%17= load i32*,i32** %1
%18= getelementptr inbounds i32,i32* %17, i32 %16
%19= load i32,i32* %18
%20= load i32*,i32** %1
%21= getelementptr inbounds i32,i32* %20, i32 %19
%22= load i32,i32* %21
store i32 %22,i32* %11
br label %for.cond.0
for.cond.0:
%23= load i32,i32* %9
%24= load i32,i32* %11
%25= icmp ne i32 %23,%24
br i1 %25, label %for.body.0, label %for.exit.0
for.body.0:
%26= load i32,i32* %9
%27= load i32*,i32** %1
%28= getelementptr inbounds i32,i32* %27, i32 %26
%29= load i32,i32* %28
store i32 %29,i32* %9
%30= load i32,i32* %11
%31= load i32*,i32** %1
%32= getelementptr inbounds i32,i32* %31, i32 %30
%33= load i32,i32* %32
%34= load i32*,i32** %1
%35= getelementptr inbounds i32,i32* %34, i32 %33
%36= load i32,i32* %35
store i32 %36,i32* %11
%37= load i32,i32* %11
%38= load i32,i32* %2
%39= sub i32 %38,1
%40= icmp sgt i32 %37,%39
br i1 %40, label %if.body.0, label %if.elif.0.0
if.body.0:
ret i32 -1
br label %if.exit.0.0
if.elif.0.0:
br label %if.exit.0.0
if.exit.0.0:
br label %for.inc.0
for.inc.0:
%42 = add nsw i32 0,0
br label %for.cond.0
for.exit.0:
store i32 0,i32* %5
store i32 0,i32* %9
br label %for.cond.1
for.cond.1:
%43= load i32,i32* %9
%44= load i32,i32* %11
%45= icmp ne i32 %43,%44
br i1 %45, label %for.body.1, label %for.exit.1
for.body.1:
%46= load i32,i32* %9
%47= load i32*,i32** %1
%48= getelementptr inbounds i32,i32* %47, i32 %46
%49= load i32,i32* %48
store i32 %49,i32* %9
%50= load i32,i32* %11
%51= load i32*,i32** %1
%52= getelementptr inbounds i32,i32* %51, i32 %50
%53= load i32,i32* %52
store i32 %53,i32* %11
%54= load i32,i32* %5
%55 = add nsw i32 %54,1
store i32 %55,i32* %5
br label %for.inc.1
for.inc.1:
%56 = add nsw i32 0,0
br label %for.cond.1
for.exit.1:
store i32 1,i32* %7
%57= load i32,i32* %11
%58= load i32*,i32** %1
%59= getelementptr inbounds i32,i32* %58, i32 %57
%60= load i32,i32* %59
store i32 %60,i32* %11
br label %for.cond.2
for.cond.2:
%61= load i32,i32* %9
%62= load i32,i32* %11
%63= icmp ne i32 %61,%62
br i1 %63, label %for.body.2, label %for.exit.2
for.body.2:
%64= load i32,i32* %11
%65= load i32*,i32** %1
%66= getelementptr inbounds i32,i32* %65, i32 %64
%67= load i32,i32* %66
store i32 %67,i32* %11
%68= load i32,i32* %7
%69 = add nsw i32 %68,1
store i32 %69,i32* %7
br label %for.inc.2
for.inc.2:
%70 = add nsw i32 0,0
br label %for.cond.2
for.exit.2:
ret i32 1
ret i32 -1
}
define void @main (){
call void () @globalinit()
%1= alloca [8 x i32]
%2 = getelementptr inbounds [8 x i32],[8 x i32]* %1,i32 0,i32 0
store i32 1,i32* %2
%3 = getelementptr inbounds [8 x i32],[8 x i32]* %1,i32 0,i32 1
store i32 2,i32* %3
%4 = getelementptr inbounds [8 x i32],[8 x i32]* %1,i32 0,i32 2
store i32 3,i32* %4
%5 = getelementptr inbounds [8 x i32],[8 x i32]* %1,i32 0,i32 3
store i32 4,i32* %5
%6 = getelementptr inbounds [8 x i32],[8 x i32]* %1,i32 0,i32 4
store i32 5,i32* %6
%7 = getelementptr inbounds [8 x i32],[8 x i32]* %1,i32 0,i32 5
store i32 6,i32* %7
%8 = getelementptr inbounds [8 x i32],[8 x i32]* %1,i32 0,i32 6
store i32 7,i32* %8
%9 = getelementptr inbounds [8 x i32],[8 x i32]* %1,i32 0,i32 7
store i32 2,i32* %9
%10 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.0 , i32 0, i32 0
%11 = call i32 (i8*, ...) @printf(i8* %10)
%12= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
%14= alloca i32
store i32 8,i32* %14
%15= alloca i32
store i32 0,i32* %15
%16= alloca i32
store i32 0,i32* %16
br label %for.init.3
for.init.3:
%17 = alloca i32, align 4
store i32 0,i32* %17
br label %for.cond.3
for.cond.3:
%18 = load i32,i32* %17
%19 = load i32,i32* %14
%20 = icmp slt i32 %18,%19
br i1 %20, label %for.body.3, label %for.exit.3
for.body.3:
%21= load i32,i32* %17
%22 = alloca [20 x i8], align 1
%23 = getelementptr inbounds [20 x i8], [20 x i8]* %22 , i32 0, i32 0
%24 = call i32 (i8*,i8*, ...) @sprintf(i8* %23,i8* getelementptr inbounds([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %21)
%25= load i32,i32* %17
%26 = getelementptr inbounds [8 x i32],[8 x i32]* %1, i32 0, i32 %25
%27= load i32,i32* %26
%28 = alloca [200 x i8], align 1
%29 = alloca [20 x i8], align 1
%30 = getelementptr inbounds [20 x i8], [20 x i8]* %29 , i32 0, i32 0
%31 = call i32 (i8*,i8*, ...) @sprintf(i8* %30,i8* getelementptr inbounds([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %27)
%32 = getelementptr inbounds [200 x i8],[200 x i8]* %28,i32 0,i32 0
%33 = call i8* (i8*,i8*) @strcpy(i8* %32,i8* %23)
%34 = call i8* (i8*,i8*) @strcat(i8* %32,i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1,i32 0,i32 0))
%35 = call i8* (i8*,i8*) @strcat(i8* %32,i8* %30)
%36 = alloca [200 x i8], align 1
%37 = getelementptr inbounds [200 x i8], [200 x i8]* %36 , i32 0, i32 0
%38 = call i8* (i8*,i8*) @strcpy(i8* %37,i8* getelementptr inbounds([1 x i8], [1 x i8]* @.str.2, i32 0, i32 0))
%39 = call i8* (i8*,i8*) @strcat(i8* %37,i8* %32)
%40 = call i8* (i8*,i8*) @strcat(i8* %37,i8* getelementptr inbounds([1 x i8], [1 x i8]* @.str.3 , i32 0, i32 0))
%41 = call i32 (i8*, ...) @printf(i8* %37)
%42= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
br label %for.inc.3
for.inc.3:
%43 = load i32,i32* %17
%44 = add nsw i32 %43,1
store i32 %44,i32* %17
br label %for.cond.3
for.exit.3:
%45 = getelementptr inbounds [8 x i32],[8 x i32]* %1,i32 0,i32 0
%46= load i32,i32* %14
%47=call i32 (i32*,i32,i32,i32*,i32*) @cycleDetection(i32* %45,i32 %46,i32 0,i32* %16,i32* %15)
%48= alloca i32
store i32 %47,i32* %48
%49= load i32,i32* %48
%50= icmp sgt i32 %49,0
br i1 %50, label %if.body.1, label %if.elif.1.0
if.body.1:
%51 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.4 , i32 0, i32 0
%52= load i32,i32* %15
%53 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.5 , i32 0, i32 0
%54= load i32,i32* %16
%55 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.6 , i32 0, i32 0
%56 = call i32 (i8*, ...) @printf(i8* %51)
%57= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%58= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %52)
%59= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%60 = call i32 (i8*, ...) @printf(i8* %53)
%61= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%62= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %54)
%63= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%64 = call i32 (i8*, ...) @printf(i8* %55)
%65= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%66 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %if.exit.1.0
if.elif.1.0:
%67 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.7 , i32 0, i32 0
%68 = call i32 (i8*, ...) @printf(i8* %67)
%69= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%70 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %if.exit.1.0
if.exit.1.0:
ret void
}

