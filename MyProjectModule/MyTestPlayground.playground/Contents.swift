import UIKit
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
//392.判断子序列  判断 s 是否为 t 的子序列。
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
func getMaxArea(_ height :[Int]) -> Int{
    var leftP = 0, rightP = height.count - 1, maxArea = 0
    
    while leftP <= rightP {
        var minHeight = 0 //木桶原理
        if height[leftP] > height[rightP] {
            minHeight = height[rightP]
            rightP -= 1
        }else{
            minHeight = height[leftP]
            leftP -= 1
        }
        
        maxArea = max(maxArea,(rightP - leftP + 1) * minHeight)
    }
    
    return maxArea
    
}
getMaxArea([1,8,6,2,5,4,8,3,7])




//704. 二分查找
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
        let mid = (p1 - p2)/2 + p1
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
func isBadVersions(_ target: Int) -> Bool{
    print("isBadVersion")
    if target >= 4 {
        return true
    }else{
        return false
    }
}
func findFirstError(_ nums: [Int],_ target: Int) -> Int {
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
func findDuplicates(_ nums: [Int]) -> [Int] {
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
func longestCommonPrefix(_ strs: [String]) -> String {
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
 迭代法的思路是BFS或者DFS，这两种方法都可以实现，实际上也是二叉树的遍历。BFS用Queue实现，DFS的话将代码中的Queue换成Stack。
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
func invertTree(_ root: TreeNode?) -> TreeNode? {
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

 动态规划
 * 递归是自顶向下，动归是自底向上
 1 最优子结构  ans = nums[0]
 2 状态转移方程式  ans = max(ans, sum)
 3 边界     for num in nums
 解题步骤: 1,建立数学模型 2,写代码求解问题
 */
//func maxSubArray(_ nums: [Int]) -> Int {
//     var result = Dictionary<Int,Int>()
//     for i in 0..<nums.count {
//     result[i] = nums[i]
//     }
//
//     var maxNum = nums[0]
//
//     for i in 1 ..< nums.count{
//
//         if result[i-1]! > 0{
//             result[i] = result[i-1]! + nums[i] // 最小子结构
//         }
//
//         if result[i]! > maxNum{
//             maxNum = result[i]!
//         }
//     }
//
//     return maxNum
// }
func maxSubArray(_ nums: [Int]) -> Int {
    if nums.count == 0 {
        return -1
    }
    var ans = nums[0]
    var sum = 0
    for num in nums {
        if sum > 0 {
            sum += num
        }else{
            sum = num
        }
        ans = max(ans, sum)
    }
    
    return ans
}

