//
//  StrategyMethod.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/7/23.
//  Copyright © 2019 xinxin. All rights reserved.
//
/*
   本科来 多种试卷请求
 */



/**
行为模式：
 策略模式（Strategy）
 对象有某个行为，但是在不同的场景中，该行为有不同的实现算法。策略模式：
 * 定义了一族算法（业务规则）；
 * 封装了每个算法；
 * 这族的算法可互换代替（interchangeable）。
 
  */

struct DownLoadObj {
    let dToolsType: Int
    // ...
}

// protocol
protocol StrategyMethod: AnyObject {
    func testRealness(_ obj: DownLoadObj) -> Bool
    func down() -> Void
}

extension StrategyMethod{
    func down() -> Void {
        print("default play")
    }
}


// strategy Method 1
final class VoightKampffTest: StrategyMethod {
    func testRealness(_ obj: DownLoadObj) -> Bool {
        return obj.dToolsType == 0
    }
    
    func down() {
        print("AA down")
    }
}

// strategy Method 2
final class GeneticTest: StrategyMethod {
    func testRealness(_ obj: DownLoadObj) -> Bool {
        return obj.dToolsType == 0
    }
    
    func down() {
        print("BB down")
    }
}


// init Strategy
final class BladeRunner {
    
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
    
    func testIfAndroid(_ obj: DownLoadObj) -> Bool {
        return strategy.testRealness(obj)
    }
    
    func absDown() -> Void {
        strategy.down()
    }
}


// Usage
func testMethod() {
    let rachel = DownLoadObj.init(dToolsType: 0)

    // Deckard is using a traditional test
    let deckard = BladeRunner(strategy: VoightKampffTest())
    let isRachelAndroid = deckard.testIfAndroid(rachel)
    deckard.absDown()

    // Gaff is using a very precise method
    let gaff = BladeRunner(strategy: GeneticTest())
    let isDeckardAndroid = gaff.testIfAndroid(rachel)
    gaff.absDown()
    
    gaff.update(strategy: VoightKampffTest())
    gaff.absDown()


}
