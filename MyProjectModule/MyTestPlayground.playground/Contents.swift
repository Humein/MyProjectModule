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
        for subview in view.subviews {
            print(subview)
            recursionSubView(subview)
        }
    }
}
let view = UIView()
recursionSubView(view)

//88. 合并两个有序数组
//给定两个有序整数数组 nums1 和 nums2，将 nums2 合并到 nums1 中，使得 num1 成为一个有序数组。

func mergeArrays(_ num1 :[Int],_ m :Int,_ nums2 :[Int],_ n:Int) -> [Int] {
    
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
    
    return nums1
}

var nums1 = [1,2,3,0,0,0], mm = 3
var nums2 = [2,5,6],       nn = 3

mergeArrays(nums1,mm,nums2,nn)

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
func binarySearch(_ nums: [Int], _ target :Int){
    var p1 = 0, p2 = nums.count - 1
    while p1 <= p2 {
        var mid = (p2 - p1)/2 + p1
        if nums[mid] == target {
            return mid
        }else if nums[mid] < target{
            leftP = mid + 1
        }else{
            rightP = mid - 1
        }
    }
    return -1
}


//MARK:- list4:
//344. 反转字符串
func reverseString(_ s: Character){
    if s.count < 2 {
        return s
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
    
    return[arr[p1..<(p1+k)]]
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
