//
//  EXUIViewController.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/4/20.
//  Copyright © 2020 xinxin. All rights reserved.
//  swift runtime

import UIKit
extension UIViewController {
    class func extConfigOrientation(_ classVC: AnyClass){
        let originalSelector = #selector(getter: shouldAutorotate)
        let originalSelector1 = #selector(getter: supportedInterfaceOrientations)
        let originalSelector2 = #selector(getter: preferredInterfaceOrientationForPresentation)
        let swizzledSelector = #selector(sw_shouldAutorotate)
        let swizzledSelector1 = #selector(sw_supportedInterfaceOrientations)
        let swizzledSelector2 = #selector(sw_preferredInterfaceOrientationForPresentation)
        let originalMethod = class_getInstanceMethod(classVC, originalSelector)
        let originalMethod1 = class_getInstanceMethod(classVC, originalSelector1)
        let originalMethod2 = class_getInstanceMethod(classVC, originalSelector2)
        let swizzledMethod = class_getInstanceMethod(classVC, swizzledSelector)
        let swizzledMethod1 = class_getInstanceMethod(classVC, swizzledSelector1)
        let swizzledMethod2 = class_getInstanceMethod(classVC, swizzledSelector2)
        let didAddMethod = class_addMethod(classVC, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        let didAddMethod1 = class_addMethod(classVC, originalSelector1, method_getImplementation(swizzledMethod1!), method_getTypeEncoding(swizzledMethod1!))
        let didAddMethod2 = class_addMethod(classVC, originalSelector2, method_getImplementation(swizzledMethod2!), method_getTypeEncoding(swizzledMethod2!))
        if didAddMethod == false { method_exchangeImplementations(originalMethod!, swizzledMethod!)}
        if didAddMethod1 == false { method_exchangeImplementations(originalMethod1!, swizzledMethod1!)}
        if didAddMethod2 == false { method_exchangeImplementations(originalMethod2!, swizzledMethod2!)}
    }
    
    @objc func sw_shouldAutorotate() -> Bool{
        return true
    }
    
    @objc func sw_supportedInterfaceOrientations() -> UIInterfaceOrientationMask{
        return .all
    }
    
    @objc func sw_preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation{
        return .portrait
    }

}
