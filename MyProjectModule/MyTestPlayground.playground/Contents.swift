import UIKit
/**[swift-algorithm-club](https://github.com/raywenderlich/swift-algorithm-club)
   [LeetCode-Swift](https://github.com/soapyigu/LeetCode-Swift)
   [swift-leetCode 目录](https://github.com/strengthen/LeetCode/blob/master/README-CN.md)
 */
 

//MARK:- 递归
//MARK:- 排序
//MARK:- 动态规划
//MARK:- 贪心算法
//MARK:- 链表
//MARK:- 字符串
//MARK:- 数组
//MARK:- 二叉树



//MARK:- 递归
/*  递归详解  https://mp.weixin.qq.com/s/mJ_jZZoak7uhItNgnfmZvQ
 步骤
 0. 是否有边界
 1. 定义递归函数功能
 2. 寻找结束条件
 3. 寻找等价关系
    等价条件中，一定是范围不断在缩小，对于链表来说，就是链表的节点个数不断在变小
 
 处理好递归的3个主要的点:
 a) 出口条件，即递归“什么时候结束”，这个通常在递归函数的开始就写好;
 b) 如何由"情况 n" 变化到"情况 n+1/n-1", 也就是非出口情况，也就是一般情况——"正在"递归中的情况；
 c) 初始条件，也就是这个递归调用以什么样的初始条件开始

 递归由于是函数调用自身， 而函数调用是有时间和空间的消耗的：每一次函数调用，都需要在内存栈中分配空间以保存参数、返回地址及临时变量，而且往栈里压入数据和弹出数据都需要时间。另外，递归中有可能很多计算都是重复的，从而对性能带来很大的负面影响。除了效率之外，还有可能使调用栈溢出，前面分析中提到需要为每一次函数调用在内存栈中分配空间，而每个进程的栈的容量是有限的。当递归调用的层级太多时，就会超出栈的容量，从而导致调用栈溢出。
 */

/// 1-100 相加
func recursion100(_ n :Int) -> Int{
    if n == 1 {
        return 1
    }
    print(n)
    return recursion100(n - 1) + n
}
recursion100(10)

/// 遍历子view
func recursionSubView(_ view :UIView){
    if view.subviews.count > 0 {
        for item in view.subviews{
            print(item)
            recursionSubView(item)
        }
    }
}
let view = UIView()
recursionSubView(view)

//MARK:- 排序
//冒泡排序 升序
/*
 O(n²) 时间
 O(1)  空间
 冒泡排序是一种稳定的排序
 */

func bubbleSort(unsortedArray: inout [Int]){
    guard unsortedArray.count > 1 else{
        return
    }

    for i in 0 ..< unsortedArray.count - 1 {
        var exchanged = false
        for j in 0 ..< unsortedArray.count - 1 - i {
            if unsortedArray[j] > unsortedArray[j+1] {
                unsortedArray.swapAt(j, j+1)
                exchanged = true
            }
        }
        //若无交换则可直接返回
        if exchanged == false {
            break
        }
    }
}
var list = [2, 3, 5, 7, 4, 8, 6 ,10 ,1, 9]
bubbleSort(unsortedArray: &list)
print(list)



//MARK:- 动态规划    https://juejin.im/post/5dcb8201e51d45210f046f5a#heading-0
/*
 动态规划在查找有很多重叠子问题的情况的最优解时有效。它将问题重新组合成子问题。为了避免多次解决这些子问题，它们的结果都逐渐被计算并被保存，从简单的问题直到整个问题都被解决。因此，动态规划保存递归时的结果，因而不会在解决同样的问题时花费时间。

 动态规划只能应用于有最优子结构的问题。最优子结构的意思是局部最优解能决定全局最优解（对有些问题这个要求并不能完全满足，故有时需要引入一定的近似）。简单地说，问题能够分解成子问题来解决。
 
 适用情况
 最优子结构性质。如果问题的最优解所包含的子问题的解也是最优的，我们就称该问题具有最优子结构性质（即满足最优化原理）。最优子结构性质为动态规划算法解决问题提供了重要线索。
 无后效性。即子问题的解一旦确定，就不再改变，不受在这之后、包含它的更大的问题的求解决策影响。
 子问题重叠性质。子问题重叠性质是指在用递归算法自顶向下对问题进行求解时，每次产生的子问题并不总是新问题，有些子问题会被重复计算多次。动态规划算法正是利用了这种子问题的重叠性质，对每一个子问题只计算一次，然后将其计算结果保存在一个表格中，当再次需要计算已经计算过的子问题时，只是在表格中简单地查看一下结果，从而获得较高的效率。
 */


//MARK:-  贪心算法
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




//MARK:- 链表
/// 链表结构
class listNode {
    var next: listNode?
    var val: Int
    init(value: Int, next: listNode?) {
        self.val = value
        self.next = next
    }
}
public class LinkNode{
    public var val: Int
    public var next: LinkNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

///  相交链表 编写一个程序，找到两个单链表相交的起始节点。

/*
 双指针法O(n)
 */
func getIntersectionNode(_ headA : listNode?, _ headB : listNode?)  ->  listNode?{
    if headA == nil || headB == nil {
        return nil
    }
    var pA = headA
    var pB = headB
    
    while pA !== pB {
        pA = (pA == nil) ? headB : pA?.next
        pB = (pB == nil) ? headA : pB?.next
    }
    return pA
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
func mergeTwoLists(_ l1: listNode?,_ l2: listNode?) -> listNode?{
    // l1/l2 == nil  边界          l1?.next 递归转移方程

    if l1 == nil {
        return l2
    }
    
    if l2 == nil{
        return l1
    }
    print(l1!.val)

    if l1!.val < l2!.val{
        l1?.next = mergeTwoLists(l1?.next, l2)
        return l1
    }else{
        l2?.next = mergeTwoLists(l1, l2?.next)
        return l2
    }
}

let node5 = listNode(value: 5, next: nil)
let node4 = listNode(value: 4, next: node5)
let node3 = listNode(value: 3, next: node4)
let node2 = listNode(value: 2, next: node3)
let node1 = listNode(value: 1, next: node2)
mergeTwoLists(node1,node2)

/// 206. 反转链表  递归还是在借助函数调用栈的思想，其实本质上也是一个栈。
/*
 等价条件中，一定是范围不断在缩小，对于链表来说，就是链表的节点个数不断在变小
  reverseList(head) 等价于 ** reverseList(head.next)** + 改变一下1，2两个节点的指向。好了，等价关系找出来了
 */
func reverseLinkRec(_ head: listNode?) -> listNode?{
    
    if head == nil || head?.next == nil {
        return head
    }
    
    //反转第一个节点之后的链表, 我们先把递归的结果保存起来，先不返回，因为我们还不清楚这样递归是对还是错。
    // 不放在 逻辑处理后面 是因为逻辑处理 会改变head?.next
    print("=========")
    let newHead = reverseLinkRec(head?.next) // 栈顶
    print("---------")

//  只需要把节点 2 的 next 指向 1，然后把 1 的 next 指向 null,不就行了？
    head?.next?.next = head
    head?.next = nil
    return newHead
}

var head0 = listNode.init(value: 0, next: nil)
var head1 = listNode.init(value: 1, next: head0)
var head2 = listNode.init(value: 2, next: head1)
var head3 = listNode.init(value: 3, next: head2)
var head = listNode.init(value: 4, next: head3)
reverseLinkRec(head)

// 迭代实现
func ReverseListWhile(_ head: LinkNode?) -> LinkNode? {
    var reversedHead: LinkNode? = nil
    var node: LinkNode? = head
    var prev: LinkNode? = nil
    while node != nil {
        let next = node?.next
        if next == nil {
            reversedHead = node
        }
        node?.next = prev
        prev = node
        node = next
    }
    return reversedHead
}

//MARK:- 字符串
//344. 反转字符串
/*
双指针 迭代方式
*/
func reverseString(_ s: inout [Character]){
    //记得 边界1
    if  s.count < 2 {
        return
    }
    var p1 = 0, p2 = s.count - 1
    // let sArr = Array(s) 输入就是数组了
    // 指针边界2
    while p1 < p2 {
        // tmp 应该提出来声明 减少创建
        let tmp = s[p1]
        s[p1] = s[p2]
        s[p2] = tmp
        p1 += 1
        p2 -= 1
    }
}

// 字符串反转
fileprivate func reverse<T>(_ chars: inout [T], _ start: Int, _ end: Int) {
  var start = start, end = end
  while start < end {
    swap(&chars, start, end)
    start += 1
    end -= 1
  }
}
fileprivate func swap<T>(_ chars: inout [T], _ p: Int, _ q: Int) {
  (chars[p], chars[q]) = (chars[q], chars[p])
}

// 单词反转  s 是 "the sky is blue", 那么反转就是 "blue is sky the"。
func reverseWords(s: String?) -> String? {
  guard let s = s else {
    return nil
  }

  var chars = Array(s), start = 0
  reverse(&chars, 0, chars.count - 1)

  for i in 0 ..< chars.count {
    if i == chars.count - 1 || chars[i + 1] == " " {
      reverse(&chars, start, i)
      start = i + 2
    }
  }

  return String(chars)
}


/// 392.判断子序列
/*
 判断 s 是否为 t 的子序列。
 本文主要运用的是双指针的思想，指针si指向s字符串的首部，指针ti指向t字符串的首部。
 */
func isSubsequence(_ s :String, _ t :String) -> Bool{
    var sp = 0, tp = 0
    let sArray = Array(s), tArray = Array(t)
    //指针边界
    while sp < sArray.count && tp < tArray.count  {
        if sArray[sp] == tArray[tp] {
            sp += 1
        }
        tp += 1
    }
    
    return sp == s.count
}
print(isSubsequence("acd","abcd"))

//MARK:- 数组
// 658. 找到 K 个最接近的元素
/*
 变种 二分查找
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


/// 33. 搜索旋转排序数组
/**
 假设按照升序排序的数组在预先未知的某个点上进行了旋转。
 搜索一个给定的目标值，如果数组中存在这个目标值，则返回它的索引，否则返回 -1 。
 你可以假设数组中不存在重复的元素
 解题
 1、先创建两个指针left和right，然后取mid=(right+left)/2,将数组一分为二。其中肯定有一个有序，一个可能有序或者部分有序，
 2、然后在有序的范围内判断target是否在有序范围内，然后移动left或right，继续步骤一，直到找到nums[mid] == target,返回mid，否则返回-1。
 时间复杂度：O(log(n))。空间复杂度：O(1)
 */
func search(_ nums: [Int], _ target: Int) -> Int {
    var left = 0
    var right = nums.count - 1
    while left <= right {
        // 当前居中的位置
        let mid = (right + left) / 2
        if nums[mid] == target {// 循环执行,知道找到nums[mid] == target,然后返回mid
            return mid
        }
        // 如果nums[mid] < nums[right]说明,mid->right是有序的
        if nums[mid] < nums[right] {
            // 如果target在nums[mid]与nums[right]之间,left向右移动至mid+1
            if nums[mid] < target && target <= nums[right] {
                left = mid + 1
            }else {// 否则right向左移动至mid-1
                right = mid - 1
            }
        }else{// 否则说明left->mid是有序的
            // 如果target在nums[left]与nums[right]之间,right向左移动至mid-1
            if nums[left] <= target && target < nums[mid] {
                right = mid - 1
            }else{// 否则left向左移动至mid+1
                left = mid + 1
            }
        }
    }
    return -1
}


/* 二分查找 双指针
 */
func binarySearch(_ nums: [Int], _ target :Int) -> Int{
    var p1 = 0, p2 = nums.count - 1
    
    while p1 < p2 {
        let mid = (p2 - p1) / 2 + p1 //记得加p1
        if nums[mid] == target {
            return mid
        }else if nums[mid] > target {
            p2 = mid - 1 // 记得 - 1
        }else{
            p1 = mid + 1 // 记得 + 1
        }
    }
    
    return -1
}

//11. 盛最多水的容器
/*
 双指针
现在，为了使面积最大化，我们需要考虑更长的两条线段之间的区域。如果我们试图将指向较长线段的指针向内侧移动，矩形区域的面积将受限于较短的线段而不会获得任何增加。但是，在同样的条件下，移动指向较短线段的指针尽管造成了矩形宽度的减小，但却可能会有助于面积的增大。因为移动较短线段的指针会得到一条相对较长的线段，这可以克服由宽度减小而引起的面积减小。
*/
func getMaxArea(_ height: [Int]) -> Int{
    // 记得边界
    if height.count == 0 {
        return 0
    }
    
    var p1 = 0, p2 = height.count - 1, maxArea = 0
    
    while p1 < p2 {
        // 遍历出每次最低高度
        var minHeight = 0
        if height[p1] < height[p2]{
            minHeight = height[p1]
            p1 += 1
        }else{
            minHeight = height[p2]
            p2 -= 1
        }
        // 记得 + 1
        maxArea = max(maxArea, (p2 - p1 + 1) * minHeight)
    }
    
    return maxArea
    
}
getMaxArea([1,8,6,2,5,4,8,3,7])


///136. 只出现一次的数字  遍历异或
func singleNum(_ nums :[Int]) -> Int{
    var result = 0
    for num in nums {
        result = result ^ num
    }
    return result
}

/// 88. 合并两个有序数组 ---  3个指针迭代
/*
 给定两个有序整数数组 nums1 和 nums2，将 nums2 合并到 nums1 中，使得 num1 成为一个有序数组。
 初始化 nums1 和 nums2 的元素数量分别为 m 和 n。
 你可以假设 nums1 有足够的空间（空间大小大于或等于 m + n）来保存 nums2 中的元素。

 3个指针迭代 可以类比 21题
 */

func mergeArrays(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    
    var p1 = m - 1, p2 = n - 1, p = m + n - 1
    
    while p1 >= 0 && p2 >= 0 {
        if nums1[p1] >= nums2[p2] {
            nums1[p] = nums1[p1]
            p1 -= 1
            p -= 1
        }else{
            nums1[p] = nums2[p2]
            p2 -= 1
            p -= 1
        }
    }
    
    while p2 >= 0 {
        nums1[p] = nums2[p2]
        p -= 1
        p2 -= 1
    }
}
var nums1 = [1,2,3,0,0,0,0,0,0,0], mm = 3
var nums2 = [2,5,6,7,8,9,10],       nn = 7
mergeArrays(&nums1,mm,nums2,nn)


/// 1. 两数之和
func twoSums(_ nums: [Int],_ target: Int) ->[Int]{
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

// 如何在有序数组中找出和等于给定值的两个元素？LeetCode第167题
func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
    var i = 0, j = numbers.count - 1
    while i < j {
        let sum = numbers[i] + numbers[j]
        if sum == target {
            return [i + 1, j + 1]
        }else if sum > target {
            j -= 1
        }else {
            i += 1
        }
    }
    return []
}



/// 栈实现
/*
 也可以通过数组去实现 popLast append
  swift 中struct,enum 均可以包含类方法和实例方法,swift官方是不建议在struct,enum 的普通方法里修改属性变量,但是在func 前面添加ing 关键字之后就可以方法内修改.
 */
protocol Stack {
  /// 持有的元素类型
  associatedtype Element
  
  /// 是否为空
  var isEmpty: Bool { get }
  /// 栈的大小
  var size: Int { get }
  /// 栈顶元素
  var peek: Element? { get }
  
  /// 进栈
  mutating func push(_ newElement: Element)
  /// 出栈
  mutating func pop() -> Element?
}

struct IntegerStack: Stack {
  typealias Element = Int
  
  var isEmpty: Bool { return stack.isEmpty }
  var size: Int { return stack.count }
  var peek: Element? { return stack.last }
  
  private var stack = [Element]()
  
  mutating func push(_ newElement: Element) {
    stack.append(newElement)
  }
  
  mutating func pop() -> Element? {
    return stack.popLast()
  }
}

var stacks = IntegerStack.init()
stacks.push(1)
stacks.push(2)
stacks.push(3)
stacks.pop()
print(stacks)


//MARK:- 二叉树
/*
 [每天学点数据结构 —— 红黑树（6k字总结](https://juejin.im/post/5dde545bf265da06074f13cc)
 */

/// 二叉树结构
public class TreeNode: Equatable {
     public var parent: TreeNode?
     public var val: Int
     public var left: TreeNode?
     public var right: TreeNode?
     public init(value: Int, left: TreeNode?, right: TreeNode?) {
         self.val = value
         self.left = left
         self.right = right
     }
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.val == rhs.val
    }
 }

/// 235. 二叉搜索树的最近公共祖先 / 怎么查找两个view的公共父视图
/**
 用两个「指针」，分别指向两个路径的根节点，然后从根节点开始，找第一个不同的节点，第一个不同节点的上一个公共节点
 */

func findSuperViews(_ view: UIView?) -> [UIView] {
    var view = view
    if view == nil {
        return []
    }
    var resultArray = [UIView]()
    while view != nil {
        resultArray.append(view!)
         // next
        view = view?.superview
    }
    return resultArray
}

let viewA = UIView()
let viewB = UIView()
viewA.addSubview(viewB)
findSuperViews(viewB)

func findRecentRoot(_ viewA: UIView?,_ viewB: UIView?) -> UIView? {
    let aArray = findSuperViews(viewA)
    let bArray = findSuperViews(viewB)
    var p1 = aArray.count - 1, p2 = bArray.count - 1
    var rootView :UIView?
    while p1 >= 0 && p2 >= 0 {
        if aArray[p1] == bArray[p2] {
            rootView = aArray[p1]
        }
        p1 += 1
        p2 += 1
    }
    return rootView
}

/// 236. 二叉树的最近公共祖先
/**
 - https://blog.csdn.net/qq_28114615/article/details/85715017
   根据临界条件，实际上可以发现这道题已经被简化为查找以root为根结点的树上是否有p结点或者q结点，如果有就返回p结点或q结点，否则返回null。
   这样一来其实就很简单了，从左右子树分别进行递归，即查找左右子树上是否有p结点或者q结点，就一共有4种情况：
 */

func findCloseRoot(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode?{
    // 边界 以及 递归结束条件
    if root == p || root == q || root == nil {
        return root
    }
    
    let left = findCloseRoot(root?.left, p, q)
    let right = findCloseRoot(root?.right, p, q)
    
    if left == nil && right == nil {
        return nil
    }else if left == nil && right != nil{
        return right
    }else if right == nil && left != nil{
        return left
    }
    
    return root
}




//怎么通过view去找到对应的控制器
func findVC(_ view: UIView?) -> UIViewController?{
    if view == nil {
        return nil
    }
    var responder :UIResponder? = view!
    while responder != nil {
        if responder!.isKind(of: UIViewController.classForCoder()) {
            return (responder as! UIViewController)
        }
        responder = responder!.next
    }
    return nil
}

/*
 view 和 UIViewController 都继承 UIResponder
 利用响应链知识 ，链表指针查找 view的 nextResponder。
 一个指针的迭代
 */

/*
 -(UIViewController *)findVC:(UIView *)view{
    id responder = view;
 
    while responder {
    if responder isKindOfClass:[UIViewController class] {
      return responder
    }
    responder = [responder nextResponder]
   }
    return nil
 }
 
 // YY 实现方式
 - (UIViewController *)yy_viewController {
     for (UIView *view = self; view; view = view.superview) {
         UIResponder *nextResponder = [view nextResponder];
         if ([nextResponder isKindOfClass:[UIViewController class]]) {
             return (UIViewController *)nextResponder;
         }
     }
     return nil;
 }
 */



//MARK:- list1：
//MARK:- list2：
//MARK:- list3:
//MARK:- list4:
//MARK:- list5:




//14. 最长公共前缀
/*
 取出第一个字符串，使用后面的字符串判断第一个字符串是否是他们的前缀，不是则将第一个字符串长度减一，继续判断
 */
func longestCommonPrefix(_ strs: [String]) -> String {
    let count = strs.count
    
    if count == 0 {
        return ""
    }
    if count == 1 {
        return strs.first!
    }
    
    var result = strs.first!
    
    for i in 1..<count {
        while !strs[i].hasPrefix(result) {
            result = String(result.prefix(result.count - 1))
            print(result)
            if result.count == 0 {
                return ""
            }
        }
    }
    return result
}
longestCommonPrefix(["flower","flow","flight"])
var results = "flower"
results = String(results.prefix(results.count - 1))

//MARK:- list7:
//226. 翻转二叉树
/*
 迭代法的思路是BFS或者DFS，这两种方法都可以实现，实际上也是二叉树的遍历。
 BFS用Queue实现， 宽度优先搜索（breadth first search
 DFS的话将代码中的Queue换成Stack。

 递归最简单
 */


// 递归
func invertTree(_ root :TreeNode?) -> TreeNode? {
    // 边界
    if root == nil {
        return nil
    }
    
    //递归转移
    let right = invertTree(root?.right) // stack push
    let left = invertTree(root?.left) // stack push
    root?.left = right // pop
    root?.right = left // pop
    return root
}



//二维数组中的查找
/*
 在一个二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序，输入一个二维数组中的数字，判断二维书中是否存在,存在返回true，不存在返回false~
 思路:

 1:第一反应都是二分查找。对于每一行进行二分查找，然后查找过程可以把某些列排除掉，这是大家都能想到的基本的思路。

 2:首先选取数组右上角的数字，如果该数字等于要查找的数字，则查找结束；如果该数字大于要查找的数字，剔除这个数字所在的列，如果该数字小于要查找的数字，剔除这个数字所在的行。这样每一步都可以剔除一行或一列，查找的速度比较快。

 */
func searchMatrix(data: [[Int]],number: NSInteger) -> Bool{
    if data.count == 0 || data.isEmpty{
        return  false
    }
    var row :Int = 0, col :Int = data[0].count - 1

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
    
    // 备忘录字典
     var result = Dictionary<Int,Int>()
    
    //下标为key
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
maxSubArrayMemo([-2,1,-3,4,-1,2,1,-5,4,6])

func maxSubArrayDP(_ nums: [Int]) -> Int {

    //边界
    if nums.count == 0 {
        return -1
    }
    //最优子结构 一般·用数组去存储
    var curMaxSub = [nums[0]]
    var sum = 0
    
    // 迭代边界
    for num in nums {
        if sum > 0 {
            //累计和不小于0 继续累加
            sum += num
        }else{
            //如果累计和小于0，则抛弃之前的累计和(子序列)，从新的开始
            sum = num
        }
        
        //将当前子序列和现有的子序列最大进行比较
        // 状态转移方程
        curMaxSub.append(max(curMaxSub.last!, sum))
    }
    return curMaxSub.last!
}
maxSubArrayDP([-2,1,-3,4,-1,2,1,-5,4,6])



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
    
    var p1 = 0, p2 = 0, p = 0, result = 0
    //边界
    if s.count == 0 {
        return result
    }
    //窗口
    result = p2 - p1
    let chars = Array(s)
    //遍历条件
    //窗口滑动
    while p2 < chars.count {
        p = p1
        //窗口内部查重
        while p < p2 {
            if chars[p] == chars[p2] {
                p1 = p + 1 //窗口左边移动
                break
            }
            p = p + 1
        }
        result = max(result, p2 - p1 + 1)
        p2 = p2 + 1 //窗口右边移动
    }
    
    return result
}
lengthOfLongestSubstringWD("bbbbacde")

//46. 全排列
/*
 回溯算法关键在于:不合适就退回上一步
 然后通过约束条件, 减少时间复杂度.
 */


//62. 不同路径
/*
递推方程
  dp[i] [j] = dp[i-1] [j] + dp[i] [j-1]

我们的初始值是计算出所有的(最小子)
  dp[0] [0….n-1] 和所有的 dp[0….m-1] [0]
这个还是非常容易计算的，相当于计算机图中的最上面一行和左边一列。因此初始值如下：
  dp[0] [0….n-1] = 1; // 相当于最上面一行，机器人只能一直往左走
  dp[0…m-1] [0] = 1; // 相当于最左面一列，机器人只能一直往下走
*/
func uniquePaths(_ m: Int, _ n: Int) -> Int {
    ///边界
    if m <= 0 || n <= 0 {
        return 0
    }
    
    /// 最小子 二维数组
    var dp = [[Int]]()
    
    //创建 DP 二维数组  垃圾swift 二维数组操作
    for _ in 0..<m{
        var eachRow:[Int] = []
        for _ in 0..<n{
        eachRow.append(n);
        }
        dp.append(eachRow);
    }

    
        
    //一直往下走
    for i in 0..<m {
        dp[i][0] = 1
    }
    //一直往左走
    for i in 0..<n {
        dp[0][i] = 1
    }
    
    /// 递推
    for i in 1..<m {
        for j in 1..<n {
            dp[i][j] = dp[i-1][j] + dp[i][j-1]
        }
    }

    return dp[m-1][n-1]
    
}
uniquePaths(3, 2)

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
  ' 最小子问题 // 最优子结果
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
       //创建 DP 二维数组
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
//70. 爬楼梯 本质就是 斐波拉切数列
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
func climbStairsMemo(_ n: Int) -> Int{
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
func dyclimbStairs(_ n: Int) -> Int {
    // 边界值
    if n == 1 || n == 2{
        return n
    }
    
    var dp = [1,1,2] // 最优子结果
    
    //遍历 动态转移方程 dp[n] = dp[n-1] + dp[n-2]
    // 3 ... n 左开右开 3 到 n
    /**
        注意 4 ... n 会报错，原因是 当 n = 3 时，条件会是  4 ... 3， 所以最小子结果，就只能是最小的，多一个都不行
     */
    for i in 3 ... n {
        print(i)
        //状态转移方程
        dp.append(dp[i-1] + dp[i-2])
    }
    print(dp)
    return dp[n-1]
}

dyclimbStairs(3)

// 临时变量 DP 就是递推
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
  1 最优子结构(2个)
     1- 只要考虑当天买和之前买哪个收益更高，
     2- 当天卖和之前卖哪个收益更高。
  2 边界
  3 状态转移方程(2个)    第二个方程的参数是第一个方程的解
 */

func dynamicMaxProfit(_ prices :[Int]) -> Int{
    // 边界
    if prices.count <= 1 {
        return 0
    }
    // 两个最小子结构
    var min_b = prices[0], max_p = 0//这个是利润 最小就是0
    
    //3 状态转移方程 min_b max_p 都是当前的最优，随着遍历一直往下走
    for idx in 1 ... prices.count - 1 {
        // 得出idx之前最小的
        min_b = min(min_b, prices[idx]) // 一直取买入最低的价格 // 最优子结构
        /*
         prices[idx] 减去 idx之前最小的
         */
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
func greedyMaxProfit(_ prices: [Int]) -> Int{
    if prices.count <= 1 {
        return 0
    }
    
    var profit = 0
    
    for idx in 1...prices.count - 1{
        if prices[idx] > prices[idx - 1] {
            profit += prices[idx] - prices[idx - 1]
        }
    }
    return profit
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
    // dp = [nums[0], max(nums[0],nums[1]), max(nums[2] + dp[0], dp[1]).......max(nums[i] + dp[i-2],dp[i-1])]
    
    for i in 2 ..< nums.count{
        print(i)
        //状态转移方程
        //dp[i] = max(dp[i - 2] + nums[i], dp[i - 1]) 递推公式
        dp.append(max(nums[i] + dp[i-2], dp[i-1]))
    }
    
    return dp.last!
}


//141. 环形链表
/*
 给定一个链表，判断链表中是否有环。
 为了表示给定链表中的环，我们使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。 如果 pos 是 -1，则在该链表中没有环。

 笔者理解 快慢指针《双指针》，+ 一般画用到指针的都要有循环，有循环就会有条件
 
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

//MARK:- list14:

//142 环形链表 II 
/*
 给定一个链表，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。



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
    // 边界
    if fast == nil || fast?.next == nil {
        return nil
    }
    
    while fast != nil && fast?.next != nil {
        fast = fast?.next?.next
        slow = slow?.next
        if slow?.val == fast?.val {
            break;
        }
    }
    
    fast = head //重置快指针到首位< 这时 slow - fast = k(环的位置)  >
    while fast?.val != slow?.val {
        fast = fast?.next
        slow = slow?.next
    }
    
    return fast!
}






/*
 手撕快排 https://www.jianshu.com/p/5a81ba81886d
 */
//需要额外空间 比较好理解

func quickSort2(_ data: [Int]) -> [Int] {
    // 边界
    if data.count <= 1 {
        return data
    }
    // 初始化 左数组 右数组 以及pivot
    var left: [Int] = []
    var right: [Int] = []
    let pivot: Int = data[data.count - 1]
    
    // 遍历分别放到左右区域   注意：条件中排除了基准值
    for index in 0..<data.count - 1 {
        if data[index] < pivot {
            left.append(data[index])
        }else{
            right.append(data[index])
        }
    }
    // 递归处理 left 区域
    var result = quickSort2(left)
    // 拼接准基
    result.append(pivot)
    // 递归处理 right 区域
    let rightResult = quickSort2(right)
    // 拼接rightArray
    result.append(contentsOf: rightResult)
    
    return result
}

let data:[Int] = [1,2,3,2,4,8,9,10,19,0]
let result = quickSort2(data)
print("FlyElephant方案1:-\(result)")

// 厉害了我的杯
/*
 有一种玻璃杯质量确定但未知，需要检测。
 有一栋100层的大楼，该种玻璃杯从某一层楼扔下，刚好会碎。
 现给你两个杯子，问怎样检测出这个杯子的质量，即找到在哪一层楼刚好会碎？
 https://mp.weixin.qq.com/s/MtSr6Id80sxBdNsgHLLxJw
 */

//MARK:- list15:

//offer6：从尾到头打印链表
/*
 // 题目：输入一个链表的头结点，从尾到头反过来打印出每个结点的值。
 // 本代码解法，使用一个栈存储各个节点 😓, 再反向打印
 // 其他解法： 比如递归调用(递归函数本质上也是一个栈结构)，或者修改链表
 */


// 栈实现 <swift没有内建stack，我们用数组反转代替>
func reversePrintList(_ node: listNode) -> [Int]{
    var nodes = [Int]()
    var curNode :listNode? = node
    while curNode != nil {
        nodes.append(curNode!.val)
        curNode = curNode!.next
    }
    
    return nodes.reversed()
}


// 递归 第二种方法也比较容易想到，通过链表的构造，如果将末尾的节点存储之后，剩余的链表处理方式还是不变，所以可以使用递归的形式进行处理。
func recReverPrint(_ node: listNode) -> [Int]{
    return [-1]
}

func testCase1() {
    let node5 = listNode(value: 5, next: nil)
    let node4 = listNode(value: 4, next: node5)
    let node3 = listNode(value: 3, next: node4)
    let node2 = listNode(value: 2, next: node3)
    let node1 = listNode(value: 1, next: node2)
    reversePrintList(node1)
}

testCase1

// offer9：用两个栈实现队列
/*
 题目：用两个栈实现一个队列。队列的声明如下，请实现它的两个函数appendTail
 和deleteHead，分别完成在队列尾部插入结点和在队列头部删除结点的功能。
 
 备注：使用array模拟stack，只用了数组的append和removeLast方法
 */

class MyQueue<T> {
    private var array1 = [T]()
    private var array2 = [T]()

    func appendTail(element: T) {
        array1.append(element)
    }
    
    func deleteHead() -> T?{
        if array2.count > 0 {
            return array2.removeLast()
        }else{
            while array1.count > 0 {
                array2.append(array1.removeLast())
            }
            if array2.count > 0 {
                return array2.removeLast()
            } else {
                return nil
            }
        }
    }
}

//MARK:-list16:
//offer10  斐波那契数列  题目：写一个函数，输入n，求斐波那契（Fibonacci）数列的第n项。
/*
  这个和爬楼梯是一样的
 */

func fibbon(_ n: Int) -> Int{
    if n == 1 || n == 2{
        return n
    }
    
    return fibbon(n - 1) + fibbon(n - 2)
}
// 递归太耗时
fibbon(25)

func fibbonDP(_ n: Int) -> Int{
    if n == 1 || n == 2{
        return n
    }
    
    var dp = [1,1,2]
    
    for i in 3...n {
        dp.append(dp[i - 1] + dp[i - 2])
    }
    print(dp)
    return dp.last!
}

fibbonDP(25)


//MARK:-list17:

//offer11：旋转数组的最小数字 / 153. 寻找旋转排序数组中的最小值
/* https://cloud.tencent.com/developer/article/1406918
 把一个数组最开始的若干个元素搬到数组的末尾，我们称之为数组的旋转。 输入一个非减排序的数组的一个旋转，输出旋转数组的最小元素。 例如数组{3,4,5,1,2}为{1,2,3,4,5}的一个旋转，该数组的最小值为1。 NOTE：给出的所有元素都大于0，若数组大小为0，请返回0。
 
 采用二分法解答这个问题，
 mid = low + (high - low)/2
 需要考虑三种情况：
 (1)array[mid] > array[high]:
 出现这种情况的array类似[3,4,5,6,0,1,2]，此时最小数字一定在mid的右边。
 low = mid + 1
 
 (2)array[mid] == array[high]:
 出现这种情况的array类似 [1,0,1,1,1] 或者[1,1,1,0,1]，此时最小数字不好判断在mid左边
 还是右边,这时只好一个一个试 ，
 high = high - 1
 
 (3)array[mid] < array[high]:
 出现这种情况的array类似[2,2,3,4,5,6,6],此时最小数字一定就是array[mid]或者在mid的左
 边。因为右边必然都是递增的。
 high = mid
 注意这里有个坑：如果待查询的范围最后只剩两个数，那么mid 一定会指向下标靠前的数字
 比如 array = [4,6]
 array[low] = 4 ;array[mid] = 4 ; array[high] = 6 ;
 如果high = mid - 1，就会产生错误， 因此high = mid
 但情形(1)中low = mid + 1就不会错误
 */

// 以p2为 动态基准，以mid 为中间准基。以p1为结果=
func findMin(_ array: [Int]) -> Int{
    
    if array.count == 0 {
        return 0
    }
    var p1 = 0, p2 = array.count - 1
    while p1 < p2 {
        //使得p1、p2交叉，p1指向最小的数
        let mid = (p2 - p1)/2 + p1
        if array[mid] > array[p2] {
            p1 = mid + 1
        }else if array[mid] < array[p2]{
            p2 = mid
        }else if array[mid] == array[p2]{
            p2 = p2 - 1 //等于的话 p2要不断趋于减少
        }
    }
    
    return array[p1]
}

findMin([3,4,5,1,2])

//offer14：剪绳子
/*
 题目描述
 　　给你一根长度为n的绳子，请把绳子剪成m段（m、n都是整数，n>1并且m>1），每段绳子的长度记为k[0],k[1],...,k[m]。请问k[0]xk[1]x...xk[m]可能的最大乘积是多少？例如，当绳子的长度是8时，我们把它剪成长度分别为2、3、3的三段，此时得到的最大乘积是18。
 输入描述:
 　　输入一个数n，意义见题面。（2 <= n <= 60）

 示例1
 输入　　8
 输出　　18
 */
// 动态规划
/*
   1: 边界
   2: 最优子结构
   3: 动态转移方程
 */
func maxCute_DP(length: Int) -> Int {
//    1: 边界
    if length < 2{
        return 0
    }
    
    if length == 2 {
        return 1
    }
    
    if length == 3 {
        return 2
    }
    
//    2: 最优子结构 可以推导出DP方程式  dp[i]=dp[j]*dp[i-j]
    var dp = [0,1,2,3]
    var result = 0
    for i in 4...length{
        result = 0
        for j in 1...i/2 {
            let product = dp[j] * dp[i-j]
            result = max(product, result)
        }
        dp.append(result)
    }
    print(dp)
    return dp[length]
}

maxCute_DP(length:4)

// 贪心算法：尽可能多地减去长度为3的绳子段，当绳子最后剩下的长度为4的时候，剪成2*2的2段
func maxCute_Greed(length: Int) -> Int { return -1}


//MARK:-list18:

/* offer18（一）：在O(1)时间删除链表结点/ 237. 删除链表中的节点
 链表操作
  - 修改节点 可以用 覆盖和 指向 两个思路。
  - 单链表用覆盖 双链表用指向。
*/

// 1: 单链表删除 - 指针指向的对象不变，节点的值覆盖, 前提被删除node不是尾节点
func deleteNode1(_ node: listNode?) {
    if node == nil{
        return
    }
    if node!.next == nil {
        return
    }
    /// 本质是将要删除的节点 覆盖掉<value 和 指向>
    node!.val = node!.next!.val
    node!.next = node!.next!.next
}

// 2:单链表删除 - 这个好
/**
 - 前提toBeDeleted是从输入链表内部取出的，
 - 如果是新建的一个就要另一种方式了。
 - 而且双向链表删除方式也是不一样
 */
func deleteNode2(_ head: inout listNode?, _ toBeDeleted: listNode?){
    if head == nil || toBeDeleted == nil {
        return
    }
    if toBeDeleted?.next !== nil {
        toBeDeleted?.val = (toBeDeleted?.next!.val)!
        toBeDeleted?.next = toBeDeleted?.next?.next
    } else {
        /**
         - 问题1: 为什么要用一个 while 循环
           答: 因为最后一个节点，下一个是nil. 直接覆盖nil, 代码是通不过的。 只能寻找上个节点，然后将上个节点的next = nil
         - 问题2: 为什么引入一个新变量
           答: head = head.next 会修改链表的
        */
        var node = head!
        while node.next !== nil {
            if node.next === toBeDeleted {
                node.next = nil
                return
            }
            node = node.next!
        }
        /** or
         var node = head!
         while node.next !== toBeDeleted {
             node = node.next!
         }
         node.next = nil
         */
    }
    
}

// 一个函数改变函数外面变量的值(将一个值类型参数以引用方式传递)，这时，Swift提供的inout关键字就可以实现
// 3:单链表删除
func deleteNode3(_ head: inout listNode?, _ toBeDeleted: listNode?){
    if head == nil || toBeDeleted == nil {
        return
    }

    //如果需要删除的节点位于尾部，需要从head开始便利到node前面的节点
    if toBeDeleted!.next === nil {
        var node = head!
        while node.next! !== toBeDeleted! {
            node = node.next!
        }
        node.next = nil //删除
    }else {
        //不位于尾部
        // 取出要删除节点的下一个节点
        var node = toBeDeleted!.next
        // del -> del.next -> del.next.next
        // 删除节点下一个指向 要删除节点的next.next
        toBeDeleted!.next = node!.next
        toBeDeleted!.val = node!.val
        node = nil
    }
}

func executeDelete() {
    let node5 = listNode(value: 5, next: nil)
    let node4 = listNode(value: 4, next: node5)
    let node3 = listNode(value: 3, next: node4)
    let node2 = listNode(value: 2, next: node3)
    var node1: listNode? = listNode(value: 1, next: node2)
    
    printList(node1!)
//    deleteNode1(node4)
    deleteNode2(&node1, node5)
//    deleteNode3(&node1, node1)
    printList(node1 ?? listNode(value: -1, next: nil))
}

/// 打印链表
func printList(_ node: listNode) -> [Int]{
    var nodes = [Int]()
    // 引入临时 防止原数据修改
    var curNode :listNode? = node
    while curNode != nil {
        nodes.append(curNode!.val)
        curNode = curNode!.next
    }
    return nodes
}

executeDelete()


//MARK:-list19:
//83. 删除排序链表中的重复元素
func deleteDupNodel(_ head: listNode?) -> listNode?{
    var curHead = head
    //边界循环
    while curHead != nil && curHead!.next != nil {
        if curHead!.next?.val == curHead!.val {
            curHead!.next = curHead!.next!.next
        } else {
            curHead = curHead!.next
        }
    }
    return head
}

//offer22：链表中倒数第k个结点
/*
 输入一个链表，输出该链表中倒数第k个结点。为了符合大多数人的习惯，
  本题从1开始计数，即链表的尾结点是倒数第1个结点。例如一个链表有6个结点，
  从头结点开始它们的值依次是1、2、3、4、5、6。这个链表的倒数第3个结点是值为4的结点。
 
 思路1：如果能从链表尾部开始遍历，那只需倒序遍历 k 个节点即是要找出的节点，但是由于是单链表，只能从头结点开始遍历。

 思路2：先遍历一遍该单链表，获取链表的总节点数 n，那么第 n-k+1 这个节点就是倒数第 k 个节点。所以第二次再遍历到第 n-k+1 这个节点即可，但是题目要求只能遍历一遍链表。

 思路3：通过遍历该链表把节点都存入到一个数组中，然后再通过数组下标可直接获取到倒数第 k 个节点，但是这样会需要额外的存储空间，空间复杂度为 O(n)。
 
 最终思路：  双指针
 假如有两个指针一个快一个慢，快和慢之间的距离为k，就是从链表尾到倒数第k个节点的距离，当快的指针走链表尾部，这时候慢指针是不是就是指向倒数第k个节点
 假如快指针为p1，慢指针为p2 ，p1 先沿着链表头部走到第k个位置，此时p2开始前行，每次前进一步，当p1==null时，快指针走到了链表尾部，此时p2的位置就是倒数第k个节点
 <只遍历一次的话,可以准备一个size为k的滑动窗口,遍历结束后,窗口里面最后一个元素就是答案了>
 
 p1 - p2 = k while p1 == nil now p2 = k

 */

func findKNode(_ head: LinkNode?,k: Int) -> LinkNode?{
    if k <= 0 {
        return nil
    }
    
    if head == nil || head?.next == nil {
        return head
    }
    // p2 fast
    var p1 :LinkNode = head!, p2 :LinkNode? = head
    
    //快指针先走k步
    for _ in 0..<k{
        if p2?.next != nil {
            p2 = p2?.next
        }else{
            //如果k大于链表长度，返回空
            return nil
        }
    }
    
    //快慢指针同时往后遍历
    while p2?.next != nil {
        p1 = p1.next!
        p2 = p2?.next
    }
    //    19. 删除链表的倒数第N个节点
    //    p1!.next = p1!.next!.next
    //    return head.next
    
    return p1
}


//MARK:-list20:

//offer26：树的子结构  树t是否是树s的子树
func isSubtree(_ s: TreeNode?, _ t: TreeNode?) -> Bool {
    var result = false
    if s != nil && t != nil {
        if s == t {
            result = doseTree1HavaeTree2(s, t)
        }
        if !result {
            result = isSubtree(s?.left, t)
        }
        if !result {
            result = isSubtree(s?.right, t)
        }
    }
    return result
}

private func doseTree1HavaeTree2(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
    if root2 == nil {
        return true
    }
    if root1 == nil {
        return false
    }
    if root1 != root2 {
        return false
    }
    return doseTree1HavaeTree2(root1?.left, root2?.left) &&
        doseTree1HavaeTree2(root1?.right, root2?.right)
}

//MARK:-list21:
//offer28：对称的二叉树
/*
 请实现一个函数，用来判断一棵二叉树是不是对称的。如果一棵二叉树和它的镜像一样，那么它是对称的。
 递归
 1. 定义递归函数
 2. 边界问题 递归结束条件
 3. 寻找等价关系 node1?.left, node2?.right
 */

func isSymmetry(_ root: TreeNode?) -> Bool {
    return isSymmetrys(root, root)
}

private func isSymmetrys(_ node1: TreeNode?, _ node2: TreeNode?) -> Bool {
    if node1 == nil && node2 == nil {
        return true
    }
    
    if node1 == nil || node2 == nil {
        return false
    }
    
    if node1?.val != node2?.val {
        return false
    }
    
    return isSymmetrys(node1?.left, node2?.right) &&
    isSymmetrys(node1?.right, node2?.left)
    
}

//46. 全排列 / offer38：字符串的排列
/*
 输入一个字符串，打印出该字符串中字符的所有排列。例如输入字符串abc，
 // 则打印出由字符a、b、c所能排列出来的所有字符串abc、acb、bac、bca、cab和cba。
 */
//回溯算法 https://leetcode-cn.com/problems/permutations/solution/hui-su-suan-fa-python-dai-ma-java-dai-ma-by-liweiw/

//MARK:-list22:

//offer50（一）：字符串中第一个只出现一次的字符
//解法：利用字典存储各个字符的出现次数
  func getFirstNotRepeatingChar(_ string: String) -> Character? {
      let chars = Array(string)
      var dict = [Character:Int]()
      for char in chars {
          if dict[char] == nil {
              dict[char] = 1
          } else {
              dict[char]! += 1
          }
      }
      for char in chars {
          if dict[char]! == 1 {
              return char
          }
      }
      return nil
  }


//MARK:-list23:

//offer55（一） 返回二叉树的深度
/*
   递归
 时间复杂度： 我们每个结点只访问一次，因此时间复杂度为 O(N)，
 其中 N 是结点的数量。
 空间复杂度： 在最糟糕的情况下，树是完全不平衡的，例如每个结点只剩下左子结点，递归将会被调用 N 次（树的高度），因此保持调用栈的存储将是 O(N)。但在最好的情况下（树是完全平衡的），树的高度将是 log(N)。因此，在这种情况下的空间复杂度将是 O(log(N))。
 */
func maxDepth(_ root: TreeNode?) -> Int {
    if root == nil {
        print("nil")
        return 0
    }else{
        let leftTreeDepth = maxDepth(root?.left)
        //print( "\(leftTreeDepth)")
        let rightTreeDepth = maxDepth(root?.right)
        //print( "\(leftTreeDepth)" + ":" + "\(rightTreeDepth)")
        return leftTreeDepth > rightTreeDepth ? leftTreeDepth + 1 : rightTreeDepth + 1
    }
}

let tnode7 = TreeNode(value: 7, left: nil, right: nil)
let tnode6 = TreeNode(value: 6, left: nil, right: nil)
let tnode5 = TreeNode(value: 5, left: tnode7, right: nil)
let tnode4 = TreeNode(value: 4, left: nil, right: nil)
let tnode3 = TreeNode(value: 3, left: nil, right: tnode6)
let tnode2 = TreeNode(value: 2, left: tnode4, right: tnode5)
let tnode1 = TreeNode(value: 1, left: tnode2, right: tnode3)
maxDepth(tnode1)


// offer55（二）：平衡二叉树
// 题目：输入一棵二叉树的根结点，判断该树是不是平衡二叉树。如果某二叉树中
// 任意结点的左右子树的深度相差不超过1，那么它就是一棵
/**
    递归
    解法：判断各个节点的左右子树的深度相差是否超过1
    */
   func isBalanced(_ root: TreeNode?) -> Bool {
       guard root != nil else {
           return true
       }
       let leftDepth = checkTreeDepth(root?.left)
       let rightDepth = checkTreeDepth(root?.right)
       let diff = abs(leftDepth - rightDepth)
       if diff > 1 { return false }
       return isBalanced(root?.left) && isBalanced(root?.right)
   }
   /**
    求树的深度
    */
   private func checkTreeDepth(_ node: TreeNode?) -> Int {
       guard node != nil else {
           return 0
       }
       let leftTreeDepth = checkTreeDepth(node?.left)
       let rightTreeDepth = checkTreeDepth(node?.right)
       return leftTreeDepth > rightTreeDepth ? leftTreeDepth + 1 : rightTreeDepth + 1
   }


//MARK:-list24:
// offer58（一）：翻转单词顺序
// 题目：输入一个英文句子，翻转句子中单词的顺序，但单词内字符的顺序不变。
// 为简单起见，标点符号和普通字母一样处理。例如输入字符串"I am a student. "，
// 则输出"student. a am I"。

// 也可以用 栈 的特性
func reverseStr(_ s: String) -> String{
    // 用数组 append removeLast 代替 push pop
    var stack = [String]()
    let arraySubstrings: [Substring] = s.split(separator: " ")
    // 高阶函数
    arraySubstrings.reduce("") {
        stack.append(String($1) + "  ")
        return ""
    }
    var reverStr = String()
    while stack.count > 0 {
        reverStr.append(stack.last!)
        stack.removeLast()
    }
    return reverStr
}

// offer65：不用加减乘除做加法
// 题目：写一个函数，求两个整数之和，要求在函数体内不得使用＋、－、×、÷
/* 四则运算符号。
  解法：num1^num2 = num1+num2（不考虑进位），进位计算： (num1 & num2) << 1
 */
func sum(num1 :Int, with num2 :Int) -> Int {
    var num1 = num1
    var num2 = num2
    repeat {
        let sum = num1 ^ num2
        let carry = (num1 & num2) << 1
        num1 = sum
        num2 = carry
    } while (num2 != 0);
    return num1
}


/**
 - 二叉递归先序遍历
    - 考察到一个节点后，即刻输出该节点的值，并继续遍历其左右子树。(根左右)
   先输出节点的值，再递归遍历左右子树。中序和后序的递归类似，改变根节点输出位置即可。
 */
func recursionPreTraversal(_ tree: TreeNode?){
    if tree != nil {
        print("\(tree!.val)" + " ")
        recursionPreTraversal(tree!.left)
        recursionPreTraversal(tree!.right)
    }
}
recursionPreTraversal(tnode1)

/**
- 二叉递归中序遍历
  - 考察到一个节点后，将其暂存，遍历完左子树后，再输出该节点的值，然后遍历右子树。(左根右)
过程和递归先序遍历类似
*/
func recursionMidTraversal(_ root: TreeNode?) {
    if root != nil {
        recursionMidTraversal(root?.left)
        print("\(root!.val)" + " " )
        recursionMidTraversal(root?.right)
    }
}
recursionMidTraversal(tnode1)

/**
- 二叉递归后序遍历
*/

func recursionTrailTraversal(_ root: TreeNode?) {
    
}



