import UIKit
/*
 Swift中的高阶函数
 - 小技巧
 
 - 枚举
   swift 中的枚举有很强大的功能：
   可以指定枚举类型，int，string，甚至是 class 类型（需要通过 String 遵守协议转换）
   枚举可以嵌套使用，这在定义宏往往很有用
   枚举可以关联值，也就是可以带参数，所以有广泛使用的 github.com/Moya 库的出现
   枚举可以添加方法和属性，包含静态方法，可变方法（能够改变self）
   因为枚举可以添加方法和属性，所有枚举甚至可以遵守协议，这又给了枚举以无限可能
   swift 的这些特性，enum 的使用范围会非常广：
 带参枚举，方法属性，可选值，类型匹配，范围匹配，遍历匹配，Api 规法化，宏定义，类簇，模型解析…
 
 
 - $0、$1
    swift自动为闭包提供参数名缩写功能，可以直接通过$0和$1等来表示闭包中的第一个第二个参数，并且对应的参数类型会根据函数类型来进行判断
 使用$0、$1的话，参数类型可以自动判断，并且in关键字也可以省略，也就是只用写函数体就可以了。我们可以在闭包中使用 $ 操作符来代指遍历的每个元素。
 
 - sort
   排序
 
 - forEach
   遍历
 
 - 处理异常
 
 - 值类型 引用类型 结构体/类选择
   - 值类型：
   结构体
   枚举
   元组（tuple）
   基本类型（Int，Double，Bool等）
   集合(Array, String, Dictionary, Set
 
   - 引用类型：
   最常用的就是类和闭包
 
值类型，存放在栈区；引用类型，存放在堆区。但是有些值类型，如字符串或数组，会间接地将项保存在堆中。所以它们是由引用类型支持的值类型
 
 类和结构体的选择：

 该数据结构的主要目的是用来封装少量相关简单数据值；
 有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用；
 该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用；
 该数据结构不需要去继承另一个既有类型的属性或者行为。
  当有上面的一种情况或多种情况请选择结构体，结构体比类更简单，也就是更轻便

 
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
      https://poos.github.io/2019/06/13/SwiftEnum/
      https://www.jianshu.com/p/9c7a07163e5b
      
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
var stus = [stu1, stu2, stu3, stu4]
let flatStus = [[stu1, stu2], [stu3, stu4]]

var array: [String] = ["Animal", "Baby", "Apple", "Google", "Aunt"]
var numbers = [1,2,5,4,3,6,8,7]
let bookAmount = ["harrypotter": 100.0, "junglebook": 110.0]
let flatCodes = "abcd efd"


//MARK:- 小技巧
//给集合中元素是字符串的类型增加一个扩展方法，应该怎么声明
extension Array where Element == String { }


// 一个函数的参数类型只要是数字（Int、Float）都可以，要怎么表示 泛型
do {
    
    func myMethod<T>(_ value: T) where T: Numeric {
        print(value + 1)
    }
}

// switch
do{
    // 对区间进行判断
    let score = 90
    switch score {
    case 0:
        print("You got an egg!")
    case 1..<60:
        print("Sorry, you failed.")
    default: break
    }
    
    // where
    let courseName2 = "如何学习Swift"
    switch courseName2 {
    case let str where str.hasSuffix("Swift"):
        print("课程<\(courseName2)>是介绍Swift的课程")
    default:
        print("<\(courseName2)>是其他课程")
    }
    
}

// 随机数
do {
    // 我们平常的随机数
    let  NwNumber1 = arc4random()
    print(NwNumber1)
    // 0 ~ X 之间的随机数
    let NwNumber2 = arc4random() % 10
    print(NwNumber2)
    // 获取某个 X ~ N 之间的随机数的公式: Y = arc4random() % (N - X) + X
    let NwNumber3 = arc4random() % (10 - 5) + 5
    print(NwNumber3)

    /**
     srand48 和 drand48 是两个库函数。
     srand48 的作用是初始化 drand48 函数
     drand48 函数是生成 [0,1]之间均匀分布的随机数
     
     */
    srand48(2)
    let NwS = drand48()
    print(NwS)

    // 产生某个区间的随机数
    let NwSNumber = drand48() + 2
    print(NwSNumber)
}


//defer ： 在当前作用域执行完后再执行defer中的代码
do {
    /*
     get方法中执行顺序为：
     1.lock.lock()
     2.return requests[task.taskIdentifier]
     3.defer { lock.unlock() }

    get {
        lock.lock() ; defer { lock.unlock() }
        return requests[task.taskIdentifier]
    }
     */
}


// 日期的计算
do {
    /*
    //两个日期的间隔秒数
    date1!.timeIntervalSince(date22!)

    //比较两个日期的天数
    let between = userCalendar.dateComponents([.year], from: date1!, to: date22!)
    between.year

    //在date1的基础上，增加90天
    userCalendar.date(byAdding: .day, value: 90, to: date1!)

    //在date1基础上，增加日期组件后的date
    var com = DateComponents()
    com.hour = 4
    com.minute = 4
    userCalendar.date(byAdding: com, to: date1!)
    */
}

//MARK:- 枚举
/// JSBridge与原生交互 定义的字段 枚举
enum WBActivityType: String{
    case AdultExam_UpLoadImage = "JSBridge"
    case AddressBook_UpLoadData, Normal_Action = "doAction"
    
}

enum Movement:Int {
    case left = 0
    case right = 1
    case top = 2
    case bottom = 3
}
enum Area: String {
    case DG = "dongguan"
    case GZ = "guangzhou"
    case SZ = "shenzhen"
}
enum DataError: Error {
    case outOfStack
    case NoData
}
///嵌套枚举
enum AreaNest {
    enum DongGuan {
        case NanCheng
        case DongCheng
    }
    
    enum GuangZhou {
        case TianHe
        case CheBei
    }
}
print(AreaNest.DongGuan.DongCheng)

///关联值 就是枚举的case可以传值
enum Trade {
    case Buy(stock:String,amount:Int)
    case Sell(stock:String,amount:Int)
}

let trade = Trade.Buy(stock: "003100", amount: 100)

switch trade {
case .Buy(let stock,let amount):
    
    print("stock:\(stock),amount:\(amount)")
    
case .Sell(let stock,let amount):
    print("stock:\(stock),amount:\(amount)")
default:
    ()
}

/**方法和属性
 我们定义了一个设备枚举，有iPad, iPhone, AppleTV, AppleWatch，还有一个介绍的方法。这里的introduced方法，你可以认为枚举是一个类，
 是一个成员方法，Device.iPhone就是一个Device的实例，case们是他的属性
*/
enum Device {
    case iPad, iPhone, AppleTV, AppleWatch
    func introduced() -> String {
        
        switch self {
        case .iPad: return "iPad"
        case .iPhone: return "iPhone"
        case .AppleWatch: return "AppleWatch"
        case .AppleTV: return "AppleTV"
        }
    }
}

print(Device.iPhone.introduced())

/// 协议
protocol CustomStringConvertible {
  var description: String { get }
}

enum Trades :CustomStringConvertible{
    case Buy(stock:String,amount:Int)
    case Sell(stock:String,amount:Int)
    
    var description: String {
        
        switch self {
        case .Buy(_, _):
            return "Buy"
            
        case .Sell(_, _):
            return "Sell"
        }
    }
}

print(Trades.Buy(stock: "003100", amount: 100).description)


/**扩展
 枚举也可以进行扩展。最明显的用例就是将枚举的case和method分离，这样阅读你的代码能够简单快速地消化掉enum内容，紧接着转移到方法定
 */
enum Devices {
    case iPad, iPhone, AppleTV, AppleWatch
    
}
extension Devices: CustomStringConvertible{
    
    func introduced() -> String {
        
        switch self {
        case .iPad: return "iPad"
        case .iPhone: return "iPhone"
        case .AppleWatch: return "AppleWatch"
        case .AppleTV: return "AppleTV"
        }
    }
 
    var description: String {
        
        switch self {
        case .iPad: return "iPad"
        case .iPhone: return "iPhone"
        case .AppleWatch: return "AppleWatch"
        case .AppleTV: return "AppleTV"
        }
    }
}

print(Devices.AppleTV.description)
print(Devices.iPhone.introduced())

/**递归枚举
 递归枚举是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加上indirect来表示该成员可递归。
*/
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

/**
需求是展现一个个页面情景，根据不同的选择，产出最终产出结果，有点像情景交互游戏：
利用枚举实现类簇，保证项目风格，且容易调试：
*/

enum CView {
    case back
    case black
    case eye(position: CGPoint)
    case ground(image: String)
    case button(position: CGPoint, size: CGSize)

    var node: UIView? {
        switch self {
        case .back:
            let back = UIView.init(frame: CGRect.zero)
            //...
            return back
        case .ground(let image):
            //...
            return nil
        case .button(let position, let size):
            //...
            return nil
        case .black:
            //...
            return nil
        case .eye(let position):
            //...
            return nil
        }
    }
}




//MARK:- sort

// 这种默认是升序
array.sorted()

//降序
var sortNumbers1 = numbers.sorted(by: { (a, b) -> Bool in
    return a > b
})
print("numbers -" + "\(sortNumbers1)")

var sortNumbers2 = numbers.sorted(by: {$0 < $1})
print("numbers -" + "\(sortNumbers2)")

// 排序一个自定义对象的数组根据对象的某个属性, 升序
let sortNumbers3 = stus.sort { $0.age < $1.age }


//MARK:- forEach

// 遍历
/*
 在使用return关键字时，for in中是当符合当前执行语句时，程序直接终止到此并返回,而forEach中是当符合当前执行语句时，程序跳过本次判断继续执行
 在使用continue关键字时 for in可以正常遍历并且执行，而且 continue的作用是跳出本次循环，不影响后面的执行 而forEach中，swift是不允许这样执行的
 在break关键字中，对于for in来说是可以的，跳出本层循环，也就是for循环，然后继续执行后面的程序； 对于forEach来说，同continue关键字的效果一样，swift不允许这样使用
 一般情况下，两者都可通用，都方便、敏捷
 */
array.forEach( { str in
    print(str)
    
});

//for-in
for index in 0...6 {
}
for index in 0..<6 {
}
for element in numbers {
}
for (key, value) in bookAmount {
}
for index in stride(from: 0, to: array.count, by: 1) {
}
for (idx,item) in numbers.enumerated().reversed(){
}

//MARK:- 处理异常
/*
 捕获异常（catch）
 */

do {
    let result = ["":""]
    try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
    // 没有错误消息抛出
} catch {
    // 有一个错误消息抛出
}

/*
 try?会将错误转换为可选值，当调用try?＋函数或方法语句时候，如果函数或方法抛出错误，程序不会发崩溃，而返回一个nil，如果没有抛出错误则返回可选值。

 */
func findAll(_ stu :Student) throws -> Student {
    guard stu.age > 100 else {
        // 抛出"没有数据"错误。
        throw DataError.NoData
    }
    return stu
}
let st  = try? findAll(stu1)

/*
 使用try!可以打破错误传播链条。错误抛出后传播给它的调用者，这样就形成了一个传播链条，但有的时候确实不想让错误传播下去，可以使用try!语句。
 try!打破了错误传播链条，但是如果真的发生错误就出现运行期错误，导致程序的崩溃。 所以使用try!打破错误传播链条时，应该确保程序不会发生错误
 */
#if DEBUG
let printData: Data = try! JSONSerialization.data(withJSONObject: result ?? KeyValue(), options: .prettyPrinted)
print("\(response?.url?.absoluteString ?? "")" + "\n")
print(String.init(data: printData, encoding: .utf8) ?? "")
#else
#endif


//MARK:- 值类型 引用类型 结构体/类选择
var mutableArray = [1,2,3]
for _ in mutableArray {
    mutableArray.removeLast()
}
print(mutableArray) // 对比OC 不会崩溃了



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
