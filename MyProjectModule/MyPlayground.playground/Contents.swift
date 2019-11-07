import UIKit
var str = "Hello, playground"

/*
 VIA： https://www.cnblogs.com/strengthen/p/10299618.html swift 博客
 VIA:  优先 剑指offer
 
 全排列的算法
 LRU
【leetcode】480 滑动窗口中位数（数组，堆）
 问数组里每个数都出现3次，只有一个数出现1次。
 两个有序数组合并
 一个二叉树的前中后序遍历
 手写一下快排序
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



//MARK:                                    双指针

/*88. 合并两个有序数组
 给定两个有序整数数组 nums1 和 nums2，将 nums2 合并到 nums1 中，使得 num1 成为一个有序数组。

 标签：从后向前数组遍历
 因为 nums1 的空间都集中在后面，所以从后向前处理排序的数据会更好，节省空间，一边遍历一边将值填充进去
 设置指针 len1 和 len2 分别指向 nums1 和 nums2 的有数字尾部，从尾部值开始比较遍历，同时设置指针 len 指向 nums1 的最末尾，每次遍历比较值大小之后，则进行填充
 当 len1<0 时遍历结束，此时 nums2 中海油数据未拷贝完全，将其直接拷贝到 nums1 的前面，最后得到结果数组

 O(m+n)  O(1)
  
 */
func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    
    var len1 = m - 1, len2 = n - 1, len = m + n - 1
    
    while len1 >= 0 && len2 >= 0 {
        if nums1[len1] >= nums2[len2] {
            nums1[len] = nums1[len1]
            len1 -= 1
            len -= 1
        }else{
            nums1[len] = nums2[len2]
            len -= 1
            len2 -= 1
        }
    }
    
    while len2 >= 0 {
        nums1[len] = nums2[len2]
        len -= 1
        len2 -= 1
    }
}
var nums1 = [1,2,3,0,0,0], mm = 3
var nums2 = [2,5,6],       nn = 3

merge(&nums1,mm,nums2,nn)


// 392.判断子序列 双下标  判断 s 是否为 t 的子序列。

/*
 本文主要运用的是双指针的思想，指针si指向s字符串的首部，指针ti指向t字符串的首部。
 */
func isSubsequence(_ s: String, _ t: String) -> Bool {
    // 因为子序列没有改变顺序，不存在回溯一说
    // 1 双指针
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


//11. 盛最多水的容器  双指针
/*
 现在，为了使面积最大化，我们需要考虑更长的两条线段之间的区域。如果我们试图将指向较长线段的指针向内侧移动，矩形区域的面积将受限于较短的线段而不会获得任何增加。但是，在同样的条件下，移动指向较短线段的指针尽管造成了矩形宽度的减小，但却可能会有助于面积的增大。因为移动较短线段的指针会得到一条相对较长的线段，这可以克服由宽度减小而引起的面积减小。
 */
func maxArea(_ height: [Int]) -> Int {
    var maxArea = 0
    var i = 0
    var j = height.count - 1
    while i < j {
        var minHeight = 0
        let leftHeight = height[i]
        let rightHeight = height[j]
        
        if leftHeight < rightHeight {
            minHeight = leftHeight
            i += 1
        }else{
            minHeight = rightHeight
            j -= 1
        }
        
        maxArea = max(maxArea, (j - i + 1) * minHeight)
    }
    return maxArea
}
maxArea([1,8,6,2,5,4,8,3,7])



//MARK:                                      二分查找
// 658. 找到 K 个最接近的元素
/*
 给定一个排序好的数组，两个整数 k 和 x，从数组中找到最靠近 x（两数之差最小）的 k 个数。返回的结果必须要是按升序排好的。如果有两个数与 x 的差值一样，优先选择数值较小的那个数。
 二分法
 用于区间定位：
  章节定位
 */
func findClosestElements(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
    
    var leftIndex: Int = 0
    var rightIndex: Int = arr.count - k
    
    while(leftIndex < rightIndex){
        
        let mid: Int = leftIndex + (rightIndex - leftIndex) / 2
        
        if x - arr[mid] > arr[mid + k] - x{
            
            leftIndex = mid + 1
        }else{
            
            rightIndex = mid
        }
        
    }
    
    return Array(arr[leftIndex..<(leftIndex + k)])
}

let chapter = findClosestElements([1,3,5,7,9], 1, 8)


// 704. 二分查找 (还是双指针)

// while 迭代方式
func searchs(_ nums: [Int], _ target: Int) -> Int {
    var left = 0
    var right = nums.count - 1
    
    while left <= right {
        let mid = (right - left)/2 + left
        if nums[mid] == target {
            return mid
        }else if nums[mid] < target{
            left = mid + 1
        }else{
            right = mid - 1
        }
    }
    
    return -1
    
}

// 递归方式

func search(_ nums: [Int], _ target: Int) -> Int {
    return binarySearch(nums: nums, target: target, left: 0, right: nums.count - 1)
}

func binarySearch(nums: [Int], target :Int, left :Int, right: Int) -> Int{
    
    guard left <= right else{
        return -1
    }
    
    let mid = (right - left) / 2 + left
    
    if nums[mid] == target{
        return mid
    }else if nums[mid] < target{
        return binarySearch(nums: nums, target: target, left: mid + 1, right: right)
    }else{
        return binarySearch(nums: nums, target: target, left: left, right: mid - 1)
    }
}

searchs([-1,0,3,5,9,12], 12)


//278. 第一个错误的版本
/*
   假设你有 n 个版本 [1, 2, ..., n]，你想找出导致之后所有版本出错的第一个错误的版本。
   你可以通过调用 bool isBadVersion(version) 接口来判断版本号 version 是否在单元测试中出错。实现一个函数来查找第一个错误的版本。你应该尽量减少对调用 API 的次数。
   给定 n = 5，并且 version = 4 是第一个错误的版本。
 */
func isBadVersions(_ target: Int) -> Bool{
    print("isBadVersion")
    if target >= 4 {
        return true
    }else{
        return false
    }
}
func findFirstError(_ nums: [Int],_ target: Int) -> Int {
    var leftIndex = 1
    var rightIndex = nums.count
    
    while leftIndex < rightIndex {
        let mid = (rightIndex - leftIndex) / 2 + leftIndex
        
        if isBadVersions(mid) {
            rightIndex = mid
        }else{
            leftIndex = mid + 1
        }
    }
    
    return leftIndex
    
}

findFirstError([1,2,3,4,5], 4)

//MARK:- 遍历

// 1. 两数之和 如果有给出两个数坐标
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    
    var dic = [Int : Int]()

    for (idx,item) in nums.enumerated() {
        if let lastIdx = dic[target - item] {
            return [lastIdx,idx]
        }else{
            dic[item] = idx
        }
    }
    
    return [0,0]
}

twoSum([2, 7, 11, 15], 17)

//136. 只出现一次的数字
/*
 给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。
 */
func singleNumber(_ nums: [Int]) -> Int {
    
    var result = 0
    
    for num in nums {
        result = result ^ num
    }
    
    return result
}

singleNumber([0,2,2,1,1,3,3])


//MARK:                                  递归
/*
 递归算法的两个重要特征
 1. 有终止的条件，不然就成了死循环了(a)
 2. 不停调用自身 (b,c)
 
 处理好递归的3个主要的点:
 a) 出口条件，即递归“什么时候结束”，这个通常在递归函数的开始就写好;
 b) 如何由"情况 n" 变化到"情况 n+1", 也就是非出口情况，也就是一般情况——"正在"递归中的情况；
 c) 初始条件，也就是这个递归调用以什么样的初始条件开始

 递归由于是函数调用自身， 而函数调用是有时间和空间的消耗的：每一次函数调用，都需要在内存栈中分配空间以保存参数、返回地址及临时变量，而且往栈里压入数据和弹出数据都需要时间。另外，递归中有可能很多计算都是重复的，从而对性能带来很大的负面影响。除了效率之外，还有可能使调用栈溢出，前面分析中提到需要为每一次函数调用在内存栈中分配空间，而每个进程的栈的容量是有限的。当递归调用的层级太多时，就会超出栈的容量，从而导致调用栈溢出。

 */


//    递归 1 - 100 和
func recursionNum(_ n :Int) -> Int {
    if n == 1 {
        return 1
    }
    return recursionNum(n - 1) + n
    
}

// 遍历子视图
func getSub(view :UIView) -> Void {
    if view.subviews.count > 0 {
        for subView in view.subviews{
            getSub(view: subView)
        }
    }
}

//206. 反转链表

public class ListNode {
      public var val: Int
      public var next: ListNode?
      public init(_ val: Int) {
          self.val = val
          self.next = nil
      }
  }

func reverseList(_ head: ListNode?) -> ListNode? {
    
    if head == nil || head?.next == nil{
        return head
    }else{
        // 递归 获取最后的节点
        print("++++++++++")
        let newHead = reverseList(head?.next)
        print("-----------")
        
         // 依次反转每个节点 <3个指针中 head?.next 为current 指针作为 反转中间轴 >
        head?.next?.next = head
        head?.next = nil
        
        return newHead
    }
}



//MARK:                                  未分类


//344. 反转字符串
func reverseString(_ s: inout [Character]) {
    
    if s.count < 2 {
        return
    }
    var i = 0
    var j = s.count - 1
    var char: Character

    while i < j {
        char = s[i]
        s[i] = s[j]
        s[j] = char
        
        i += 1
        j -= 1
    }
}


// 442. 数组中重复的数据
func findDuplicates(_ nums: [Int]) -> [Int] {
    guard nums.count > 1 else {
        return []
    }
    var set = Set<Int>()
    var arr = [Int]()
 
    
    for i in nums {
        if set.contains(i) {
            arr.append(i)
        } else {
            set.insert(i)
        }
    }
    return arr
}

findDuplicates([4,3,2,7,8,2,3,1])

//Merge Two Sorted Lists


//



//3. 无重复字符的最长子串 (滑动窗口)

func lengthOfLongestSubstringWD(_ s: String) -> Int {
    var right = 1
    var left = 0
    var i = 0
    var result = 0
    
    if s.count > 0 {
        result = right - left
        let chars = Array(s.utf8)
        //Interate in a incremental window
        while right < chars.count {
            i = left
            while i < right {
                //Check if a duplicate is found
                if chars[i] == chars[right] {
                    left = i + 1
                    break
                }
                i = i + 1
            }
            result = max(result,right-left+1)
            right = right + 1
        }
    }
    return result
}

lengthOfLongestSubstringWD("bbbbbacd")



//14. 最长公共前缀
func longestCommonPrefix(_ strs: [String]) -> String {
    
    let str :String = ""
    
    for (idx,s) in strs.enumerated(){
        let sarr = Array(s)
        
        
    }
    
    return str
}

//let str = longestCommonPrefix(["dog","racecar","car"])



// ------------------------------------------- 动态规划 ------------------------------

//409. 最长回文串
func longestPalindrome(_ s: String) -> String {
       var dp:[[Bool]] = [];
       if s.count <= 1{
           return s;
       }
       
       var longest:Int = 1;
       var left:Int = 0;
       var right:Int = 0;
       
       for var i in 0...s.count - 1{
           var eachRow:[Bool] = [];
           for var j in 0...s.count - 1{
               if i == j{
                   eachRow.append(true);
               }else{
                   eachRow.append(false);
               }
           }
           dp.append(eachRow);
       }
    
      print(dp)
       
       var i:Int = 0;
       var j:Int = 0;
       for var character_j in s {
           if j == 0 {
               j += 1;
               continue;
           }
           i = 0;
           for var character_i in s {
               if character_i == character_j {
                   dp[i][j] = dp[i + 1][j - 1] || j - i <= 1;
                   if dp[i][j] && j - i + 1 > longest{
                       longest = j - i + 1;
                       left = i;
                       right = j;
                   }
               }else{
                   dp[i][j] = false;
               }
               i += 1;
               if i >= j{
                   break;
               }
           }
           j += 1;
       }
       let leftIndex = s.index(s.startIndex, offsetBy: left);
       let rightIndex = s.index(s.startIndex, offsetBy: right);
       return String(s[leftIndex...rightIndex]);
}

longestPalindrome("1234aba")

// 70. 爬楼梯 备忘录+递归
func climbStairs(_ n: Int) -> Int {
    var dic = [Int:Int]()
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
            return dic[n]!
        }else{
            dic[n] = rec(n-1) + rec(n-2)
            return rec(n-1) + rec(n-2)
        }
    }
    return rec(n)
}

// 递归
func climbStairsRecursion(_ n: Int) -> Int {
    
    if n == 2 || n == 1{
        return n
    }else{
        return climbStairs(n-1) + climbStairs(n-2)
    }

}

// 动态规划求解 1
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
// DP 2
func DP2(_ n: Int) -> Int {
    //1 最优子结构
    if n == 1 {
        return 1
    }
    if n == 2 {
        return 2
    }
//    2 边界
    var a = 1
    var b = 2
    var temp = 0

    for _ in 3 ... n {
        temp = a + b  //3 状态转移方程
        a = b
        b = temp
    }
    return temp
}

DyclimbStairs(3)
DP2(3)


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
    
    // 1 最优子结构
    // -- 只要考虑当天买和之前买哪个收益更高，当天卖和之前卖哪个收益更高。
    // 2 边界
    var buy = -prices[0], sell = 0
    
    for idx in 1 ..< prices.count{
        // 3 状态转移方程
        buy = max(buy,-prices[idx]) // 一直取买入最低的价格
        sell = max(sell,prices[idx]+buy) //第i天卖出,或者上一个状态比较,取最大值.
    }
    return sell
}

// 遍历 （双指针 后置指针会遍历整个数组，前置的会根据业务保存对应值 《子序列》）
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
// 动态
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


// 方法二：峰谷法

print(dynamicMaxProfit([1,2,1,5,8]))






// 53. 最大子序和  动态
func maxSubArray(_ nums: [Int]) -> Int {
    
    var result = Dictionary<Int, Int>()
    
    for i in 0..<nums.count {
        result[i] = nums[i]
    }
    
    var maxNum = nums[0]
    
    for i in 1 ..< nums.count {
        
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

func maxDSubArray(_ nums: [Int]) -> Int {
    
    var curMaxSub = nums[0]
    var sum : Int = 0
    
    for num in nums {
        if sum > 0{
            //否则累加
            sum += num
        }else{
            //如果小于0，则抛弃之前的子序列，从新的开始
            sum = num
        }
        
        //将当前子序列和现有的子序列最大进行比较
        if sum > curMaxSub {
            curMaxSub = sum
        }
    }
    
    return curMaxSub
    
}
maxDSubArray([-2,1,-3,4,-1,2,1,-5,4])




//LeetCode 198. 打家劫舍
/*
 他如果选择偷这一家，他就一定没有偷上一家，所以，他所能获得的最大金钱就是在当前家能获得的金钱加上在上上家拥有的钱数的和；
 他如果不选择这一家，那么他当前获取的最大金钱就是上一家拥有的钱； 当然，他会选择以上两种方案的最大值。<自顶向下>
 

 
 解题思路
 1、首先想一想如果是暴力如何做？
 假设从最后一家店铺开始抢，那么只会遇到2种情况，即：抢这家店和下下家店，或者不抢这家店。所以我们得到
 
 对于 n = 3，有两个选项:
 1 - 抢第三个房子，将数额与第一个房子相加。
 2 - 不抢第三个房子，保持现有最大数额。


 递归的公式: dp[i] = max(dp[i - 2] + nums[i], dp[i - 1])
dp[i] 代表到第n个房屋为止获得的最大金额
 
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
    var dp = [Int]()
    
    for i in 0 ... nums.count {
        dp.append(i)
    }
    
    print(dp)
    
    for i in 0 ..< dp.count {
        if i == 0 {
            dp[0] = 0
            continue
        }
        if i == 1 {
            dp[1] = nums[0]
            continue
        }
        
        dp[i] = max(dp[i - 2] + nums[i - 1], dp[i - 1])
    }
    
    return dp[nums.count]
}

func DProb(_ nums: [Int]) -> Int {
        
    let n = nums.count
    if n == 0 { return 0 }
    if n == 1 { return nums[0] }
    
    
    
    var dp = [nums[0], max(nums[0], nums[1])] // 递推公式
    
    for i in 2..<n {
        dp.append(max(dp[i-1], dp[i-2]+nums[i]))
    }
    return dp.last!
}

rob([2,7,9,3,1])

//213. 打家劫舍 II https://zhuanlan.zhihu.com/p/56969640


// 256. 粉刷房子


