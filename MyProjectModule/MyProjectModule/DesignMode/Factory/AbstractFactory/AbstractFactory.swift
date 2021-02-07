//
//  AbstractFactory.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/12/11.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit
/*
 使用抽象工厂模式为客户提供一组相关或依赖对象。的“家庭”创建的对象工厂是在运行时决定的。
 */

//MARK: - 实现1
//Protocols
protocol BurgerDescribing {
    var ingredients: [String] { get }
}

struct CheeseBurger: BurgerDescribing {
    let ingredients: [String]
}

protocol BurgerMaking {
    func make() -> BurgerDescribing
}

// Number implementations with factory methods

final class BigKahunaBurger: BurgerMaking {
    func make() -> BurgerDescribing {
        return CheeseBurger(ingredients: ["Cheese", "Burger", "Lettuce", "Tomato"])
    }
}

final class JackInTheBox: BurgerMaking {
    func make() -> BurgerDescribing {
        return CheeseBurger(ingredients: ["Cheese", "Burger", "Tomato", "Onions"])
    }
}


// Abstract factory

enum BurgerFactoryType: BurgerMaking {

    case bigKahuna
    case jackInTheBox

    func make() -> BurgerDescribing {
        switch self {
        case .bigKahuna:
            return BigKahunaBurger().make()
        case .jackInTheBox:
            return JackInTheBox().make()
        }
    }
}


//MARK:- Usage
class AbstractFactory: NSObject {

    let bigKahuna = BurgerFactoryType.bigKahuna.make()
    let jackInTheBox = BurgerFactoryType.jackInTheBox.make()
}


//MARK: - 实现2


