//
//  StrategyMethod.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/7/23.
//  Copyright © 2019 xinxin. All rights reserved.
//



/// 比OC 方便多了


struct TestSubject {
    let pupilDiameter: Double
    let blushResponse: Double
    let isOrganic: Bool
}

// protocol
protocol StrategyMethod: AnyObject {
    func testRealness(_ testSubject: TestSubject) -> Bool
    func play() -> Void
}

extension StrategyMethod{
    
    func play() -> Void {
        print("default play")
    }
}


// strategy Method 1
final class VoightKampffTest: StrategyMethod {
    func testRealness(_ testSubject: TestSubject) -> Bool {
        return testSubject.pupilDiameter < 30.0 || testSubject.blushResponse == 0.0
    }
    
    func play() {
        print("VoightKampffTest play")
    }
}

// strategy Method 2
final class GeneticTest: StrategyMethod {
    func testRealness(_ testSubject: TestSubject) -> Bool {
        return testSubject.isOrganic
    }
}


// init Strategy
final class BladeRunner {
    
    private let strategy: StrategyMethod
    
    init(test: StrategyMethod) {
        self.strategy = test
    }
    
    func testIfAndroid(_ testSubject: TestSubject) -> Bool {
        return !strategy.testRealness(testSubject)
    }
    
    func videoPlay() -> Void {
        strategy.play()
    }
}




