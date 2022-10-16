let searchVal=77
let dimArr=11
func binarySearch(_ arr : [Int] ,_ search: Int ,_ low: Int,_ high: Int) -> Int {
    if low>high{
        return -1;
    }
    else{
        let mid=(low+high)/2
        if search==arr[mid] {
            return mid;
        }
        else if search>arr[mid]  {
            return binarySearch(arr,search,mid+1,high)
        }
        else {
            return binarySearch(arr,search,low,mid-1)
        }
    }
}
func main(){
    let a2=[1,2,4,7,26,77,79,82,99,102,134]
    let res=binarySearch(a2,searchVal,0,dimArr-1)
    if res!=-1 {
        println("The value",searchVal,"was FOUND in the position:",res)
    }
    else{
        println("The value",searchVal,"was NOT FOUND in the array")
    }
}
