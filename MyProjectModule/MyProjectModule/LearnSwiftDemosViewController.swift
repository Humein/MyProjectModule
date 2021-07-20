//
//  LearnSwiftDemosViewController.swift
//  MyProjectModule
//  https://www.cnswift.org/a-swift-tour
//  Created by Zhang Xin Xin on 2019/5/10.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit

class LearnSwiftDemosViewController: UIViewController {
    //MARK: - 惰性初始化
    
    private lazy var textBtn: UIButton = UIButton()
    
    //    第一种，简单表达式
    lazy var first = NSArray(objects: "1","2")
    //    第二种，闭包
    lazy var second: String = { return "second" }()
    
    override func viewDidLoad(){}

    override func viewWillAppear(_ animated: Bool) {}
    
    //MARK:- 泛型

    //协议
    //@objc public weak var presenterDelegate: ViewPresensterProtocol?
    //// 范型
    //lazy var model:[NSObject] = [NSObject]()
    //
    //lazy var modelProtocol:[ViewPresensterProtocol] = [ViewPresensterProtocol]()


    //把名字写在尖括号里来创建一个泛型方法或者类型。

    func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
        _ = second.jt.testMethod
        var result = [Item]()
        
        for _ in 0..<numberOfTimes {
            result.append(item)
        }
        
        return result
    }

    //你可以从函数和方法同时还有类，枚举以及结构体创建泛型。
     enum OptionalValue<Wrapped> {
        case none
        case some(Wrapped)
    }

    //MARK:- 元组
    func learn1() {
         //元组 把多个值合并成单一的复合型的值。元组内的值可以是任何类型，而且可以不必是同一类型。
         let http404Error = (404, "Not Found")
         let (statusCode, statusMessage) = http404Error
         print("The status message is \(statusMessage)")
         print("The status code is \(statusCode)")

         //当你分解元组的时候，如果只需要使用其中的一部分数据，不需要的数据可以用下滑线（ _ ）代替：
         let (justTheStatusCode, _) = http404Error
         print("The status code is \(justTheStatusCode)")
         print("The status code is \(http404Error.1)")
        
         var serverResponseCode: Int? = 404
         // serverResponseCode contains an actual Int value of 404
         serverResponseCode = nil
         // serverResponseCode now contains no value
    }
    
    //使用元组来创建复合值——  比如，为了从函数中返回多个值。元组中的元素可以通过名字或者数字调用。
    func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
        var min = scores[0]
        var max = scores[0]
        var sum = 0
        
        for score in scores {
            if score > max {
                max = score
            } else if score < min {
                min = score
            }
            sum += score
        }
        
        return (min, max, sum)
    }
    
    
    
    
    //MARK:- 字符串
    func learn2() {
        let label = "The width is "
        let width = 94
        let widthLabel = label + String(width)
        print("=======" + widthLabel)
        let apples = 3
        let oranges = 5
        let appleSummary = "I have \(apples) apples."
        let fruitSummary = "I have \(apples + oranges) pieces of fruit."
        print("=======" + fruitSummary + appleSummary)
    }
    
    //MARK:- 数组 字典等容器
    func learn3() {
        // 使用方括号[] 来创建数组或者字典，并且使用方括号来按照序号或者键访问它们的元素。
        var shoppingList = ["catfish", "water", "tulips", "blue paint"]
        shoppingList[1] = "bottle of water"
        var occupations = [
            "Malcolm": "Captain",
            "Kaylee": "Mechanic",
            ]
        occupations["Jayne"] = "Public Relations"
        
        //使用初始化器语法来创建一个空的数组或者字典。
        let emptyArray = [String]()
        let emptyDictionary = [String: Float]()
        
        //        你可以使用 for-in来遍历字典中的项目，这需要提供一对变量名来储存键值对。字典使用无序集合，所以键值的遍历也是无序的。
        let interestingNumbers = [
            "Prime": [2, 3, 5, 7, 11, 13],
            "Fibonacci": [1, 1, 2, 3, 5, 8],
            "Square": [1, 4, 9, 16, 25],
            ]
        var largest = 0
        for (kind, numbers) in interestingNumbers {
            for number in numbers {
                if number > largest {
                    largest = number
                }
            }
        }
        
        //  使用 ..<来创造一个序列区间：
        //  ..<来创建一个不包含最大值的区间，使用 ... 来创造一个包含最大值和最小值的区间。
        var total = 0
        for i in 0..<4 {
            total += i
        }
        print(total)
    }
    
    func collectConatin() -> () {
        var teamArray = Array<Float>()
    
        let someInts = [Int]()
        
        let sameInts = [Int]()
        
        var shoppingList: [String] = ["Eggs", "Milk"]
        
        // 数组内部多类型
        let  arr :[(index :Int, value :String)] = [(1,"2"),(2,"3")]
        for (index , value) in arr {
            print(index,value)
        }
        print(arr)

        var dic = [ Int: Int]()
        let l = 0
        let r = 0
        let m = dic[l-r]
    //    if (info.keys.contains("postMasterId")) {

        // 字符串和数字之间的转换
    //    let str = "3"
    //    let num = Int(str)
    //    let number = 3
    //    let string = String(num)
    //
    //    // 字符串长度
    //    let len = str.count
    //
    //    // 访问字符串中的单个字符，时间复杂度为O(1)
    //    let char = str[str.index(str.startIndex, offsetBy: n)]
    //
    //    // 修改字符串
    //    str.remove(at: n)
    //    str.append("c")
    //    str += "hello world"
        
        // 检测字符串是否是由数字构成
        func isStrNum(str: String) -> Bool {
            return Int(str) != nil
        }
        
        // 将字符串按字母排序(不考虑大小写)
        func sortStr(str: String) -> String {
            return String(str.sorted())
        }
        

        var sixDoubles = sameInts + someInts

        print("someInts is of type [Int] with \(someInts.count) items.")

        for item in sixDoubles {
            print(item)
        }
        
        for (index, value) in sixDoubles.enumerated() {
            
            print("Item \(index + 1): \(value)")
        }
        
        var letters = Set<NSString>()
        
        print("letters is of type Set<Character> with \(letters.count) items.")

        letters.insert("Jazz")
        letters.contains("Funk")
        
        
        var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]

    //    Swift 的 Set类型是无序的。要以特定的顺序遍历合集的值，使用 sorted()方法，它把合集的元素作为使用 < 运算符排序了的数组返回。
        for genre in favoriteGenres.sorted() {
            print("\(genre)")
        }

        var namesOfIntegers = [Int: String]()

        namesOfIntegers[16] = "sixteen"

        namesOfIntegers = [:]

        
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        var airportsB = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

        
        airports["LHR"] = "London Heathrow"


        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        
        for (airportCode, airportName) in airports {
            print("\(airportCode): \(airportName)")
        }
        
        
        
    }
    
    //MARK:- 类型转换
    func learn4() {
        let three = 3
        let pointOneFourOneFiveNine = 0.14159
        let pi = Double(three) + pointOneFourOneFiveNine
        
        //类型别名
        typealias AudioSample = UInt16
        var maxAmplitudeFound = AudioSample.min
        
    }
    
    //MARK:- 解包 可选
    func learn5() {
        //        https://www.jianshu.com/p/89a2afb82488
                var surveyAnswer: String?
                // surveyAnswer is automatically set to nil
        //        Swift 中的 nil 和Objective-C 中的 nil 不同，在 Objective-C 中 nil 是一个指向不存在对象的指针。在 Swift中， nil 不是指针，他是值缺失的一种特殊类型，任何类型的可选项都可以设置成 nil 而不仅仅是对象类型。
        //        一旦你确定可选中包含值，你可以在可选的名字后面加一个感叹号 （ ! ） 来获取值，感叹号的意思就是说“我知道这个可选项里边有值，展开吧。”这就是所谓的可选值的强制展开。
                        
                 let possibleNumber = "123e"
                 let convertedNumber = Int(possibleNumber)
                 if convertedNumber != nil {
                    print("convertedNumber has an integer value of \(convertedNumber!).")
                }
                
                
                /*
                  不带有?或者!为普通类型
                  要么在声明的时候赋初始值，要么在其所属类的初始化方法中赋初始值，才能参与运算
                  这种类型没有默认初始值，且生命周期中不能接收nil
                  
                  后面带有?或者!为可选类型(optional type，即可选项)
                  声明为Optional常量时如果没有赋初始值，此常量没有默认值，需要在构造函数中给常量设置初始数值
                  声明为Optional的变量，如果不显式的赋值就会有个默认值nil
                  
                  声明为Optional的变量/常量不能直接参与运算，必须解包后才能参与运算
                  解包后的Optional变量/常量如果没有值(为nil)参与运算也会发生Crash
                  
                  我们可以对一个可选项类型(Optional Type)使用后缀操作符!来强制拆包(force unwrap)访问这个值，来继续后面的操作。
                  可选类型类似于Objective-C中指针的nil值，但是nil只对类(class)有用，而swift中可选类型对所有的类型都可用，并且更安全。
                  
                  */
                 
                 var optionalString: String? = "Hello"
                 
                 print(optionalString == nil)
                 
                 var optionalName: String? = "John Appleseed"
                 
                 var greeting = "Hello!"
                 
                 if let name = optionalName {
                     greeting = "Hello, \(name)"
                 }
                 
                 // 另一种处理可选值的方法是使用 ?? 运算符提供默认值。如果可选值丢失，默认值就会使用。
                 
                 let nickName: String? = nil
                 let fullName: String = "John Appleseed"
                 let informalGreeting = "Hi \(nickName ?? fullName)"
                 
    }
    
    //MARK:- 条件控制流
    func learn6() {
        //使用 if和 switch来做逻辑判断，使用 for-in， for， while，以及 repeat-while来做循环。使用圆括号把条件或者循环变量括起来不再是强制的了，不过仍旧需要使用花括号来括住代码块。
        
        let individualScores = [75, 43, 103, 87, 12]
        var teamScore = 0
        for score in individualScores {
            if score > 50 {
                teamScore += 3
            } else {
                teamScore += 1
            }
        }
        
        //        在一个 if语句当中，条件必须是布尔表达式——这意味着比如说 if score {...}将会报错，不再隐式地与零做计算了。
        //        你可以一起使用 if和 let来操作那些可能会丢失的值。这些值使用可选项表示。可选的值包括了一个值或者一个 nil来表示值不存在。在一个值的类型后边使用问号（ ?）来把某个值标记为可选的。
        
        //      switch  它不再限制于整型和测试相等上。
        let vegetable = "red pepper"
        switch vegetable {
        case "celery":
            print("Add some raisins and make ants on a log.")
        case "cucumber", "watercress":
            print("That would make a good tea sandwich.")
        case let x where x.hasSuffix("pepper"):
            print("Is it a spicy \(x)?")
        default:
            print("Everything tastes good in soup.")
        }
        

        //使用 while来重复代码快直到条件改变。循环的条件可以放在末尾，这样可以保证循环至少运行了一次。
        var n = 2
        while n < 100 {
            n = n * 2
        }
        print(n)
        
        var m = 2
        repeat {
            m = m * 2
        } while m < 100
        print(m)
    }
    
    //MARK:- 函数

    //默认情况下，函数使用他们的形式参数名来作为实际参数标签。在形式参数前可以写自定义的实际参数标签，或者使用 _ 来避免使用实际参数标签。
    func greet1(_ person: String, on day: String) -> String {
        
        return "Hello \(person), today is \(day)."
    }
    
    //函数同样可以接受多个参数，然后把它们存放进数组当中。
    func sumOf(numbers: Int...) -> Int {
        var sum = 0
        for number in numbers {
            sum += number
        }
        return sum
    }

    // 函数可以内嵌。内嵌的函数可以访问外部函数里的变量。你可以通过使用内嵌函数来组织代码，以避免某个函数太长或者太过复杂。
    
    func returnFifteen() -> Int {
        var y = 10
        func add(){
            y += 5
        }
        add()
        return y
    }

    
    //函数是一等类型，这意味着函数可以把函数作为值来返回。
    
    func makeIncrementer() -> ((Int) -> Int) {
        func addOne(number: Int) -> Int {
            return 1 + number
        }
        return addOne
    }

    //函数也可以把另外一个函数作为其自身的参数。
    func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
        for item in list {
            if condition(item){
                return true
            }
        }
        return false
    }
    
    //MARK:- 闭包
    /*https://www.cnswift.org/closures

    全局和内嵌函数，实际上是特殊的闭包。闭包符合如下三种形式中的一种：
     全局函数是一个有名字但不会捕获任何值的闭包；
     内嵌函数是一个有名字且能从其上层函数捕获值的闭包；
     闭包表达式是一个轻量级语法所写的可以捕获其上下文中常量或变量值的没有名字的闭包。
     
/ -闭包表达式语法能够使用常量形式参数、变量形式参数和输入输出形式参数，但不能提供默认值。可变形式参数也能使用，但需要在形式参数列表的最后面使用。
     -   ‘元组’也可被用来作为形式参数和返回类型。
     -   闭包的中会用到一个关键字in，in 可以看做是一个分割符，他把该闭包的类型和闭包的函数体分开，in前面是该闭包的类型，in后面是具体闭包调用时保存的需要执行的代码。表示该闭包的形式参数类型和返回类型定义已经完成，并且闭包的函数体即将开始执行。

     
     闭包表达式语法有如下的一般形式：
     { (parameters/接收的参数) -> (return type/闭包返回值类型) in
             statements/保存在闭包中需要执行的代码
     }
     
     闭包根据你的需求是有类型的，闭包的类型 一般形式如下:
     (parameters/接收的参数) -> (return type/闭包返回值类型)
     利用typealias为闭包类型定义别名
     typealias <type name> = <type expression>
    */
    public typealias successBlk = (Any)->()
    public typealias failureBlk = (NSError)->()
    //为没有参数也没有返回值的闭包类型起一个别名
    typealias Nothing = () -> ()
    //为接受一个Int类型的参数不返回任何值的闭包类型
    typealias PrintNumber = (Int) -> ()
    //为接受两个Int类型的参数并且返回一个Int类型的值的闭包类型 定义一个别名：Adds
    typealias Adds = (Int, Int) -> (Int)
    
    /// 闭包作为属性
    // 传参数
    var buttonClick: successBlk?
    // 用于传参数和回调
    public typealias SDPublicBaseParamValueClosure = (_ value: Any? ) -> Any?
    var cellClickClosure: SDPublicBaseParamValueClosure?
    
    
    
    func learn7() {
        // 调用闭包
        self.buttonClick?(0)
        // 实现闭包
        self.buttonClick = {[weak self] (Any) -> ()in
            guard let self = self else {return}
        }
        
        // 调用闭包并接受返回值
        let result = addClose(1, 2)
        if cellClickClosure != nil{
            if let value = cellClickClosure!(0) as? Bool,value == false{
//                checkBtn.isSelected = !checkBtn.isSelected
            }
        }
        
        // 返回元组类型 场景： 多参数 合并为 元组，便于闭包的抽离和外面使用
        let results: Any?  = ""
        let error: Int?  = 0
        self.buttonClick?((results,error)) // nil 不支持
        self.buttonClick = {(args: (Any, Int)) -> () in
            _ = args.0
            _ = args.1
            } as? LearnSwiftDemosViewController.successBlk
    }
    
    typealias Add = (_ num1: Int, _ num2: Int) -> (Int)
    // 闭包作为方法 为闭包赋值
    let addClose: Add = {
        (_ num1: Int, _ num2: Int) -> (Int) in
        return num1 + num2
    }
    
    // 闭包作为返回值
    
    // 闭包作为参数
    func getExerciseData(callingViewController: NSObject, successBlock: successBlk, andFailure failureBlock: (NSError?) -> ()){}
    func getRequestData(urlString: String,paras: Dictionary<String,Any>?,resultBlock: ((_ result:Any?,_ error:Any?) -> Void)?) { }
   
}

    //MARK:- 对象和类

//    通过在 class后接类名称来创建一个类。在类里边声明属性与声明常量或者变量的方法是相同的，唯一的区别的它们在类环境下。同样的，方法和函数的声明也是相同的写法。

class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

//这个 Shape类的版本缺失了一些重要的东西：一个用在创建实例的时候来设置类的初始化器。使用 init来创建一个初始化器。

class NameShape {
    var numberOfSides: Int = 0
    var name: String
    
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        
        return "A shape with \(numberOfSides) sides."
    }
    
    
}


//声明子类就在它名字后面跟上父类的名字，用冒号分隔。创建类不需要从什么标准根类来继承，所以你可以按需包含或者去掉父类声明。
//
//子类的方法如果要重写父类的实现，则需要使用 override——不使用 override关键字来标记则会导致编译器报错。编译器同样也会检测使用 override的方法是否存在于父类当中。


class Square: NameShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }

}



//    除了存储属性，你也可以拥有带有 getter 和 setter 的计算属性。

class EquilateralTriangle: NameShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}


//在 perimeter的 setter 中，新值被隐式地命名为 newValue。你可以提供一个显式的名字放在 set 后边的圆括号里。
//
//注意 EquilateralTriangle类的初始化器有三个不同的步骤：
//
//设定子类声明的属性的值；
//调用父类的初始化器；
//改变父类定义的属性中的值，以及其他任何使用方法，getter 或者 setter 等需要在这时候完成的内容。
//如果你不需要计算属性但仍然需要在设置一个新值的前后执行代码，使用 willSet和 didSet。比如说，下面的类确保三角形的边长始终和正方形的边长相同。


class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
        
        //当你操作可选项的值的时候，你可以在可选项前边使用 ?比如方法，属性和下标脚本。如果 ?前的值是 nil，那 ?后的所有内容都会被忽略并且整个表达式的值都是 nil。否则，可选项的值将被展开，然后 ?后边的代码根据展开的值执行。在这两种情况当中，表达式的值是一个可选的值。
        
        let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
        let sideLength = optionalSquare?.sideLength
        
    }

}



//MARK:- 枚举和结构体
//使用 enum来创建枚举，类似于类和其他所有的命名类型，枚举也能够包含方法。
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

// 枚举成员的值是实际的值，不是原始值的另一种写法。事实上，在这种情况下没有一个有意义的原始值，你根本没有必要提供一个。


enum Suit {
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}


//注意有两种方法可以调用枚举的 hearts成员：当给 hearts指定一个常量时，枚举成员 Suit.hearts会被以全名的方式调用因为常量并没有显式地指定类型。在 Switch 语句当中，枚举成员可以通过缩写的方式 .hearts被调用，因为 self已经明确了是 suit。你可以在任何值的类型已经明确的场景下使用使用缩写。
//
//如果枚举拥有原始值，这些值在声明时确定，就是说每一个这个枚举的实例都将拥有相同的原始值。另一个选择是让case与值关联——这些值在你初始化实例的时候确定，这样它们就可以在每个实例中不同了。比如说，考虑在服务器上请求日出和日落时间的case，服务器要么返回请求的信息，要么返回错误信息。
enum ServerResponse {
    case result(String, String)
    case failure(String)
}


//
//注意现在日出和日落时间是从 ServerResponse 值中以switch case 匹配的形式取出的。
//
//使用 struct来创建结构体。结构体提供很多类似与类的行为，包括方法和初始化器。
//其中最重要的一点区别就是结构体总是会在传递的时候拷贝其自身，而类则会传递引用。

struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}


//MARK:- 协议和扩展

//使用 protocol来声明协议。
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}


//类，枚举以及结构体都兼容协议。

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}


struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}

//注意使用 mutating关键字来声明在 SimpleStructure中使方法可以修改结构体。在 SimpleClass中则不需要这样声明，因为类里的方法总是可以修改其自身属性的。
//

//使用 extension来给现存的类型增加功能，比如说新的方法和计算属性。你可以使用扩展来使协议来别处定义的类型，或者你导入的其他库或框架。

extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}


//你可以使用协议名称就像其他命名类型一样——比如说，创建一个拥有不同类型但是都遵循同一个协议的对象的集合。当你操作类型是协议类型的值的时候，协议外定义的方法是不可用的。

//as! 转译类型  向下转型（Downcasting）时使用。由于是强制类型转换，如果转换失败会报 runtime 运行错误。  as? 和 as! 操作符的转换规则完全一样。但 as? 如果转换不成功的时候便会返回一个 nil 对象。成功的话返回可选类型值。由于 as? 在转换失败的时候也不会出现错误，所以对于如果能确保100%会成功的转换则可使用 as!，否则使用 as?


//let protocolValue: ExampleProtocol = ExampleProtocol.self as! ExampleProtocol


//MARK:- 错误处理

//你可以用任何遵循 Error 协议的类型来表示错误。
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}


//使用 throw 来抛出一个错误并且用 throws 来标记一个可以抛出错误的函数。如果你在函数里抛出一个错误，函数会立即返回并且调用函数的代码会处理错误。

func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    
    
    //有好几种方法来处理错误。一种是使用 do-catch 。在 do 代码块里，你用 try 来在能抛出错误的函数前标记。在 catch 代码块，错误会自动赋予名字 error ，如果你不给定其他名字的话。
    do {
        let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
        print(printerResponse)
    } catch {
        print(error)
    }
    
    return "Job sent"
}

//MARK: swift 反射
class SwiftPushViewController: UIViewController {
    func pushNav() -> () {
        if let cls = NSClassFromString(getAPPName() + "." + "TestViewController") as? UIViewController.Type {
            let vc = cls.init()
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func getAPPName() -> String {
        guard let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else { return "" }
        return appName
    }
}
