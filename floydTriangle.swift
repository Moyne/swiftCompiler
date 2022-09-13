let rows = 10
func main(){
    var temp=1;
    for a in 0...rows{
        for b in 0...a{
            print(temp)
            temp+=1
        }
        println()
    }
}