import UIKit
var str = "Hello, playground"

/*
 VIA： https://www.cnblogs.com/strengthen/p/10299618.html swift 博客
 
*/


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


// ----------------------------------------- 字符串  -----------------------

// 392.判断子序列 双下标
/*
 本文主要运用的是双指针的思想，指针si指向s字符串的首部，指针ti指向t字符串的首部。
 
 */
func isSubsequence(_ s: String, _ t: String) -> Bool {
    // 因为子序列没有改变顺序，不存在回溯一说
    // 1 双指针  没有ac
    guard s != "" else {
        return true
    }
    
    var i = 0, j = 0
    let s = Array(s), t = Array(t)  // 字符串转数组
    
    while (i < s.count && j < t.count) {
        if (s[i] == t[j]) {
            i+=1
        }
        j+=1
    }
    return i == s.count
}


print(isSubsequence("acd","abcd"))


// ------------------------------------------- 动态规划 ------------------------------

// 70. 爬楼梯 备忘录 递归
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
// 动态规划求解
func DyclimbStairs(_ n: Int) -> Int {
    var recArray = [1,1,2]
    if n >= 3{
        for j in 3 ..< n+1{
            print(recArray)
            recArray.append(recArray[j-1] + recArray[j-2])
        }
    }
    
    return recArray[n]
}


var m = 4
print(array)
for i in 3 ..< m+1 {
    array.append(array[i-1] + array[i-2])
}
print(array)





// 121. 买卖股票的最佳时机
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
// 遍历
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





// 122. 买卖股票的最佳时机 II
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






// 53. 最大子序和  动态
func maxSubArray(_ nums: [Int]) -> Int {
    
    var result = Dictionary<Int, Int>()
    for i in 0..<nums.count {
        result[i] = nums[i]
    }
//    print(result)
    
    var maxNum = nums[0]
    
    for i in 1 ..< nums.count {
        
//        print(nums[i])

        if result[i-1]! > 0 {
            result[i] = nums[i] + result[i-1]! // 最小子结构
            
        }
        if result[i]! > maxNum {
            maxNum = result[i]!
        }
    }
    return maxNum
}

maxSubArray([1,2,4,2])






//LeetCode 198. 打家劫舍
/*
 解题思路
 1、首先想一想如果是暴力如何做？
 假设从最后一家店铺开始抢，那么只会遇到2种情况，即：抢这家店和下下家店，或者不抢这家店。所以我们得到递归的公式:
 Math.max(solve(nums,index-1),solve(nums,index-2)+nums[index]);
 2、上面的暴力算法虽然能够得到正确的结果，但是显然递归的效率是很低的，如果有n家店铺，每家店铺有2种可能，那么时间复杂度就是2的n次方。那么如何优化呢？
 我们分析一下：
 如果我们开始抢的是第n-1家店，那么后面可以是（n-3,n-4,n-5,n-6....）;
 如果我们开始抢的是第n-2家店，那么后面可以是（n-4,n-5,n-6,....）;
 那么这两种情况显然n-3之后的n-4,n-5,n-6,....都重复计算了。显然这里有非常大的优化空间。通常我们使用空间来换时间，即用一个数组记录每次计算的结果，这样每次情况只需要计算一次，再次遇到只需直接返回结果即可，大大优化了时间。
 
 总结
 这道题就是动态规划，其本质是在递归的思想上进行优化。
 原问题（N）-->子问题（N-1）-->原问题（N）
 
 最优子结构
 1、子问题最优决策可导出原问题的最优决策。
 2、无后效性
 
 重叠子问题
 1、去冗余
 2、空间换时间
*/

func rob(_ nums: [Int]) -> Int {
    
    if nums.count == 0 {
        return 0
    }
    
    if nums.count == 1 {
        return nums[0]
    }
    
    
    var ans = [Int]()
    ans[0] = nums[0]
    ans[1] = max(nums[0], nums[1])

    
    for i in 2 ..< nums.count  {
        ans[i] = max(ans[i-1], ans[i-2] + nums[i-1])
    }
    
    
    return ans[nums.count - 1]
}

