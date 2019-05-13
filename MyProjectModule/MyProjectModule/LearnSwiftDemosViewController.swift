//
//  LearnSwiftDemosViewController.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/5/10.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit

class LearnSwiftDemosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.learnSwift()
        
        greet(person: "Bob", day: "Tuesday")
        
        greet1("John", on: "Wednesday")
        
        print ("\(greet)")
        
        
        let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
        
        print(statistics.sum)
        
        print(statistics.2)
        
        
        sumOf()
        
        
        sumOf(numbers: 42, 597, 12)

        returnFifteen()
        
        
        var numbers = [20,19,7,12]

        hasAnyMatches(list: numbers, condition: lessThanTen)
        
        
        //函数其实就是闭包的一种特殊形式：一段可以被随后调用的代码块。闭包中的代码可以访问其生效范围内的变量和函数，就算是闭包在它声明的范围之外被执行——你已经在内嵌函数的栗子上感受过了。你可以使用花括号（ {}）括起一个没有名字的闭包。在闭包中使用 in来分隔实际参数和返回类型。
       let mappedNumbers =  numbers.map({
            (number: Int) -> Int in
            let result = 3 * number
            return result
        })
    
        print(mappedNumbers)

//        你有更多的选择来把闭包写的更加简洁。当一个闭包的类型已经可知，比如说某个委托的回调，你可以去掉它的参数类型，它的返回类型，或者都去掉。
//
//        单语句闭包隐式地返回语句执行的结果。

        let mappedNumbers1 = numbers.map({ number in 3 * number })
        print(mappedNumbers1)
        
        
        
//        你可以调用参数通过数字而非名字——这个特性在非常简短的闭包当中尤其有用。当一个闭包作为函数最后一个参数出入时，可以直接跟在圆括号后边。如果闭包是函数的唯一参数，你可以去掉圆括号直接写闭包。

        let sortedNumbers = numbers.sorted { $0 > $1 }
        print(sortedNumbers)
        
    }
    
    //MARK:- 简单值
    
    private func learnSwift(){
        let label = "The width is "
        let width = 94
        let widthLabel = label + String(width)
        
        print("=======" + widthLabel)
        
        
        let apples = 3
        let oranges = 5
        let appleSummary = "I have \(apples) apples."
        let fruitSummary = "I have \(apples + oranges) pieces of fruit."
        
        print("=======" + fruitSummary + appleSummary)
        
        
        //        使用方括号（ []）来创建数组或者字典，并且使用方括号来按照序号或者键访问它们的元素。
        
        var shoppingList = ["catfish", "water", "tulips", "blue paint"]
        shoppingList[1] = "bottle of water"
        
        var occupations = [
            "Malcolm": "Captain",
            "Kaylee": "Mechanic",
            ]
        occupations["Jayne"] = "Public Relations"
        
        //        使用初始化器语法来创建一个空的数组或者字典。
        
        let emptyArray = [String]()
        
        let emptyDictionary = [String: Float]()
        
        
        
        //MARK: - 控制流
        //        使用 if和 switch来做逻辑判断，使用 for-in， for， while，以及 repeat-while来做循环。使用圆括号把条件或者循环变量括起来不再是强制的了，不过仍旧需要使用花括号来括住代码块。
        
        let individualScores = [75, 43, 103, 87, 12]
        var teamScore = 0
        for score in individualScores {
            if score > 50 {
                teamScore += 3
            } else {
                teamScore += 1
            }
        }
        print(teamScore)
        
        
        //        在一个 if语句当中，条件必须是布尔表达式——这意味着比如说 if score {...}将会报错，不再隐式地与零做计算了。
        //        你可以一起使用 if和 let来操作那些可能会丢失的值。这些值使用可选项表示。可选的值包括了一个值或者一个 nil来表示值不存在。在一个值的类型后边使用问号（ ?）来把某个值标记为可选的。
        
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
        
        
        //        另一种处理可选值的方法是使用 ?? 运算符提供默认值。如果可选值丢失，默认值就会使用。
        
        let nickName: String? = nil
        let fullName: String = "John Appleseed"
        let informalGreeting = "Hi \(nickName ?? fullName)"
        
        
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
        print(largest)
        
        
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
        
        
        //        使用 ..<来创造一个序列区间：
        //        ..<来创建一个不包含最大值的区间，使用 ... 来创造一个包含最大值和最小值的区间。
        var total = 0
        for i in 0..<4 {
            total += i
        }
        print(total)
        
    }
    
    //MARK: - 函数和闭包
    
    
    //使用 func来声明一个函数。通过在名字之后在圆括号内添加一系列参数来调用这个方法。使用 ->来分隔形式参数名字类型和函数返回的类型。
    
    func greet(person: String, day: String) -> String {
        
        return  "Hello \(person), today is \(day)."
    }
    
    //默认情况下，函数使用他们的形式参数名来作为实际参数标签。在形式参数前可以写自定义的实际参数标签，或者使用 _ 来避免使用实际参数标签。
    
    func greet1(_ person: String, on day: String) -> String {
        
        return "Hello \(person), today is \(day)."
    }
    
    
    //使用元组来创建复合值——比如，为了从函数中返回多个值。元组中的元素可以通过名字或者数字调用。
    
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
    

    
    //函数同样可以接受多个参数，然后把它们存放进数组当中。

    func sumOf(numbers: Int...) -> Int {
        var sum = 0
        for number in numbers {
            sum += number
        }
        return sum
    }
    
    //函数可以内嵌。内嵌的函数可以访问外部函数里的变量。你可以通过使用内嵌函数来组织代码，以避免某个函数太长或者太过复杂。
    
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
    
    func lessThanTen(number: Int) -> Bool {
        return number < 10
    }
    


    
   
}
