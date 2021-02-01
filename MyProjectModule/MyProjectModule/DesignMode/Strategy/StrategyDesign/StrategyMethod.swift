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
