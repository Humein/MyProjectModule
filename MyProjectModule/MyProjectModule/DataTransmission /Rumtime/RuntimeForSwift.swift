//
//  RuntimeForSwift.swift
//  MyProjectModule
//
//  Created by zhangxinxin on 2021/5/26.
//  Copyright © 2021 xinxin. All rights reserved.
//

import UIKit

class RuntimeForSwift: NSObject {

    // MARK: 为Swift类型提供动态派发的能力
    struct structWithDynamic {
        public var str: String
        public func show(_ str: String) -> String {
            print("Say \(str)")
            return str
        }
        internal func showDynamic(_ obj: AnyObject, str: String) -> String {
            return show(str)
        }
    }
    
    func runtimeDemo1(){
        let structValue = structWithDynamic(str: "Hi!")
        // 为 structValue 添加Objc运行时方法
        let block: @convention(block)(AnyObject, String) -> String = structValue.showDynamic
        let imp = imp_implementationWithBlock(unsafeBitCast(block, to: AnyObject.self))
        let dycls: AnyClass = object_getClass(structValue)!
        class_addMethod(dycls, NSSelectorFromString("objcShow:"), imp, "@24@0:8@16")
        // 使用Objc动态派发
        _ = (structValue as AnyObject).perform(NSSelectorFromString("objcShow:"), with: String("Bye!"))!
    }

}
