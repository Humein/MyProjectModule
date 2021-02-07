//
//  FactoryObject.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/12/11.
//  Copyright © 2019 xinxin. All rights reserved.
//

/*
 - 使用工厂模式取代类构造函数,抽象对象生成过程,对象实例化的类型可以在运行时决定。
   - 协议实现
 */
import UIKit

//MARK:- 实现1
protocol CurrencyDescribing {
    var symbol: String { get }
    var code: String { get }
    func doSome()
}

final class Euro: CurrencyDescribing {
    func doSome() {
        print("----")
    }
    
    var symbol: String {
        return "€"
    }
    
    var code: String {
        return "EUR"
    }
}

final class UnitedStatesDolar: CurrencyDescribing {
    var symbol: String {
        return "$"
    }
    
    var code: String {
        return "USD"
    }
    
    func doSome(){
        print("====")
    }
}

enum Country {
    case unitedStates
    case spain
    case uk
    case greece
}

enum CurrencyFactory {
    static func currency(for country: Country) -> CurrencyDescribing? {
        switch country {
            case .spain, .greece:
                return Euro()
            case .unitedStates:
                return UnitedStatesDolar()
            default:
                return nil
        }
        
    }
}

//MARK:- Usage
class FactoryObject: NSObject {
    let noCurrencyCode = "No Currency Code Available"

    func factoryInit() {
        var str: String
        str = CurrencyFactory.currency(for: .greece)?.code ?? noCurrencyCode
        CurrencyFactory.currency(for: .greece)?.doSome()
        
        CurrencyFactory.currency(for: .spain)?.code ?? noCurrencyCode
        CurrencyFactory.currency(for: .unitedStates)?.code ?? noCurrencyCode
        CurrencyFactory.currency(for: .uk)?.code ?? noCurrencyCode
        print(str)
        
    }
}

//MARK:- 实现2
/**
 使用示例： 工厂方法模式在 Swift 代码中得到了广泛使用。 当你需要在代码中提供高层次的灵活性时， 该模式会非常实用。

 识别方法： 工厂方法可通过构建方法来识别， 它会创建具体类的对象， 但以抽象类型或接口的形式返回这些对象。
 */
