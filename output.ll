declare i32 @printf(i8*, ...)
declare i32 @sprintf(i8*,i8*, ...)
declare i8* @strcat(i8*,i8*)
declare i8* @strcpy(i8*,i8*)
@.str.0 = constant [20 x i8] c" while 89xxbla bla \00"
@.str.1 = constant [25 x i8] c"The result of 13x2 is : \00"
@.str.2 = constant [15 x i8] c" end of string\00"
@.str.newline = constant [2 x i8] c"\0A\00"
@.str.int = constant [3 x i8] c"%d\00"

define void @main (){

%1= alloca i32,align 4
%2= mul i32 13,2
store i32 %2,i32* %1
%3= load i32,i32* %1
%4 = alloca [150 x i8], align 1
%5 = getelementptr inbounds [150 x i8], [150 x i8]* %4 , i32 0, i32 0
%6 = call i32 (i8*,i8*, ...) @sprintf(i8* %5,i8* getelementptr inbounds([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %3)
%7 = call i8* (i8*,i8*) @strcat(i8* %5,i8* getelementptr inbounds([20 x i8], [20 x i8]* @.str.0 , i32 0, i32 0))
%8= load i32,i32* %1
%9= mul i32 89,%8
%10= add nsw i32 %9,2
%11 = alloca [20 x i8], align 1
%12 = getelementptr inbounds [20 x i8], [20 x i8]* %11 , i32 0, i32 0
%13 = call i32 (i8*,i8*, ...) @sprintf(i8* %12,i8* getelementptr inbounds([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), i32 %10)
%14 = call i8* (i8*,i8*) @strcat(i8* %5,i8* %12)
%15 = alloca [200 x i8], align 1
%16 = getelementptr inbounds [200 x i8], [200 x i8]* %15 , i32 0, i32 0
%17 = call i8* (i8*,i8*) @strcpy(i8* %16,i8* getelementptr inbounds([25 x i8], [25 x i8]* @.str.1, i32 0, i32 0))
%18 = call i8* (i8*,i8*) @strcat(i8* %16,i8* %5)
%19 = call i8* (i8*,i8*) @strcat(i8* %16,i8* getelementptr inbounds([15 x i8], [15 x i8]* @.str.2 , i32 0, i32 0))
%20 = call i32 (i8*, ...) @printf(i8* %16)
%21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds([2 x i8], [2 x i8]* @.str.newline, i32 0, i32 0))
ret void
}

