declare i32 @printf(i8*, ...)
declare i32 @sprintf(i8*,i8*, ...)
declare i8* @strcat(i8*,i8*)
declare i8* @strcpy(i8*,i8*)
@.str.newline = constant [2 x i8] c"\0A\00"
@.str.int = constant [3 x i8] c"%d\00"
@.str.double = constant [4 x i8] c"%lf\00"

@ef = global i32 2
@of = global [2 x i32] [i32 4,i32 1]
@.str.0 = constant [6 x i8] c"afbaj\00"
@.str.1 = constant [5 x i8] c"jmpn\00"
@.str.2 = constant [10 x i8] c" , ora x \00"
@.str.3 = constant [1 x i8] c"\00"
@.str.4 = constant [10 x i8] c"X equals \00"
@.str.5 = constant [1 x i8] c"\00"

define void @main (){
%1= alloca i32,align 4
store i32 2,i32* %1
%2 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0 , i32 0, i32 0
%3= alloca i8*,align 4
store i8* %2,i8** %3
%4 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1 , i32 0, i32 0
%5= load i32,i32* %1
%6 = alloca [20 x i8], align 1
%7 = getelementptr inbounds [20 x i8], [20 x i8]* %6 , i32 0, i32 0
%8 = call i32 (i8*,i8*, ...) @sprintf(i8* %7,i8* getelementptr inbounds([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %5)
%9 = alloca [200 x i8], align 1
%10 = getelementptr inbounds [200 x i8], [200 x i8]* %9 , i32 0, i32 0
%11 = call i8* (i8*,i8*) @strcpy(i8* %10,i8* getelementptr inbounds([10 x i8], [10 x i8]* @.str.2, i32 0, i32 0))
%12 = call i8* (i8*,i8*) @strcat(i8* %10,i8* %7)
%13 = call i8* (i8*,i8*) @strcat(i8* %10,i8* getelementptr inbounds([1 x i8], [1 x i8]* @.str.3 , i32 0, i32 0))
%14= alloca [200 x i8]
%15= getelementptr inbounds [200 x i8],[200 x i8]* %14,i32 0, i32 0
%16 = call i8* (i8*,i8*) @strcpy(i8* %15,i8* %4)
%17 = call i8* (i8*,i8*) @strcat(i8* %15,i8* %10)
%18= alloca [200 x i8]
%19= getelementptr inbounds [200 x i8],[200 x i8]* %18,i32 0, i32 0
%20= load i8*,i8** %3
%21 = call i8* (i8*,i8*) @strcpy(i8* %19,i8* %20)
%22 = call i8* (i8*,i8*) @strcat(i8* %19,i8* %17)
store i8* %19,i8** %3
%23= load i32,i32* %1
%24 = add nsw i32 %23,5
store i32 %24,i32* %1
%25= load i32,i32* %1
%26 = alloca [20 x i8], align 1
%27 = getelementptr inbounds [20 x i8], [20 x i8]* %26 , i32 0, i32 0
%28 = call i32 (i8*,i8*, ...) @sprintf(i8* %27,i8* getelementptr inbounds([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %25)
%29 = alloca [200 x i8], align 1
%30 = getelementptr inbounds [200 x i8], [200 x i8]* %29 , i32 0, i32 0
%31 = call i8* (i8*,i8*) @strcpy(i8* %30,i8* getelementptr inbounds([10 x i8], [10 x i8]* @.str.4, i32 0, i32 0))
%32 = call i8* (i8*,i8*) @strcat(i8* %30,i8* %27)
%33 = call i8* (i8*,i8*) @strcat(i8* %30,i8* getelementptr inbounds([1 x i8], [1 x i8]* @.str.5 , i32 0, i32 0))
%34 = call i32 (i8*, ...) @printf(i8* %30)
%35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
%36 = load i8*,i8** %3
%37 = call i32 (i8*, ...) @printf(i8* %36)
ret void
}
