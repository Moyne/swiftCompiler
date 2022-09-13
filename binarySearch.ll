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

@searchVal = global i32 77
@dimArr = global i32 11
@.str.0 = constant [10 x i8] c"The value\00"
@.str.1 = constant [27 x i8] c"was FOUND in the position:\00"
@.str.2 = constant [10 x i8] c"The value\00"
@.str.3 = constant [27 x i8] c"was NOT FOUND in the array\00"
;GLOBAL INITIALIZATIONS OF GLOBAL VARIABLES THAT ARE STRINGS OR ARRAYS OF STRINGS
define void @globalinit(){
ret void
}

define i32 @binarySearch (i32* %arr,i32 %search,i32 %low,i32 %high){
%1 = alloca i32*
store i32* %arr, i32** %1
%2 = alloca i32
store i32 %search, i32* %2
%3 = alloca i32
store i32 %low, i32* %3
%4 = alloca i32
store i32 %high, i32* %4
%5= load i32,i32* %3
%6= load i32,i32* %4
%7= icmp sgt i32 %5,%6
br i1 %7, label %if.body.0, label %if.elif.0.0
if.body.0:
ret i32 -1
br label %if.exit.0.0
if.elif.0.0:
%9= load i32,i32* %3
%10= load i32,i32* %4
%11= add nsw i32 %9,%10
%12= sdiv i32 %11,2
%13= alloca i32
store i32 %12,i32* %13
%14= load i32,i32* %2
%15= load i32,i32* %13
%16= load i32*,i32** %1
%17= getelementptr inbounds i32,i32* %16, i32 %15
%18= load i32,i32* %17
%19= icmp eq i32 %14,%18
br i1 %19, label %if.body.1, label %if.elif.1.0
if.body.1:
%20= load i32,i32* %13
ret i32 %20
br label %if.exit.1.0
if.elif.1.0:
%22= load i32,i32* %2
%23= load i32,i32* %13
%24= load i32*,i32** %1
%25= getelementptr inbounds i32,i32* %24, i32 %23
%26= load i32,i32* %25
%27= icmp sgt i32 %22,%26
br i1 %27, label %if.body.1.0, label %if.elif.1.1
if.body.1.0:
%28 = load i32*,i32** %1
%29= load i32,i32* %2
%30= load i32,i32* %13
%31= add nsw i32 %30,1
%32= load i32,i32* %4
%33=call i32 (i32*,i32,i32,i32) @binarySearch(i32* %28,i32 %29,i32 %31,i32 %32)
ret i32 %33
br label %if.exit.1.0
if.elif.1.1:
%35 = load i32*,i32** %1
%36= load i32,i32* %2
%37= load i32,i32* %3
%38= load i32,i32* %13
%39= sub i32 %38,1
%40=call i32 (i32*,i32,i32,i32) @binarySearch(i32* %35,i32 %36,i32 %37,i32 %39)
ret i32 %40
br label %if.exit.1.0
if.exit.1.0:
br label %if.exit.0.0
if.exit.0.0:
ret i32 -1
}
define void @main (){
call void () @globalinit()
%1= alloca [11 x i32]
%2 = getelementptr inbounds [11 x i32],[11 x i32]* %1,i32 0,i32 0
store i32 1,i32* %2
%3 = getelementptr inbounds [11 x i32],[11 x i32]* %1,i32 0,i32 1
store i32 2,i32* %3
%4 = getelementptr inbounds [11 x i32],[11 x i32]* %1,i32 0,i32 2
store i32 4,i32* %4
%5 = getelementptr inbounds [11 x i32],[11 x i32]* %1,i32 0,i32 3
store i32 7,i32* %5
%6 = getelementptr inbounds [11 x i32],[11 x i32]* %1,i32 0,i32 4
store i32 26,i32* %6
%7 = getelementptr inbounds [11 x i32],[11 x i32]* %1,i32 0,i32 5
store i32 77,i32* %7
%8 = getelementptr inbounds [11 x i32],[11 x i32]* %1,i32 0,i32 6
store i32 79,i32* %8
%9 = getelementptr inbounds [11 x i32],[11 x i32]* %1,i32 0,i32 7
store i32 82,i32* %9
%10 = getelementptr inbounds [11 x i32],[11 x i32]* %1,i32 0,i32 8
store i32 99,i32* %10
%11 = getelementptr inbounds [11 x i32],[11 x i32]* %1,i32 0,i32 9
store i32 102,i32* %11
%12 = getelementptr inbounds [11 x i32],[11 x i32]* %1,i32 0,i32 10
store i32 134,i32* %12
%13 = getelementptr inbounds [11 x i32],[11 x i32]* %1,i32 0,i32 0
%14= load i32,i32* @searchVal
%15= load i32,i32* @dimArr
%16= sub i32 %15,1
%17=call i32 (i32*,i32,i32,i32) @binarySearch(i32* %13,i32 %14,i32 0,i32 %16)
%18= alloca i32
store i32 %17,i32* %18
%19= load i32,i32* %18
%20= icmp ne i32 %19,-1
br i1 %20, label %if.body.2, label %if.elif.2.0
if.body.2:
%21 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.0 , i32 0, i32 0
%22= load i32,i32* @searchVal
%23 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.1 , i32 0, i32 0
%24= load i32,i32* %18
%25 = call i32 (i8*, ...) @printf(i8* %21)
%26= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%27= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %22)
%28= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%29 = call i32 (i8*, ...) @printf(i8* %23)
%30= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%31= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %24)
%32= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %if.exit.2.0
if.elif.2.0:
%34 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.2 , i32 0, i32 0
%35= load i32,i32* @searchVal
%36 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.3 , i32 0, i32 0
%37 = call i32 (i8*, ...) @printf(i8* %34)
%38= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%39= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %35)
%40= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%41 = call i32 (i8*, ...) @printf(i8* %36)
%42= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%43 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
br label %if.exit.2.0
if.exit.2.0:
ret void
}

