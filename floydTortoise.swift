func cycleDetection(list arr:[Int],size:Int,start:Int,cycleStart mu:inout Int,cycleSize lam:inout Int)->Int {
    var tortoise=start,hare=start
    tortoise=arr[tortoise]
    hare=arr[arr[hare]]
    while tortoise!=hare {
        tortoise=arr[tortoise]
        hare=arr[arr[hare]]
        if hare>size-1 {
            return -1
        }
    }
    mu=0;tortoise=0
    while tortoise!=hare {
        tortoise=arr[tortoise]
        hare=arr[hare]
        mu+=1
    }
    lam=1;hare=arr[hare]
    while tortoise!=hare {
        hare=arr[hare]
        lam+=1
    }
    return 1
}
func main(){
    let memoryPos=[1,2,3,4,5,6,7,2]
    println("Here is the list:")
    var listSize=8,cSize=0,cStart=0
    for a in 0..<listSize{
        print("\(a)->\(memoryPos[a])")
    }
    let res=cycleDetection(list:memoryPos,size:listSize,start:0,cycleStart:&cStart,cycleSize:&cSize)
    if res>0 {
        println("\nFound a cycle of size",cSize,"that starts at position",cStart,"in this list")
    }
    else{
        println("\nDidn't find any cycle in this list")
    }
}