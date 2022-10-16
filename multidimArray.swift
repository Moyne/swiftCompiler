func printarr(_ arr:[[[Int]]]){
    for a in 0..<2{
        for b in 0..<3{
            print("[")
            for c in 0..<4{
                print(arr[a][b][c])
                if c!=3{
                    print(",")
                }
            }
            print("]")
            if b!=2{
                print(",")
            }
        }
        println()
    }
}
func main(){
    let arr=[[[1,2,3,4],[5,6,7,8],[9,10,11,12]],[[13,14,15,16],[17,18,19,20],[21,22,23,24]]]
    println("The array is:")
    printarr(arr)
}