import UIKit
var str = "Hello, playground"

// 给一个数组，要求写一个函数，交换数组中的两个元素
func swaps<T>(_ nums: inout [T], _ p: Int, _ q: Int) {
//    let temp = nums[p]
//    nums[p] = nums[q]
//    nums[q] = temp
    (nums[p], nums[q]) = (nums[q], nums[p])

}
var array = [1,1,2]

swaps(&array, 0, 1)

//print(array)


var dic = NSMutableDictionary()
var n = ""
dic[n] = ""
//let isMark = dic.contains(where: {$0["name"] == "Mark"})

//Mark - climbStairs
func climbStairs(_ n: Int) -> Int {
    var dic = NSMutableDictionary()
    func rec(_ n: Int) -> Int{
        if n == 1{
            dic[n] = 1
            return 1
        }
        if n == 2{
            dic[n] = 2
            return 2
        }
        if dic[n] != nil{
            return dic.object(forKey: n) as! Int
        }else{
            dic[n] = rec(n-1) + rec(n-2)
            return rec(n-1) + rec(n-2)
        }
    }
    return rec(n)
}

//  动态规划
var m = 4
print(array)
for i in 3 ..< m+1 {
    array.append(array[i-1] + array[i-2])
}
print(array)



//Mark: maxProfit
func maxProfit(_ prices:[Int]) -> Int{
    var maxprice = 0
    var minpirce = Int.max
    
    for (idx,_) in prices.enumerated() {
        if minpirce > prices[idx] {
            minpirce = prices[idx]
        }else if(maxprice < prices[idx] - minpirce){
            maxprice = prices[idx] - maxprice
        }
    }
    
    return maxprice
}

//  动态规划
func dynamicMaxProfit(_ prices:[Int]) -> Int{

    if prices.count <= 1 {
        return 0
    }
    
    // 最优子结构
    // -- 只要考虑当天买和之前买哪个收益更高，当天卖和之前卖哪个收益更高。
    
    //边界
    var buy = -prices[0], sell = 0
    
    for idx in 1 ..< prices.count{
        //状态转移方程
        buy = max(buy,-prices[idx]) // 一直取买入最低的价格
        sell = max(sell,prices[idx]+buy) //第i天卖出,或者上一个状态比较,取最大值.
    }
    return sell
}



func dynamicMaxProfitTwo(_ prices:[Int]) -> Int{
    
    if prices.count <= 1 {
        return 0
    }
    
    var buy = -prices[0], sell = 0
    for idx in 1 ..< prices.count {
        sell = max(sell,prices[idx]+buy)
        buy = max(buy,sell - prices[idx])
    }

    
    return sell
}

print(dynamicMaxProfit([1,2,1,5,8]))



func isSubsequence(_ s: String, _ t: String) -> Bool {
    // 因为子序列没有改变顺序，不存在回溯一说
    // 1 双指针  没有ac
    var i = 0, j = 0
    while (i < s.count && j < t.count) {
        if (s[s.index(s.startIndex, offsetBy: i)] == t[t.index(t.startIndex, offsetBy: j)]) {
            i+=1
        }
        j+=1
    }
    return i == s.count
}


print(isSubsequence("acd","abcd"))


