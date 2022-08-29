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

@arrtests = global [2 x [3 x [5 x i32]]]  [[3 x [5 x i32]] [[5 x i32] [i32 1,i32 2,i32 3,i32 4,i32 5] ,[5 x i32] [i32 6,i32 7,i32 8,i32 9,i32 10] ,[5 x i32] [i32 11,i32 12,i32 13,i32 14,i32 15]  ],[3 x [5 x i32]] [[5 x i32] [i32 16,i32 17,i32 18,i32 19,i32 20] ,[5 x i32] [i32 21,i32 22,i32 23,i32 24,i32 25] ,[5 x i32] [i32 26,i32 27,i32 28,i32 29,i32 30]  ] ]
@.str.0 = constant [14 x i8] c"Global array:\00"
@.str.1 = constant [3 x i8] c"--\00"
@.str.2 = constant [5 x i8] c"----\00"
@.str.3 = constant [14 x i8] c"Array before:\00"
@.str.4 = constant [13 x i8] c"Array after:\00"
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
define void @arrglobfunc (i32* %arr,i32 %dim.0.0,i32 %dim.0.1){
%1 = alloca i32*
store i32* %arr, i32** %1
%2 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.0 , i32 0, i32 0
%3 = call i32 (i8*, ...) @printf(i8* %2)
%4= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.init.2
for.init.2:
%6 = alloca i32, align 4
store i32 0,i32* %6
br label %for.cond.2
for.cond.2:
%7 = load i32,i32* %6
%8 = icmp sle i32 %7,1
br i1 %8, label %for.body.2, label %for.exit.2
for.body.2:
br label %for.init.3
for.init.3:
%9 = alloca i32, align 4
store i32 0,i32* %9
br label %for.cond.3
for.cond.3:
%10 = load i32,i32* %9
%11 = icmp sle i32 %10,2
br i1 %11, label %for.body.3, label %for.exit.3
for.body.3:
br label %for.init.4
for.init.4:
%12 = alloca i32, align 4
store i32 0,i32* %12
br label %for.cond.4
for.cond.4:
%13 = load i32,i32* %12
%14 = icmp sle i32 %13,4
br i1 %14, label %for.body.4, label %for.exit.4
for.body.4:
%15= load i32,i32* %6
%16= mul i32 %dim.0.0,%15
%17= mul i32 %16,%dim.0.1
%18= load i32,i32* %9
%19= mul i32 %dim.0.1,%18
%20= add nsw i32 %19,%17
%21= load i32,i32* %12
%22= add nsw i32 %21,%20
%23= load i32*,i32** %1
%24= getelementptr inbounds i32,i32* %23, i32 %22
%25= load i32,i32* %24
%26= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %25)
%27= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.inc.4
for.inc.4:
%29 = load i32,i32* %12
%30 = add nsw i32 %29,1
store i32 %30,i32* %12
br label %for.cond.4
for.exit.4:
%31 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1 , i32 0, i32 0
%32 = call i32 (i8*, ...) @printf(i8* %31)
%33= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.inc.3
for.inc.3:
%35 = load i32,i32* %9
%36 = add nsw i32 %35,1
store i32 %36,i32* %9
br label %for.cond.3
for.exit.3:
%37 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2 , i32 0, i32 0
%38 = call i32 (i8*, ...) @printf(i8* %37)
%39= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.inc.2
for.inc.2:
%41 = load i32,i32* %6
%42 = add nsw i32 %41,1
store i32 %42,i32* %6
br label %for.cond.2
for.exit.2:
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
%7= alloca i32,align 4
store i32 -9,i32* %7
%8= load i32,i32* %7
%9= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %8)
%10= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
%12 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.3 , i32 0, i32 0
%13 = call i32 (i8*, ...) @printf(i8* %12)
%14= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.init.5
for.init.5:
%16 = alloca i32, align 4
store i32 0,i32* %16
br label %for.cond.5
for.cond.5:
%17 = load i32,i32* %16
%18 = icmp sle i32 %17,4
br i1 %18, label %for.body.5, label %for.exit.5
for.body.5:
%19= load i32,i32* %16
%20 = getelementptr inbounds [5 x i32],[5 x i32]* %1, i32 0, i32 %19
%21= load i32,i32* %20
%22= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %21)
%23= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.inc.5
for.inc.5:
%25 = load i32,i32* %16
%26 = add nsw i32 %25,1
store i32 %26,i32* %16
br label %for.cond.5
for.exit.5:
%27 = getelementptr inbounds [5 x i32],[5 x i32]* %1,i32 0,i32 0
call void (i32*) @bubble(i32* %27)
%28 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.4 , i32 0, i32 0
%29 = call i32 (i8*, ...) @printf(i8* %28)
%30= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.init.6
for.init.6:
%32 = alloca i32, align 4
store i32 0,i32* %32
br label %for.cond.6
for.cond.6:
%33 = load i32,i32* %32
%34 = icmp sle i32 %33,4
br i1 %34, label %for.body.6, label %for.exit.6
for.body.6:
%35= load i32,i32* %32
%36 = getelementptr inbounds [5 x i32],[5 x i32]* %1, i32 0, i32 %35
%37= load i32,i32* %36
%38= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %37)
%39= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.inc.6
for.inc.6:
%41 = load i32,i32* %32
%42 = add nsw i32 %41,1
store i32 %42,i32* %32
br label %for.cond.6
for.exit.6:
%43 = getelementptr inbounds [2 x [3 x [5 x i32]]],[2 x [3 x [5 x i32]]]* @arrtests,i32 0,i32 0
%44 = getelementptr inbounds [3 x [5 x i32]],[3 x [5 x i32]]* %43,i32 0,i32 0
%45 = getelementptr inbounds [5 x i32],[5 x i32]* %44,i32 0,i32 0
call void (i32*,i32,i32) @arrglobfunc(i32* %45,i32 3,i32 5)
ret void
}

