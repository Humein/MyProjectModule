//
//  Chain_of_responsibility.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/7/29.
//  Copyright © 2019 xinxin. All rights reserved.
//

/*
 The chain of responsibility pattern is used to process varied requests, each of which may be dealt with by a different handler.

 顾名思义，责任链模式（Chain of Responsibility Pattern）为请求创建了一个接收者对象的链。这种模式给予请求的类型，对请求的发送者和接收者进行解耦。这种类型的设计模式属于行为型模式。
 在这种模式中，通常每个接收者都包含对另一个接收者的引用。如果一个对象不能处理该请求，那么它会把相同的请求传给下一个接收者，依此类推。
 
 使用场景：
 有多个对象可以处理同一个请求，具体哪个对象处理该请求由运行时刻自动确定。
 在不明确指定接收者的情况下，向多个对象中的一个提交一个请求。
 可动态指定一组对象处理请求。
 
 优点
 
 降低耦合度。它将请求的发送者和接收者解耦。
 简化了对象。使得对象不需要知道链的结构。
 增强给对象指派职责的灵活性。通过改变链内的成员或者调动它们的次序，允许动态地新增或者删除责任。
 增加新的请求处理类很方便。
 
 缺点
 
 不能保证请求一定被接收。？？
 系统性能将受到一定影响，而且在进行代码调试时不太方便，可能会造成循环调用。
 可能不容易观察运行时的特征，有碍于除错。
 

 
 利用链表形式 进行h关联
 */

protocol Withdrawing {
    func withdraw(amount: Int) -> Bool
    
}

//创建一个钱堆
final class MoneyPile: Withdrawing {
    
    let value: Int
    var quantity: Int
    var next: Withdrawing? //其他钱堆
    
    //构造方法
    init(value: Int, quantity: Int, next: Withdrawing?) {
        self.value = value
        self.quantity = quantity
        self.next = next
    }
    
    //取出金币操作
    func withdraw(amount: Int) -> Bool {
        
        var amount = amount
        
        func canTakeSomeBill(want: Int) -> Bool {
            return (want / self.value) > 0
        }
        
        var quantity = self.quantity
        
        while canTakeSomeBill(want: amount) {
            
            if quantity == 0 {
                break
            }
            
            amount -= self.value
            quantity -= 1
        }
        
        guard amount > 0 else {
            return true
        }
        
        if let next = self.next {
            return next.withdraw(amount: amount)
        }
        
        return false
    }
  
}

//创建一个银行
final class ATM: Withdrawing {
    
    private var hundred: Withdrawing //100面额的钱堆
    private var fifty: Withdrawing
    private var twenty: Withdrawing
    private var ten: Withdrawing
    
    //优先寻找的钱堆
    private var startPile: Withdrawing {
        return self.hundred
    }
    
    init(hundred: Withdrawing,
         fifty: Withdrawing,
         twenty: Withdrawing,
         ten: Withdrawing) {
        
        self.hundred = hundred
        self.fifty = fifty
        self.twenty = twenty
        self.ten = ten
    }
    
    //取出想要的钱数操作
    func withdraw(amount: Int) -> Bool {
        return startPile.withdraw(amount: amount)
    }
}


/*:
 ### Usage
 */

//创建如下钱堆，并将它们整理（连接）在一起。

let ten = MoneyPile(value: 10, quantity: 6, next: nil)
let twenty = MoneyPile(value: 20, quantity: 2, next: ten)
let fifty = MoneyPile(value: 50, quantity: 2, next: twenty)
let hundred = MoneyPile(value: 100, quantity: 1, next: fifty)

//创建银行
var atm = ATM(hundred: hundred, fifty: fifty, twenty: twenty, ten: ten)


//atm.canWithdraw(amount: 300) //输出: Can withdraw: true ，因为银行里金币总价值300
//atm.canWithdraw(amount: 130) //输出: Can withdraw: true，因为可以取1个100面额的金币+1个20面额的金币+1个10面额的金币组成。
//atm.canWithdraw(amount: 105) //输出：Can withdraw: false, 因为没有一个钱堆有面额为5的金币。
