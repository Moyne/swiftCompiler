func division(quotient a:Double,dividend b:Double,result x:inout Double)->Int{
    if b==0.0{
        return -1
    }
    x=a/b
    return 1
}
func main(){
    let a=225.15
    let b=3.151
    var x:Double=0.0
    let res=division(quotient:a,dividend:b,result:&x)
    if res==-1{
        println("Division with 0!")
    }
    else{
        println("The result of \(a)/\(b) is:",x)
    }
}