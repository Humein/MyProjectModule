import UIKit
/*
 Swift中的高阶函数
 - sort
   排序
 
 - forEach
   遍历
 
 - filter
   对给定数组的每个元素，执行闭包中的操作，将符合条件的元素放在数组中返回。可以代替for-in
 
 - map
   对给定集合每个元素，执行闭包中的映射，将映射结果放置在数组中返回。map 函数的返回值类型总是一个泛型数组。你可以返回包含任意类型的数组
 
 - flatMap
   对给定集合的每个元素，执行闭包中的映射，对映射结果进行合并操作，然后将合并操作后的结果放置在数组中返回。
 
 - CompactMap/compactMapValues(swift5)
   对给定数组/字典的每个元素，执行闭包中的映射，将非空的映射结果放置在数组/字典中返回。
 
 - reduce
   对给定数组的每个元素，执行闭包中的操作对元素进行合并，并将合并结果返回。

 - 组合使用
 
 
总结：
 当你需要映射一个数组，并且不需要改变返回数组的层级结构的时候，使用 map ，反之则使用 flatMap
 当返回数组中的值必须非空的时候，使用 compactMap, 当返回字典中的键值对中的value 必须为非空的时候，使用 compactMapValues
 当你需要将数组进行某种计算并返回一个值得时候，使用 reduce
 当你需要查询的时候，使用 filter
 使用函数式编程不仅能减少代码的行数，还可使用链式结构构建复杂的逻辑。（不要链接太多，不然执行效率会慢）

 
 via: https://juejin.im/post/5cf5d8ae6fb9a07ef06f7fc9
      https://juejin.im/post/5cef4bf0f265da1bd6058822
      
 */


//MARK:- sort

var array: [String] = ["Animal", "Baby", "Apple", "Google", "Aunt"]
// 这种默认是升序
array.sorted()
// 如果要降序
array.sort { (str1, str2) -> Bool in
    return str1 > str2
}

//MARK:- forEach

// 遍历
array.forEach( { str in
    print(str)
    
});


//MARK:- filter

// 筛选 筛选里面的闭包必须是返回Bool类型的闭包

array.filter { (str) -> Bool in
     str.hasPrefix("A")
    }.forEach({
        a in print(a)
    })


let bookAmount = ["harrypotter": 100.0, "junglebook": 1000.0]
let results = bookAmount.filter { (key, value) -> Bool in
    return value > 100
}

// 简化后 $0 为 key $1 为 value
let results1 = bookAmount.filter { $1 > 100 }
print(results1)



//MARK:- map

// 闭包返回一个变换后的元素，接着将所有这些变换后的元素组成一个新的数组
let a = array.map { (ele) -> String in
    return ele + " Hello"
}
print(a)

// key
let bookAmount = ["harrypotter": 100.0, "junglebook": 100.0]
let returnFormatMap = bookAmount.map { (key, value) in
    return key.capitalized
}
print(returnFormatMap)

// index
let numbers = [1, 2, 4, 5]
let indexAndNum = numbers.enumerated().map { (index,element) in
    return "\(index):\(element)"
}
print(indexAndNum)

/*
 * $0、$1的实际含义
 swift自动为闭包提供参数名缩写功能，可以直接通过$0和$1等来表示闭包中的第一个第二个参数，并且对应的参数类型会根据函数类型来进行判断
 使用$0、$1的话，参数类型可以自动判断，并且in关键字也可以省略，也就是只用写函数体就可以了。
 */
let numbers = [1,2,5,4,3,6,8,7]

sortNumbers = numbers.sorted(by: { (a, b) -> Bool in
    return a < b
})
print("numbers -" + "\(sortNumbers)")

var sortNumbers = numbers.sorted(by: {$0 < $1})
print("numbers -" + "\(sortNumbers)")

let b = array.map{
      $0 + " Hello"
}
print(b)


//MARK:- flatMap

/*
 map 会直接将元素放在数组中，而 flatMap 会将元素平铺在一个数组中
 */
let scoresByName = ["Henk": [0, 5, 8], "John": [2, 5, 8]]

let mapped = scoresByName.map { $0.value }
let flatMapped = scoresByName.flatMap { $0.value }

print(mapped)
print(flatMapped)


//MARK:- CompactMap/CompactMapValues(swift5)
/*
 CompactMap
 - 在迭代完集合中的每个元素的映射操作后，返回一个非空的数组。

 CompactMapValues
 - 而对于 Dictionary ，CompactMap是没有任何作用的，它只会返回一个元组类型的数组。所以我们需要使用 compactMapValues 函数。(该函数在Swift5发布)
 
 */
let arr = ["1", nil, "3", "4", nil,"5"]
let result = arr.compactMap{ $0 }
let intIds = arr.compactMap { (any) in
    Int(any ?? "")
}
print(result)

let dict = ["key1": nil, "key2": 20]
let result1 = dict.compactMap{ $0 }
print(result1)

let result2 = dict.compactMapValues{ $0 }
print(result2)

let dics: [String : String] = [
    "first": "1",
    "second": "2",
    "three": "3",
    "four": "4",
    "five": "abc"
]
//  并且可以自动过滤不符合条件的键值对
let newDic = dics.compactMapValues({ Int($0) })
print(newDic)


//MARK:- reduce
/*
 map和filter方法都是通过一个已存在的数组，生成一个新的、经过修改的数组。然而有时候我们需要把所有元素的值合并成一个新的值
 reduce 函数第一个参数是返回值的初始化值 result是中间结果 num是遍历集合每次传进来的值
 */

var sum: [Int] = [11, 22, 33, 44]

var total = sum.reduce(0) { (result, num) -> Int in
    return result + num
}

print(total)

//MARK:- 组合使用
struct Student {
    let id: String
    let name: String
    let age: Int
}

let stu1 = Student(id: "1001", name: "stu1", age: 12)
let stu2 = Student(id: "1002", name: "stu2", age: 14)
let stu3 = Student(id: "1003", name: "stu3", age: 16)
let stu4 = Student(id: "1004", name: "stu4", age: 20)
let stus = [stu1, stu2, stu3, stu4]


array.map( { (str) -> String in
    "Hello " + str
}).forEach({
    str in print(str)
})


//将 String 类型映射为 Int 类型，并查找id大于1002的所有学生
let adults = stus.compactMap { (stu) in
    Int(stu.id)
    }.filter { (id) -> Bool in
        id > 1002
}

print(adults)

// 计算年龄大于12的所有学生年龄总和
let totalAge = stus.filter { (stu) -> Bool in
    stu.age > 12
    }.reduce(0) { (result, stu) in
        return result + stu.age
}

print(totalAge)
