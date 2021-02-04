//
//  StrategyMethod.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/7/23.
//  Copyright © 2019 xinxin. All rights reserved.
//

/**
行为模式：
 策略模式（Strategy）
 对象有某个行为，但是在不同的场景中，该行为有不同的实现算法。策略模式：
 * 定义了一族算法（业务规则）；
 * 封装了每个算法；
 * 这族的算法可互换代替（interchangeable）。
 
  */

struct DownLoadObj {
    let url: String
    
}

//MARK: 策略 （抽象策略类 Strategy） 抽象策略类声明具体策略类需要实现的接口，这个接口同时也是提供给客户端调用的接口
// protocol
protocol StrategyMethod: AnyObject {
    func handlerData(_ obj: DownLoadObj) -> Void
    func down() -> Void
}

extension StrategyMethod{
    func down() -> Void {
        print("default http download")
    }
}


//MARK: 具体策略 （具体策略类 Concrete Strategies） 具体策略类实现抽象策略类声明的接口，每个具体策略类都有自己独有的实现方式，即代表不同策略。
// strategy Method 0
final class hpDownload: StrategyMethod {
    func handlerData(_ obj: DownLoadObj) {
        // hp -> obj.url
    }
    
}

// strategy Method 1
final class sdDownload: StrategyMethod {
    func handlerData(_ obj: DownLoadObj) {
        // sd -> obj.url
    }
    
    func down() {
        print("sd sdk download")
    }
}

// strategy Method 2
final class bjyDownload: StrategyMethod {
    func handlerData(_ obj: DownLoadObj) {
       // bjy -> obj.url
    }
    
    func down() {
        print("bjy sdk download")
    }
}


//MARK: 上下文 （环境类 Context） 环境类内部持有一个具体策略类的实例，这个实例就是当前的策略，可以供客户端使用

// init Strategy
final class DownloadTools {
    
    private var strategy: StrategyMethod
    
    /// Usually, the Context accepts a strategy through the constructor, but
    /// also provides a setter to change it at runtime.
    init(strategy: StrategyMethod) {
        self.strategy = strategy
    }
    
    /// Usually, the Context allows replacing a Strategy object at runtime.
    func update(strategy: StrategyMethod) {
        self.strategy = strategy
    }
    
    func absHandlerData(_ obj: DownLoadObj) {
        strategy.handlerData(obj)
    }
    
    func absDown() -> Void {
        strategy.down()
    }
}

//MARK: 客户端 （Client） 会创建一个特定策略对象并将其传递给上下文。 上下文则会提供一个设置器以便客户端在运行时替换相关联的策略。
// Usage
func testMethod() {
    let downObj = DownLoadObj.init(url: "")

    let ccDownLoad = DownloadTools(strategy: sdDownload())
    ccDownLoad.absHandlerData(downObj)
    ccDownLoad.absDown()


    let bjyDownLoad = DownloadTools(strategy: bjyDownload())
    bjyDownLoad.absHandlerData(downObj)
    bjyDownLoad.absDown()

    bjyDownLoad.update(strategy: sdDownload())
    bjyDownLoad.absHandlerData(downObj)
    bjyDownLoad.absDown()

}

/*
多种试卷类型请求
 
 ExerciseVCRequest
 ExamRequestManager
 
 */
