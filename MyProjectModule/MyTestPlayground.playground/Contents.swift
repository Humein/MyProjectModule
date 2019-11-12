import UIKit
//MARK: 动态规划
/*
 动态规划在查找有很多重叠子问题的情况的最优解时有效。它将问题重新组合成子问题。为了避免多次解决这些子问题，它们的结果都逐渐被计算并被保存，从简单的问题直到整个问题都被解决。因此，动态规划保存递归时的结果，因而不会在解决同样的问题时花费时间。

 动态规划只能应用于有最优子结构的问题。最优子结构的意思是局部最优解能决定全局最优解（对有些问题这个要求并不能完全满足，故有时需要引入一定的近似）。简单地说，问题能够分解成子问题来解决。
 
 适用情况
 最优子结构性质。如果问题的最优解所包含的子问题的解也是最优的，我们就称该问题具有最优子结构性质（即满足最优化原理）。最优子结构性质为动态规划算法解决问题提供了重要线索。
 无后效性。即子问题的解一旦确定，就不再改变，不受在这之后、包含它的更大的问题的求解决策影响。
 子问题重叠性质。子问题重叠性质是指在用递归算法自顶向下对问题进行求解时，每次产生的子问题并不总是新问题，有些子问题会被重复计算多次。动态规划算法正是利用了这种子问题的重叠性质，对每一个子问题只计算一次，然后将其计算结果保存在一个表格中，当再次需要计算已经计算过的子问题时，只是在表格中简单地查看一下结果，从而获得较高的效率。
 */

//MARK:  贪心算法
/*
 贪心算法与动态规划的不同在于它对每个子问题的解决方案都做出选择，不能回退。
 动态规划则会‘保存’以前的运算结果，并根据以前的结果对当前进行选择，有回退功能。
 一旦一个问题可以通过贪心法来解决，那么贪心法一般是解决这个问题的最好办法。由于贪心法的高效性以及其所求得的答案比较接近最优结果，贪心法也可以用作辅助算法或者直接解决一些要求结果不特别精确的问题。
 步骤
 创建数学模型来描述问题。
 把求解的问题分成若干个子问题。
 对每一子问题求解，得到子问题的局部最优解。
 把子问题的解局部最优解合成原来解问题的一个解。
 */



//MARK:- list1：
func recursion100(_ n :Int) -> Int{
    if n == 1 {
        return 1
    }
    return recursion100(n - 1) + n
}
recursion100(100)


func recursionSubView(_ view :UIView){
    if view.subviews.count > 0 {
        for(_,item) in view.subviews.enumerated(){
            print(item)
            recursionSubView(item)
        }
    }
}

let view = UIView()
recursionSubView(view)

//88. 合并两个有序数组
/*
 给定两个有序整数数组 nums1 和 nums2，将 nums2 合并到 nums1 中，使得 num1 成为一个有序数组。
 初始化 nums1 和 nums2 的元素数量分别为 m 和 n。
 你可以假设 nums1 有足够的空间（空间大小大于或等于 m + n）来保存 nums2 中的元素。

 var p1 = m - 1, p2 = n - 1, p = m + n - 1
 
 while p1 > 0 && p2 > 0 {
     if nums1[p1] >= nums2[p2] {
         nums1[p] = nums1[p1]
         p -= 1
         p1 -= 1
     }else{
         nums1[p] = nums2[p2]
         p -= 1
         p2 -= 1
     }
 }
 
 while p2 > 0 {
     nums1[p] = nums2[p2]
     p -= 1
     p2 -= 1
 }
 3个指针迭代 可以类比 21题
 */

func mergeArrays(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    
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

mergeArrays(&nums1,mm,nums2,nn)


//MARK:- list2：
//1. 两数之和
func twoSums(_ nums :[Int],_ target :Int) ->[Int]{
    var dic = [Int:Int]()
    for (idx,item) in nums.enumerated() {
        if let lastIdx = dic[target - item] {
            return [idx,lastIdx]
        }else{
            dic[item] = idx
        }
    }
    
    return []
}
twoSums([2, 7, 11, 15], 17)

//136. 只出现一次的数字
func singleNum(_ nums :[Int]) -> Int{
    var result = 0
    for num in nums {
        result = result ^ num
    }
    return result
}

//206. 反转链表
public class LinkNode{
    public var val :Int
    public var next :LinkNode?
    public init(_ val :Int) {
        self.val = val
        self.next = nil
    }
}
func reverseLink(_ head: LinkNode?) -> LinkNode?{
    
    if head == nil || head?.next == nil {
        return head
    }
    
    let newHead = reverseLink(head?.next)
    head?.next?.next = head
    head?.next = nil
    
    return newHead
}

//MARK:- list3:
//392.判断子序列
/*
 判断 s 是否为 t 的子序列。

 本文主要运用的是双指针的思想，指针si指向s字符串的首部，指针ti指向t字符串的首部。
 */
func isSubsequence(_ s :String, _ t :String) -> Bool{
    let sArray = Array(s), tArray = Array(t)
    var si = 0, ti = 0
    while si < sArray.count && ti < tArray.count{
        if sArray[si] == tArray[ti] {
            si += 1
        }
        ti += 1
    }
    
    return si == sArray.count
}
print(isSubsequence("acd","abcd"))



//11. 盛最多水的容器
/*
 双指针
现在，为了使面积最大化，我们需要考虑更长的两条线段之间的区域。如果我们试图将指向较长线段的指针向内侧移动，矩形区域的面积将受限于较短的线段而不会获得任何增加。但是，在同样的条件下，移动指向较短线段的指针尽管造成了矩形宽度的减小，但却可能会有助于面积的增大。因为移动较短线段的指针会得到一条相对较长的线段，这可以克服由宽度减小而引起的面积减小。
*/
func getMaxArea(_ height :[Int]) -> Int{
    var leftP = 0, rightP = height.count - 1, maxArea = 0
    
    while leftP < rightP {
        var minHeight = 0 //木桶原理
        if height[leftP] > height[rightP] {
            minHeight = height[rightP]
            rightP -= 1
        }else{
            minHeight = height[leftP]
            leftP += 1
        }
        
        maxArea = max(maxArea,(rightP - leftP + 1) * minHeight)
    }
    
    return maxArea
    
}
getMaxArea([1,8,6,2,5,4,8,3,7])




//704. 二分查找
/*
 双指针 迭代方式
 */
func binarySearch(_ nums: [Int], _ target :Int) -> Int{
    var p1 = 0, p2 = nums.count - 1
    while p1 <= p2 {
        let bsmid = (p2 - p1) / 2 + p1
        if nums[bsmid] == target {
            return bsmid
        }else if nums[bsmid] < target{
            p1 = bsmid + 1
        }else{
            p2 = bsmid - 1
        }
    }
    return -1
}


//MARK:- list4:
//344. 反转字符串
/*
双指针 迭代方式
*/
func reverseString(_ s: inout [Character]){
    if s.count < 2 {
        return
    }
    
    var p1 = 0, p2 = s.count - 1
    var temp :Character
    while p1 <= p2 {
        temp = s[p1]
        s[p1] = s[p2]
        s[p2] = temp
        p1 += 1
        p2 -= 1
    }
    
}

//MARK:- list5:

// 658. 找到 K 个最接近的元素
/*
给定一个排序好的数组，两个整数 k 和 x，从数组中找到最靠近 x（两数之差最小）的 k 个数。返回的结果必须要是按升序排好的。如果有两个数与 x 的差值一样，优先选择数值较小的那个数。
*/
func findClosestElements(_ arr: [Int],_ k: Int,_ x: Int) -> [Int]{
    var p1 = 0,p2 = arr.count - k
    while p1 < p2 {
        let mid = (p2 - p1) / 2 + p1
        if x - arr[mid] > arr[mid + k] - x {
            p1 = mid + 1
        }else{
            p2 = mid
        }
    }
    
    return Array(arr[p1..<(p1+k)])
}

let chapter = findClosestElements([1,3,5,7,9], 1, 8)

//278. 第一个错误的版本
/*
  假设你有 n 个版本 [1, 2, ..., n]，你想找出导致之后所有版本出错的第一个错误的版本。
  你可以通过调用 bool isBadVersion(version) 接口来判断版本号 version 是否在单元测试中出错。实现一个函数来查找第一个错误的版本。你应该尽量减少对调用 API 的次数。
  给定 n = 5，并且 version = 4 是第一个错误的版本。
 
 二分查找 双指针 迭代方式
*/
func isBadVersions(_ target: Int) -> Bool{
    print("isBadVersion")
    if target >= 4 {
        return true
    }else{
        return false
    }
}
func findFirstError(_ nums :[Int],_ target :Int) -> Int {
    var p1 = 1, p2 = nums.count
    while p1 < p2 {
        let mid = (p2 - p1) / 2 + p1
        if isBadVersions(mid) {
            p2 = mid
        }else{
            p1 = mid + 1
        }
        
        return p1
    }
    
    return p1
}


findFirstError([1,2,3,4,5], 4)

//MARK:- list6:
// 442. 数组中重复的数据
func findDuplicates(_ nums :[Int]) -> [Int] {
    guard nums.count > 1 else {
        return []
    }
    var set = Set<Int>()
    var arr = [Int]()
    
    for i in nums {
        if set.contains(i) {
            arr.append(i)
        }else{
            set.insert(i)
        }
    }
    
    return arr
}

//21 合并两个有序链表
// 迭代 可类比88题

// 递归
/*
 时间复杂度：O(n + m)。 因为每次调用递归都会去掉 l1 或者 l2 的头元素（直到至少有一个链表为空），函数 mergeTwoList 中只会遍历每个元素一次。所以，时间复杂度与合并后的链表长度为线性关系。

 空间复杂度：O(n + m)。调用 mergeTwoLists 退出时 l1 和 l2 中每个元素都一定已经被遍历过了，所以 n + mn+m 个栈帧会消耗 O(n + m) 的空间。
 
 首先同时遍历两个链表，比较两个链表当前的值，小的值就作为新链表的元素，然后小的值的链表就走到下一个元素，大的值的链表还是当前元素。接着继续遍历，重复上述步骤，直到链表遍历完毕。这样就可以得到新的有序链表了。 需要注意几个地方：

 - 这个题目，最好是创建一个头结点来作为辅助，这样就不用判断新链表的头结点是l1的头结点还是l2的头结点了。
 - 遍历到最后，一般会有一个链表是先遍历完毕的。接着将另外一个链表拼接起来就行了，不用继续再一个个遍历拼接。

 */
func mergeTwoLists(_ l1: LinkNode?,_ l2: LinkNode?) -> LinkNode?{
    // l1/l2 == nil  边界          l1?.next 递归转移方程

    if l1 == nil {
        return l2
    }
    
    if l2 == nil{
        return l1
    }
    
    if l1!.val < l2!.val{
        l1?.next = mergeTwoLists(l1?.next, l2)
        return l1
    }else{
        l2?.next = mergeTwoLists(l1, l2?.next)
        return l2
    }
}

//14. 最长公共前缀
func longestCommonPrefix(_ strs :[String]) -> String {
    if strs.count == 0 {
        return ""
    }
    let prefix = strs[0]
    for i in 0..<strs.count {
        while strs[i].hasPrefix(prefix) == false {
//            prefix = prefix.substring(to: prefix.index(before: prefix.endIndex))
            if prefix.isEmpty {
                return ""
            }
        }
    }
    return prefix
}

//MARK:- list7:
//226. 翻转二叉树
/*
 迭代法
 的思路是BFS或者DFS，这两种方法都可以实现，实际上也是二叉树的遍历。
 BFS用Queue实现，
 DFS的话将代码中的Queue换成Stack。
 
  递归最简单
 */

 public class TreeNode {
     public var val: Int
     public var left: TreeNode?
     public var right: TreeNode?
     public init(_ val: Int) {
         self.val = val
         self.left = nil
         self.right = nil
     }
 }

// 递归
func invertTree(_ root :TreeNode?) -> TreeNode? {
    // 边界
    if root == nil {
        return nil
    }
    
    //递归转移
    let right = invertTree(root?.right)
    let left = invertTree(root?.left)
    root?.left = right
    root?.right = left
    return root
}


//二维数组中的查找
/*
 在一个二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序，输入一个二维数组中的数字，判断二维书中是否存在,存在返回true，不存在返回false~
 思路:

 1:第一反应都是二分查找。对于每一行进行二分查找，然后查找过程可以把某些列排除掉，这是大家都能想到的基本的思路。

 2:首先选取数组右上角的数字，如果该数字等于要查找的数字，则查找结束；如果该数字大于要查找的数字，剔除这个数字所在的列，如果该数字小于要查找的数字，剔除这个数字所在的行。这样每一步都可以剔除一行或一列，查找的速度比较快。

 */
func searchMatrix(data :[[Int]],number :NSInteger) -> Bool{
    var row :Int = 0, col :Int = data[0].count - 1
    if data.count == 0 || data.isEmpty{
        return  false
    }
    while row < data.count && col >= 0 {
        let rightVal = data[row][col]
        if rightVal == number {
            return true
        }else if rightVal > number{
            col -= 1
        }else{
            row += 1
        }
    }
    return false
}


//MARK:- list8:
//18 合并K个排序链表
/*
 合并 k 个排序链表，返回合并后的排序链表。https://www.cnblogs.com/strengthen/p/9891419.html

 - 1,   从21 合并两个有序链表的基础上，我们已经能够解决两个有序链表的问题，现在是k个有序链表，我们可以将第一二个有序链表进行合并，然后将新的有序链表再继续跟第三个有序链表合并，直到将所有的有序链表合并完成。 这样做思路上是可行的，但是算法的时间复杂度将会很大，具体就不计算了。有兴趣的自己计算下。
 - 2,  根据思路一，我们是一个一个地将有序链表组成新的链表，这里一个进行了k-1次两个有序链表的合并操作。而且随着新链表越来越大，时间复杂度也会越来越高。 这里有一种简化的方式，可以先将k个有序链表先以2个链表为一组进行合并，得出结果后，再将所有的新有序链表继续上面的方式，2个链表为一组进行合并。直至将所有的有序链表进行合并。 这个思路会比思路一的算法复杂度少一点。
 - 3 ,  我们换个不一样的思路。我们先遍历一次所有的链表中的元素。然后将元素全部放在一个数组里面。接着对这个数组进行排序，最终将排序后的数组里面的所有元素链接起来。 这种方案的复杂度和代码量会比前集中思路更好，更简单。

 空间复杂度：因为需要一个数组，所以需要额外的空间。这个空间的大小就是链表元素的个数 时间复杂度：假设一个是n个元素，对链表进行遍历(n),对数组进行排序(排序算法可以达到nlogn)，最终链接所有元素(n),就是 （n+nlogn+n），也就是O(nlogn)。

 利用第三空间-数组
 */

func mergeKLists(_ lists: [LinkNode?]) -> LinkNode? {
        if lists.count == 0 {
            return nil
        }
    
        var arr : [Int] = []
        
        //遍历链表数组，将每个链表的val直接加入数组中
        for i in lists {
            var node = i
            while node != nil {
                arr.append(node!.val)
                node = node!.next
            }
        }
    
        if arr.count == 0 {
            return nil
        }

        //链表val值的数组排序
        arr = arr.sorted()
        //将排好序的数组重新合成一个链表
        let head = LinkNode(arr[0])
        var node = head
        
        for i in arr {
            node.next = LinkNode(arr[i])
            node = node.next!
        }
    
        return head.next
}


//53. 最大子序和
/*
 https://blog.csdn.net/lin1109221208/article/details/92997704
 给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。

 思路：

 1）动态规划的是首先对数组进行遍历，当前最大连续子序列和为 sum，结果为 ans
 2）如果 sum > 0，则说明 sum 对结果有增益效果，则 sum 保留并加上当前遍历数字
 3）如果 sum <= 0，则说明 sum 对结果无增益效果，需要舍弃，则 sum 直接更新为当前遍历数字
 4） 每次比较 sum 和 ans的大小，将最大值置为ans，遍历结束返回结果
 
 动态规划
 * 递归是自顶向下，动归是自底向上
 1 最优子结构  ans = nums[0]
 2 状态转移方程式  ans = max(ans, sum)
 3 边界     for num in nums
 解题步骤: 1,建立数学模型 2,写代码求解问题
 */
func maxSubArrayMemo(_ nums: [Int]) -> Int {
    
     var result = Dictionary<Int,Int>()
    
     for i in 0..<nums.count {
     result[i] = nums[i]
     }

     var maxNum = nums[0]

     for i in 1 ..< nums.count{

         if result[i-1]! > 0{
             result[i] = result[i-1]! + nums[i] // 最小子结构
         }

         if result[i]! > maxNum{
             maxNum = result[i]!
         }
     }

     return maxNum
 }
func maxSubArrayDP(_ nums: [Int]) -> Int {
    if nums.count == 0 {
        return -1
    }
    var curMaxSub = nums[0]
    var sum = 0
    for num in nums {
        if sum > 0 {
            //否则累加
            sum += num
        }else{
            //如果小于0，则抛弃之前的子序列，从新的开始
            sum = num
        }
        //将当前子序列和现有的子序列最大进行比较
        curMaxSub = max(curMaxSub, sum)
    }
    
    return curMaxSub
}
maxSubArrayDP([-2,1,-3,4,-1,2,1,-5,4])


//MARK:- list9:
//3. 无重复字符的最长子串
/*
 给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。
 输入: "abcabcbb"
 输出: 3
 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
 
 滑动窗口<3个指针 一个临时结果>
 
我们为了要找最长的字串，就要j++，查看j+1元素是否与当前字串有重复字母。如果没有则继续j++，直到某一刻j+1的字符与当前字串中产生了重复字母，此时j无法继续向前拓展，记录当前长度，之后i++，直到将这个重复字符刨除出去，j又继续拓展...
 一个问题是：如何判定下一个字符与当前字串是否存在重复字符？
遍历字符串中的每一个元素。借助一个辅助键值对来存储某个元素最后一次出现的下标。用一个整形变量存储当前无重复字符的子串开始的下标。
 */
func lengthOfLongestSubstringWD(_ s: String) -> Int {
    var p1 = 0, p2 = 1, p = 0, result = 0
    
    if s.count > 0 {
        result = p2 - p1
        let chars = Array(s.utf8)
        // 窗口滑动
        while p2 < chars.count {
            p = p1
            while p < p2 {
                //判断是否重复
                if chars[p] == chars[p2] {
                    p1 = p + 1
                    break
                }
                p = p + 1
            }
            result = max(result,p2 - p1 + 1)
            p2 = p2 + 1
        }
    }
    return result
}
lengthOfLongestSubstringWD("bbbbbacd")

//MARK:- list10:

//5. 最长回文子串
/*
 输入: "babad"
 输出: "bab"
 注意: "aba" 也是一个有效答案。
 
 动态规划
 
 根据回文的特性，一个大回文按比例缩小后的字符串也必定是回文，比如ABCCBA，那BCCB肯定也是回文。所以我们 '可以根据动态规划的两个特点：
 （1）'把大问题拆解为小问题
 （2）'重复利用之前的计算结果
     这道题。如何划分小问题，我们可以先把所有长度最短为1的子字符串计算出来，根据起始位置从左向右，这些必定是回文。然后计算所有长度为2的子字符串，再根据起始位置从左向右。到长度为3的时候，我们就可以利用上次的计算结果：如果中心对称的短字符串不是回文，那长字符串也不是，如果短字符串是回文，那就要看长字符串两头是否一样。这样，一直到长度最大的子字符串，我们就把整个字符串集穷举完了。

 '基于动态规划的三要素对问题进行分析，可确定以下的状态转换方程：
  ' 最小子问题
 单个字符独立成为一个回文字符串
 相邻的两个相同字符，是一个回文字符串

  ' 递推方程
    设置一个 L*L 的矩阵 D，D[i][j] 的值为 ture 或 false， 表示从 i 起始 j 终止的字符串是否为回文。

  Di = (D[i] === D[j]) && Di+1

 （若第 i 个字符与第 j 个字符相同，且从 i+1 起始 j-1 终止的字符串为回文，则有从 i 起始 j 终止的字符串也为回文）
 */
func longestPalindrome(_ s: String) -> String {
       var dp:[[Bool]] = [];
       if s.count <= 1{
           return s;
       }
       
       var longest:Int = 1;
       var left:Int = 0;
       var right:Int = 0;
       //DP 二维数组
    for i in 0...s.count - 1{
           var eachRow:[Bool] = [];
        for j in 0...s.count - 1{
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
    for character_j in s {
           if j == 0 {
               j += 1;
               continue;
           }
           i = 0;
        for character_i in s {
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

longestPalindrome("11234aba")


//MARK:- list11:
//70. 爬楼梯
/*
 题目：你正在爬楼梯。需要 n 步你才能到达顶部。
 每次你可以爬 1 或 2 个台阶。你有多少种不同的方式可以爬到楼顶呢？
 https://blog.csdn.net/moakun/article/details/79928067
 
 思路：一道经典的爬楼梯问题，直觉上第一个想到的就是采用递归，也就是要计算爬到第3层楼梯有几种方式，可以从第2层爬1级上来，也可以从第1层爬2级上来，所以爬到第3级有几种方式只需要将到第2层总共的种数，加上到第1层总共的种数就可以了。推广到一般，写出
 递推公式    stairs(n) = stairs(n-1) + stairs(n-2) ，
 只需要初始化好退出递归的条件就算写完了。
 
 动态规划  <自下而上分解成>

 */
// 递归
func climbStairsRecursion(_ n :Int) -> Int{
    if n == 1 || n == 2 {
        return n
    }

    return climbStairsRecursion(n - 1) + climbStairsRecursion(n - 2)
}
climbStairsRecursion(4)


// 备忘录
func climbStairsMemo(_ n :Int) -> Int{
    var dic = [Int : Int]()
    
    func rec(_ n: Int) -> Int{
        if n == 1 || n == 2 {
            dic[n] = n
            return n
        }
        
        if dic[n] != nil{
            return dic[n]!
        }else{
            dic[n] = rec(n - 1) + rec(n - 2)
            return dic[n]!
        }
    }
    return rec(n)
}

// 数组 动态规划
func DyclimbStairs(_ n: Int) -> Int {
    // 边界值
    if n == 1 || n == 2{
        return n
    }
    
    var recArray = [1,1,2] // 最优子结果
    
    for i in 3 ..< n + 1 {
        print(recArray)
        //状态转移方程
        recArray.append(recArray[i-1] + recArray[i-2])
    }

    return recArray[n]
}

// 临时变量 DP
func climbStairsDP(_ n :Int) -> Int{

    // 边界值
    if n == 1 || n == 2{
        return n
    }
    
    // 最优子结果
    var a = 1, b = 2, temp = 0
    
//    3 状态转移方程
    for _ in 3...n {
        temp = a + b
        a = b
        b = temp
    }
    
    return temp
}



//121. 买卖股票的最佳时机
/*
 给定一个数组，它的第 i 个元素是一支给定股票第 i 天的价格。
 如果你最多只允许完成一笔交易（即买入和卖出一支股票），设计一个算法来计算你所能获取的最大利润。
 注意你不能在买入股票前卖出股票
 
 动态规划
  1 最优子结构
  -- 只要考虑当天买和之前买哪个收益更高，当天卖和之前卖哪个收益更高。
  2 边界
  3 状态转移方程
 */
func dynamicMaxProfit(_ prices :[Int]) -> Int{
    // 边界
    if prices.count <= 1 {
        return 0
    }
    
    var min_b = prices[0], max_p = 0
    
    //3 状态转移方程
    for idx in 1 ..< prices.count {
        min_b = min(min_b, prices[idx]) // 一直取买入最低的价格 // 最优子结构
        max_p = max(max_p, prices[idx] - min_b) //第i天卖出,或者上一个状态比较,取最大值. // 最优子结构
    }
    
    return max_p
}

// 双指针遍历 < 后置指针会遍历整个数组，前置的会根据业务保存对应值 《子序列》>
func twoPMaxProfit(_ prices :[Int]) -> Int{
    var maxP = 0
    var minP = Int.max
    
    for (idx,_) in prices.enumerated() {
        if minP > prices[idx] {
            minP = prices[idx]
        }else if(maxP < prices[idx] - minP){
            maxP = prices[idx] - minP
        }
    }
    return maxP
}

//MARK:- list12:

// 122. 买卖股票的最佳时机 II
/*
 给定一个数组，它的第 i 个元素是一支给定股票第 i 天的价格。

 设计一个算法来计算你所能获取的最大利润。你可以尽可能地完成更多的交易（多次买卖一支股票）。

 注意：你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）
 
 */

// 贪心算法
func greedyMaxProfit(_ prices :[Int]) -> Int{
    if prices.count <= 1 {
        return 0
    }
    
    var sell = 0
    
    for idx in 1..<prices.count{
        if prices[idx] > prices[idx - 1] {
            sell += prices[idx] - prices[idx - 1]
        }
    }
    return sell
}

//MARK:- list13:
//198. 打家劫舍
/*
 你是一个专业的小偷，计划偷窃沿街的房屋。每间房内都藏有一定的现金，影响你偷窃的唯一制约因素就是相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警。
 给定一个代表每个房屋存放金额的非负整数数组，计算你在不触动警报装置的情况下，能够偷窃到的最高金额。
 
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
//递归
func robRec(_ nums: [Int]) -> Int{
    return -1
}

// 动态 <类比爬楼梯>
func robDP(_ nums: [Int]) -> Int {
    //边界
    if nums.count == 0 {return 0}
    if nums.count == 1 {return nums[0]}
    
    var dp = [nums[0],max(nums[0],nums[1])] // <最优子结构>

    for i in 2 ..< nums.count{
        //状态转移方程
        //dp[i] = max(dp[i - 2] + nums[i], dp[i - 1]) 递推公式
        dp.append(max(nums[i] + dp[i-2],dp[i-1]))
    }
    
    return dp.last!
}

//141. 环形链表
/*
 给定一个链表，判断链表中是否有环。
 为了表示给定链表中的环，我们使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。 如果 pos 是 -1，则在该链表中没有环。

 笔者理解 快慢指针《双指针》，
 就是两个指针访问链表，一个在前一个在后，或者一个移动快另一个移动慢，这就是快行指针。所以如何检测一个链表中是否有环？用两个指针同时访问链表，其中一个的速度是另一个的2倍，如果他们相等了，那么这个链表就有环了
 
 快慢指针《双指针》应用---
  '一. 使用快慢指针来找到链表的中点
  '二. 链表的翻转
  '三. 利用快慢指针来判断链表中是否有环（并找出环的入口）

 if head == nil || head?.next == nil {
     return head
 }
 
 let newHead = reverseLink(head?.next)
 head?.next?.next = head
 head?.next = nil
 
 return newHead
 */

//#include "leetCode.hpp"

func hasCycle(_ head: LinkNode?) -> Bool{
    var fast = head, slow = head
    while fast != nil && fast?.next != nil {
        fast = fast?.next?.next
        slow = slow?.next
        if slow?.val == fast?.val {
            return true
        }
    }
    return false
}


//142 环形链表 II
/*

 链表相关思路----
 
 '- 判断是否为环形链表
 思路：使用追赶的方法，设定两个指针slow、fast，从头指针开始，每次分别前进1步、2步。如存在环，则两者相遇；如不存在环，fast遇到NULL退出。
 
 '- 若为环形链表，求环入口点
思路：快慢指针相遇点<slow>到环入口的距离 = 链表起始点到环入口的距离
 
 '- 求环的长度
 思路：记录下相遇点p，slow、fast从该点开始，再次碰撞所走过的操作数就是环的长度s
 
 '- 判断两个链表是不是相交
 
 （思路：如果两个链表相交，那么这两个链表的尾节点一定相同。直接判断尾节点是否相同即可。这里把这道题放在环形链表，因为环形链表可以拆成Y字的两个链表。）
 */

func detectCycle(_ head: LinkNode?) -> LinkNode?{
    var fast = head, slow = head
    
    while fast != nil && fast?.next != nil {
        fast = fast?.next?.next
        slow = slow?.next
        if slow?.val == fast?.val {
            break;
        }
    }
    
    // 边界
    if fast == nil || fast?.next == nil {
        return nil
    }
    
    fast = head //重制快指针
    
    while fast?.val != slow?.val {
        fast = fast?.next
        slow = slow?.next
    }
    
    return fast!
}
