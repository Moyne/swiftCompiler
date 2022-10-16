func bubble(_ arr: inout [Int],_ size: Int){
    var swap=1
    while swap==1 {
        swap = 0
        for i in 0..<size {
            if arr[i] > arr[i + 1] {
                let temp=arr [i + 1]
                arr [i + 1] = arr[i] 
                arr[i] = temp
                swap = 1
            }
        }
    }
}
func main(){
    var x : [Int] = [715,14,1,99,2]
    println("Array before:")
    for i in 0...4 {
        print(x[i])
    }
    println();
    bubble(&x,4)
    println("Array after:")
    for i in 0 ... 4 {
        print(x[i])
    }
    println();
}