
let arrtests : [[[Int]]] = [[[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15]],[[16,17,18,19,20],[21,22,23,24,25],[26,27,28,29,30]]] 
func bubble(_ arr: inout [Int]){
    var swap = 1 
    while swap == 1 {
        swap = 0 
        for i in 0 ..< 4 {
            if arr[i] > arr[i + 1] {
                let temp=arr [i + 1] 
                arr [i + 1] = arr[i] 
                arr[i] = temp 
                swap = 1 
            }
        }
    }
}
func arrglobfunc(_ arr: [[[Int]]]){
    print("Global array:")
    var str = "ajfnao***"
    print(str)
    str+=" wow "+" that's crazy!"+" , good luck"
    print(str)
    for i in 0 ... 1 {
        for j in 0 ... 2 {
            for k in 0 ... 4 {
                print(arr[i][j][k])
            }
            print("--")
        }
        print("----")
    }
}
oafnao+=kbna
func main(){
    let faf 
    var agnao
    var x : [Int] = [715,14,1,99,2] 
    var testminus : Int = -9 
    print(testminus) 
    var agag 
    print("Array before:") 
    *-[]
    for i in 0 ... 4 {
        print(x[i])
    }
    bubble(&x) 
    print("Array after:")
    for i in 0 ... 4 {
        print(x[i]) 
    }
    arrglobfunc(arrtests)
}