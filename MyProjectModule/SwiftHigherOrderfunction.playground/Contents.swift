import UIKit
/*
 Swift中的高阶函数
 - $0、$1
    swift自动为闭包提供参数名缩写功能，可以直接通过$0和$1等来表示闭包中的第一个第二个参数，并且对应的参数类型会根据函数类型来进行判断
 使用$0、$1的话，参数类型可以自动判断，并且in关键字也可以省略，也就是只用写函数体就可以了。我们可以在闭包中使用 $ 操作符来代指遍历的每个元素。
 
 - sort
   排序
 
 - forEach
   遍历
 
 - split
   字符串分割
 
 - filter
   对给定数组的每个元素，执行闭包中的操作，将符合条件的元素放在数组中返回。可以代替for-in
 
 - map
   map函数的作用就是对集合进行一个循环，循环内部再对每个元素做同一个操作。它返回一个包含映射后元素的泛型数组。
   你可以返回包含任意类型的数组,可以代替 for-in.
 
 - flatMap
   Flatmap 用来铺平 collections 中的 collection, 可以将多维集合转成一维的
 
 - CompactMap/compactMapValues(swift5)
   对给定数组/字典的每个元素，执行闭包中的映射，将非空的映射结果放置在数组/字典中返回。
 
 - reduce
   对给定数组的每个元素，执行闭包中的操作对元素进行联合，并将合并结果返回。

 - 组合使用
   我们可以链式调用高阶函数。 不要链接太多，不然执行效率会慢
 
 
总结：
 当你需要映射一个数组，并且不需要改变返回数组的层级结构的时候，使用 map ，反之则使用 flatMap
 当返回数组中的值必须非空的时候，使用 compactMap, 当返回字典中的键值对中的value 必须为非空的时候，使用 compactMapValues
 当你需要将数组进行某种计算并返回一个值得时候，使用 reduce
 当你需要查询的时候，使用 filter
 使用函数式编程不仅能减少代码的行数，还可使用链式结构构建复杂的逻辑

 
 via: https://juejin.im/post/5cf5d8ae6fb9a07ef06f7fc9
      https://juejin.im/post/5cef4bf0f265da1bd6058822
      
 */

//MARK:- Datas

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
let flatStus = [[stu1, stu2], [stu3, stu4]]

var array: [String] = ["Animal", "Baby", "Apple", "Google", "Aunt"]
let numbers = [1,2,5,4,3,6,8,7]
let bookAmount = ["harrypotter": 100.0, "junglebook": 110.0]
let flatCodes = "abcd efd"

//MARK:- sort

// 这种默认是升序
array.sorted()
// 如果要降序
array.sort { (str1, str2) -> Bool in
    return str1 > str2
}

var sortNumbers1 = numbers.sorted(by: { (a, b) -> Bool in
    return a < b
})
print("numbers -" + "\(sortNumbers1)")

var sortNumbers2 = numbers.sorted(by: {$0 < $1})
print("numbers -" + "\(sortNumbers2)")



//MARK:- forEach

// 遍历
array.forEach( { str in
    print(str)
    
});


//MARK:- map

//Normal Array
var newArr: [String] = []
for ele in array { newArr.append(ele + " Hello") }
print(newArr)

//map Array
let newArrUsingMap = array.map { $0 + " mapHello" }
print(newArrUsingMap)
// index element
let indexAndNum = numbers.enumerated().map { (index,element) in
    return "\(index):\(element)"
}
print(indexAndNum)

//map Dictionary
let returnFormatMap = bookAmount.map { (key, value) in
    return value
}
print(returnFormatMap)



//MARK:- flatMap

/*
 map 会直接将元素放在数组中，而 flatMap 会将元素平铺在一个数组中
 */

//flatmap Array

let scoresByName = ["Henk": [0, 5, 8], "John": [2, 5, 8]]

let mapped = scoresByName.map { $0.value }
let flatMapped = scoresByName.flatMap { $0.value }

print(mapped)
print(flatMapped)

// flatmap on array of dictionaries
let arrs = [["key1": 0, "key2": 1], ["key3": 3, "key4": 4]]
let flat1 = arrs.flatMap { return $0 }
let flatModel = flatStus.flatMap{ return $0 }
//  let flatResult = viewModel.provinceList.flatMap { return $0.locations }

print(flat1) //[(key: "key2", value: 1), (key: "key1", value: 0), (key: "key3", value: 3), (key: "key4", value: 4)]
print(flatModel)

var flatmapDict = [String: Int]()

//因为在铺平之后的返回数组包含元素的类型为元组。所以我们不得不转换为字典。
flat1.forEach { (key, value) in
    flatmapDict[key] = value
}


print(flatmapDict) //["key4": 4, "key2": 1, "key1": 0, "key3": 3]

//MARK:- CompactMap/CompactMapValues
/*
 CompactMap
 - 在迭代完集合中的每个元素的映射操作后，返回一个非空的数组。

 CompactMapValues
 - 而对于 Dictionary ，CompactMap是没有任何作用的，它只会返回一个元组类型的数组。所以我们需要使用 compactMapValues 函数。(该函数在Swift5发布)
 
 */
let newCodes = flatCodes.compactMap { return $0 }
print(newCodes)

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

//MARK:- filter
// 筛选里面的闭包必须是返回Bool类型的闭包

//filter Array
array.filter { (str) -> Bool in
     str.hasPrefix("A")
    }.forEach({
        a in print(a)
    })

//filter Dictionary
let results = bookAmount.filter { (key, value) -> Bool in
    return value > 100
}
// 简化后 $0 为 key $1 为 value
let results1 = bookAmount.filter { $1 > 100 }
print(results1)


//MARK:- reduce

//reduce Array
/*
reduce 函数接受两个参数：
第一个为初始值，它用来存储初始值和每次迭代中的返回值。
另一个参数是一个闭包，闭包包含两个参数：初始值或者当前操作的结果、集合中的下一个 item 。
*/

let sumArray = [1, 2, 3, 4]
var total1 = sumArray.reduce(0) { (x, y) -> Int in
    return x + y
}
/*
 reduce 函数会迭代4次。
 1.初始值为0，x为0，y为1 -> 返回 x + y 。所以初始值或者结果变为 1。
 2.初始值或者结果变为 1，x为1，y为2 -> 返回 x + y 。所以初始值或者结果变为 3。
 3.初始值或者结果变为 3，x为3，y为3 -> 返回 x + y 。所以初始值或者结果变为 6。
 4.初始值或者结果变为 6，x为6，y为4 -> 返回 x + y 。所以初始值或者结果变为 10。
 */
print(total1)

// 简化后
let total2 = sumArray.reduce(0) { $0 + $1 }
print(total2)

//本例中，闭包的类型为 (Int,Int)->Int,所以，我们可以传递类型为 (Int,Int)->Int 的任意函数或者闭包。比如我们可以把操作符替换为 -, *, / 等
let reducedNumberSum1 = numbers.reduce(0,+) // returns 10

//我们可以在闭包里添加 * 或者其他的操作符。
let reducedNumberSum2 = numbers.reduce(0) { $0 * $1 } // reducedNumberSum is 0...
//let reducedNumberSum2 = numbers.reduce(0,*) 简化后

//reduce 也可以通过 + 操作符来合并字符串。
let codes = ["abc","def","ghi"]
let text1 = codes.reduce("") { $0 + $1} //the result is "abcdefghi"
//or
let text2 = codes.reduce("",+) //the result is "abcdefghi"


//reduce dictionary
/*
 对于字典，reduce 的闭包接受两个参数。
 1.一个应该被 reduce 的初始值或结果
 2.一个当前键值对的元组
 */

let reduce1 = bookAmount.reduce(10) { (result, tuple) in
    return result + tuple.value
}
print(reduce1) //220.0

let reduce2 = bookAmount.reduce("book are ") { (result, tuple) in
    return result + tuple.key + " "
}
//let reduce2 = bookAmount.reduce("Books are ") { $0 + $1.key + " " } //or $0 + $1.0 + " "
print(reduce2) //book are junglebook harrypotter



//MARK:- 组合使用


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
