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

@.str.0 = constant [2 x i8] c"[\00"
@.str.1 = constant [2 x i8] c",\00"
@.str.2 = constant [2 x i8] c"]\00"
@.str.3 = constant [2 x i8] c",\00"
@.str.4 = constant [14 x i8] c"The array is:\00"
;GLOBAL INITIALIZATIONS OF GLOBAL VARIABLES THAT ARE STRINGS OR ARRAYS OF STRINGS
define void @globalinit(){
ret void
}

define void @printarr (i32* %arr,i32 %dim.0.0,i32 %dim.0.1){
%1 = alloca i32*
store i32* %arr, i32** %1
br label %for.init.0
for.init.0:
%2 = alloca i32, align 4
store i32 0,i32* %2
br label %for.cond.0
for.cond.0:
%3 = load i32,i32* %2
%4 = icmp slt i32 %3,2
br i1 %4, label %for.body.0, label %for.exit.0
for.body.0:
br label %for.init.1
for.init.1:
%5 = alloca i32, align 4
store i32 0,i32* %5
br label %for.cond.1
for.cond.1:
%6 = load i32,i32* %5
%7 = icmp slt i32 %6,3
br i1 %7, label %for.body.1, label %for.exit.1
for.body.1:
%8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0 , i32 0, i32 0
%9 = call i32 (i8*, ...) @printf(i8* %8)
%10= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
br label %for.init.2
for.init.2:
%11 = alloca i32, align 4
store i32 0,i32* %11
br label %for.cond.2
for.cond.2:
%12 = load i32,i32* %11
%13 = icmp slt i32 %12,4
br i1 %13, label %for.body.2, label %for.exit.2
for.body.2:
%14= load i32,i32* %2
%15= mul i32 %dim.0.0,%14
%16= mul i32 %15,%dim.0.1
%17= load i32,i32* %5
%18= mul i32 %dim.0.1,%17
%19= add nsw i32 %18,%16
%20= load i32,i32* %11
%21= add nsw i32 %20,%19
%22= load i32*,i32** %1
%23= getelementptr inbounds i32,i32* %22, i32 %21
%24= load i32,i32* %23
%25= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %24)
%26= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%27= load i32,i32* %11
%28= icmp ne i32 %27,3
br i1 %28, label %if.body.0, label %if.elif.0.0
if.body.0:
%29 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.1 , i32 0, i32 0
%30 = call i32 (i8*, ...) @printf(i8* %29)
%31= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
br label %if.exit.0.0
if.elif.0.0:
br label %if.exit.0.0
if.exit.0.0:
br label %for.inc.2
for.inc.2:
%32 = load i32,i32* %11
%33 = add nsw i32 %32,1
store i32 %33,i32* %11
br label %for.cond.2
for.exit.2:
%34 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2 , i32 0, i32 0
%35 = call i32 (i8*, ...) @printf(i8* %34)
%36= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%37= load i32,i32* %5
%38= icmp ne i32 %37,2
br i1 %38, label %if.body.1, label %if.elif.1.0
if.body.1:
%39 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3 , i32 0, i32 0
%40 = call i32 (i8*, ...) @printf(i8* %39)
%41= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
br label %if.exit.1.0
if.elif.1.0:
br label %if.exit.1.0
if.exit.1.0:
br label %for.inc.1
for.inc.1:
%42 = load i32,i32* %5
%43 = add nsw i32 %42,1
store i32 %43,i32* %5
br label %for.cond.1
for.exit.1:
%44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %for.inc.0
for.inc.0:
%45 = load i32,i32* %2
%46 = add nsw i32 %45,1
store i32 %46,i32* %2
br label %for.cond.0
for.exit.0:
ret void
}
define void @main (){
call void () @globalinit()
%1= alloca [2 x [3 x [4 x i32]]]
%2 = getelementptr inbounds [2 x [3 x [4 x i32]]],[2 x [3 x [4 x i32]]]* %1,i32 0,i32 0
%3 = getelementptr inbounds [3 x [4 x i32]],[3 x [4 x i32]]* %2,i32 0,i32 0
%4 = getelementptr inbounds [4 x i32],[4 x i32]* %3,i32 0,i32 0
store i32 1,i32* %4
%5 = getelementptr inbounds [4 x i32],[4 x i32]* %3,i32 0,i32 1
store i32 2,i32* %5
%6 = getelementptr inbounds [4 x i32],[4 x i32]* %3,i32 0,i32 2
store i32 3,i32* %6
%7 = getelementptr inbounds [4 x i32],[4 x i32]* %3,i32 0,i32 3
store i32 4,i32* %7
%8 = getelementptr inbounds [3 x [4 x i32]],[3 x [4 x i32]]* %2,i32 0,i32 1
%9 = getelementptr inbounds [4 x i32],[4 x i32]* %8,i32 0,i32 0
store i32 5,i32* %9
%10 = getelementptr inbounds [4 x i32],[4 x i32]* %8,i32 0,i32 1
store i32 6,i32* %10
%11 = getelementptr inbounds [4 x i32],[4 x i32]* %8,i32 0,i32 2
store i32 7,i32* %11
%12 = getelementptr inbounds [4 x i32],[4 x i32]* %8,i32 0,i32 3
store i32 8,i32* %12
%13 = getelementptr inbounds [3 x [4 x i32]],[3 x [4 x i32]]* %2,i32 0,i32 2
%14 = getelementptr inbounds [4 x i32],[4 x i32]* %13,i32 0,i32 0
store i32 9,i32* %14
%15 = getelementptr inbounds [4 x i32],[4 x i32]* %13,i32 0,i32 1
store i32 10,i32* %15
%16 = getelementptr inbounds [4 x i32],[4 x i32]* %13,i32 0,i32 2
store i32 11,i32* %16
%17 = getelementptr inbounds [4 x i32],[4 x i32]* %13,i32 0,i32 3
store i32 12,i32* %17
%18 = getelementptr inbounds [2 x [3 x [4 x i32]]],[2 x [3 x [4 x i32]]]* %1,i32 0,i32 1
%19 = getelementptr inbounds [3 x [4 x i32]],[3 x [4 x i32]]* %18,i32 0,i32 0
%20 = getelementptr inbounds [4 x i32],[4 x i32]* %19,i32 0,i32 0
store i32 13,i32* %20
%21 = getelementptr inbounds [4 x i32],[4 x i32]* %19,i32 0,i32 1
store i32 14,i32* %21
%22 = getelementptr inbounds [4 x i32],[4 x i32]* %19,i32 0,i32 2
store i32 15,i32* %22
%23 = getelementptr inbounds [4 x i32],[4 x i32]* %19,i32 0,i32 3
store i32 16,i32* %23
%24 = getelementptr inbounds [3 x [4 x i32]],[3 x [4 x i32]]* %18,i32 0,i32 1
%25 = getelementptr inbounds [4 x i32],[4 x i32]* %24,i32 0,i32 0
store i32 17,i32* %25
%26 = getelementptr inbounds [4 x i32],[4 x i32]* %24,i32 0,i32 1
store i32 18,i32* %26
%27 = getelementptr inbounds [4 x i32],[4 x i32]* %24,i32 0,i32 2
store i32 19,i32* %27
%28 = getelementptr inbounds [4 x i32],[4 x i32]* %24,i32 0,i32 3
store i32 20,i32* %28
%29 = getelementptr inbounds [3 x [4 x i32]],[3 x [4 x i32]]* %18,i32 0,i32 2
%30 = getelementptr inbounds [4 x i32],[4 x i32]* %29,i32 0,i32 0
store i32 21,i32* %30
%31 = getelementptr inbounds [4 x i32],[4 x i32]* %29,i32 0,i32 1
store i32 22,i32* %31
%32 = getelementptr inbounds [4 x i32],[4 x i32]* %29,i32 0,i32 2
store i32 23,i32* %32
%33 = getelementptr inbounds [4 x i32],[4 x i32]* %29,i32 0,i32 3
store i32 24,i32* %33
%34 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.4 , i32 0, i32 0
%35 = call i32 (i8*, ...) @printf(i8* %34)
%36= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
%38 = getelementptr inbounds [2 x [3 x [4 x i32]]],[2 x [3 x [4 x i32]]]* %1,i32 0,i32 0
%39 = getelementptr inbounds [3 x [4 x i32]],[3 x [4 x i32]]* %38,i32 0,i32 0
%40 = getelementptr inbounds [4 x i32],[4 x i32]* %39,i32 0,i32 0
call void (i32*,i32,i32) @printarr(i32* %40,i32 3,i32 4)
ret void
}

