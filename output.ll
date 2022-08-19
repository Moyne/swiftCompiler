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

@ef = global i32 2
@.str.0 = constant [13 x i8] c"primastringa\00"
@.str.1 = constant [15 x i8] c"secondastringa\00"
@.str.2 = constant [13 x i8] c"terzastringa\00"
@.str.3 = constant [14 x i8] c"quartastringa\00"
@arrStrGlob = global [2 x [2 x i8*]] zeroinitializer
@support6rand391 = global [200 x i8] zeroinitializer
@support9rand758 = global [200 x i8] zeroinitializer
@support13rand190 = global [200 x i8] zeroinitializer
@support16rand128 = global [200 x i8] zeroinitializer
@.str.4 = constant [9 x i8] c"teststts\00"
@otherglobstr.arr = global [200 x i8] zeroinitializer
@otherglobstr = global i8* getelementptr inbounds([200 x i8],[200 x i8]* @otherglobstr.arr,i32 0,i32 0)
@.str.5 = constant [6 x i8] c"added\00"
@.str.6 = constant [10 x i8] c"X equals \00"
@.str.7 = constant [1 x i8] c"\00"
@.str.8 = constant [13 x i8] c"wow, double \00"
@.str.9 = constant [1 x i8] c"\00"
@.str.10 = constant [4 x i8] c"wow\00"
@.str.11 = constant [5 x i8] c"keke\00"
;GLOBAL INITIALIZATIONS OF GLOBAL VARIABLES THAT ARE STRINGS OR ARRAYS OF STRINGS
define void @globalinit(){
%1 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.0 , i32 0, i32 0
%2 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.1 , i32 0, i32 0
%3 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.2 , i32 0, i32 0
%4 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.3 , i32 0, i32 0
%5 = getelementptr inbounds [2 x [2 x i8*]],[2 x [2 x i8*]]* @arrStrGlob,i32 0,i32 0
%6 = getelementptr inbounds [2 x i8*],[2 x i8*]* %5,i32 0,i32 0
%7 = getelementptr inbounds [200 x i8],[200 x i8]* @support6rand391,i32 0,i32 0
%8 = call i8* (i8*,i8*) @strcpy(i8* %7,i8* %1)
store i8* %7,i8** %6
%9 = getelementptr inbounds [2 x i8*],[2 x i8*]* %5,i32 0,i32 1
%10 = getelementptr inbounds [200 x i8],[200 x i8]* @support9rand758,i32 0,i32 0
%11 = call i8* (i8*,i8*) @strcpy(i8* %10,i8* %2)
store i8* %10,i8** %9
%12 = getelementptr inbounds [2 x [2 x i8*]],[2 x [2 x i8*]]* @arrStrGlob,i32 0,i32 1
%13 = getelementptr inbounds [2 x i8*],[2 x i8*]* %12,i32 0,i32 0
%14 = getelementptr inbounds [200 x i8],[200 x i8]* @support13rand190,i32 0,i32 0
%15 = call i8* (i8*,i8*) @strcpy(i8* %14,i8* %3)
store i8* %14,i8** %13
%16 = getelementptr inbounds [2 x i8*],[2 x i8*]* %12,i32 0,i32 1
%17 = getelementptr inbounds [200 x i8],[200 x i8]* @support16rand128,i32 0,i32 0
%18 = call i8* (i8*,i8*) @strcpy(i8* %17,i8* %4)
store i8* %17,i8** %16
%19 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.4 , i32 0, i32 0
%20= load i8*,i8** @otherglobstr
%21 = call i8* (i8*,i8*) @strcpy(i8* %20,i8* %19)
ret void
}

define void @addStr (i8* %st){
%1 = alloca i8*
store i8* %st, i8** %1
%2= alloca i8*,align 4
%3 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.5 , i32 0, i32 0
%4= alloca [200 x i8]
%5= getelementptr inbounds [200 x i8],[200 x i8]* %4,i32 0, i32 0
%6= load i8*,i8** %1
%7 = call i8* (i8*,i8*) @strcpy(i8* %5,i8* %6)
%8 = call i8* (i8*,i8*) @strcat(i8* %5,i8* %3)
%9 = call i8* (i8*,i8*) @strcpy(i8* %6,i8* %5)
ret void
}
define void @main (){
call void () @globalinit()
%1= alloca i32,align 4
store i32 2,i32* %1
%2= load i32,i32* %1
%3 = add nsw i32 %2,5
store i32 %3,i32* %1
%4= load i32,i32* %1
%5 = alloca [20 x i8], align 1
%6 = getelementptr inbounds [20 x i8], [20 x i8]* %5 , i32 0, i32 0
%7 = call i32 (i8*,i8*, ...) @sprintf(i8* %6,i8* getelementptr inbounds([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %4)
%8 = alloca [200 x i8], align 1
%9 = getelementptr inbounds [200 x i8], [200 x i8]* %8 , i32 0, i32 0
%10 = call i8* (i8*,i8*) @strcpy(i8* %9,i8* getelementptr inbounds([10 x i8], [10 x i8]* @.str.6, i32 0, i32 0))
%11 = call i8* (i8*,i8*) @strcat(i8* %9,i8* %6)
%12 = call i8* (i8*,i8*) @strcat(i8* %9,i8* getelementptr inbounds([1 x i8], [1 x i8]* @.str.7 , i32 0, i32 0))
%13= load i32,i32* %1
%14= add nsw i32 %13,151
%15 = alloca [20 x i8], align 1
%16 = getelementptr inbounds [20 x i8], [20 x i8]* %15 , i32 0, i32 0
%17 = call i32 (i8*,i8*, ...) @sprintf(i8* %16,i8* getelementptr inbounds([4 x i8], [4 x i8]* @.str.double, i32 0, i32 0), double 31.3113)
%18 = alloca [200 x i8], align 1
%19 = getelementptr inbounds [200 x i8], [200 x i8]* %18 , i32 0, i32 0
%20 = call i8* (i8*,i8*) @strcpy(i8* %19,i8* getelementptr inbounds([13 x i8], [13 x i8]* @.str.8, i32 0, i32 0))
%21 = call i8* (i8*,i8*) @strcat(i8* %19,i8* %16)
%22 = call i8* (i8*,i8*) @strcat(i8* %19,i8* getelementptr inbounds([1 x i8], [1 x i8]* @.str.9 , i32 0, i32 0))
%23 = call i32 (i8*, ...) @printf(i8* %9)
%24= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%25= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([3 x i8],[3 x i8]* @.str.int,i32 0,i32 0),i32 %14)
%26= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%27 = call i32 (i8*, ...) @printf(i8* %19)
%28= call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8],[2 x i8]* @.str.space,i32 0,i32 0))
%29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
%30 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.10 , i32 0, i32 0
%31 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.11 , i32 0, i32 0
%32= alloca [2 x i8*],align 4
%33 = getelementptr inbounds [2 x i8*],[2 x i8*]* %32,i32 0,i32 0
%34 = alloca [200 x i8]
%35 = getelementptr inbounds [200 x i8],[200 x i8]* %34,i32 0,i32 0
%36 = call i8* (i8*,i8*) @strcpy(i8* %35,i8* %30)
store i8* %35,i8** %33
%37 = getelementptr inbounds [2 x i8*],[2 x i8*]* %32,i32 0,i32 1
%38 = alloca [200 x i8]
%39 = getelementptr inbounds [200 x i8],[200 x i8]* %38,i32 0,i32 0
%40 = call i8* (i8*,i8*) @strcpy(i8* %39,i8* %31)
store i8* %39,i8** %37
ret void
}
