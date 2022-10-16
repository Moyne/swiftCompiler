let iterations=10
func fibonacci(num: Int) -> Int{
    if num==0{
        return 0
    }
    else if num==1{
        return 1
    }
    return fibonacci(num: num-1)+fibonacci(num: num-2)
}
func main(){
    let arr=[22,15,10,12,3,8,1,0,5,32]
    println("This program calculates the fibonacci values for the array specified(it is correct for every result representable in a signed integer of 32 bits, so until 46), here are the results:")
    for a in 0..<iterations{
        println("The result of the fibonacci of",arr[a],"is:",fibonacci(num:arr[a]))
    }
}