import UIKit
var str = "Hello, playground"

// 给一个数组，要求写一个函数，交换数组中的两个元素
func swaps<T>(_ nums: inout [T], _ p: Int, _ q: Int) {
//    let temp = nums[p]
//    nums[p] = nums[q]
//    nums[q] = temp
    (nums[p], nums[q]) = (nums[q], nums[p])

}
var array = [0,1]

swaps(&array, 0, 1)

print(array)


