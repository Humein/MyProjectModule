//
//  SDDeviceOrientation.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/4/20.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit

class SDDeviceOrientation: NSObject {
    
    @objc static let sharedInstance: SDDeviceOrientation = {
        let instance = SDDeviceOrientation()
        return instance
    }()

    func screenExChangeforOrientation(_ orientation: UIInterfaceOrientation){
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
    }
    
    func allowRotation(_ vc: UIViewController){
        UIViewController.extConfigOrientation(vc.classForCoder)
    }
}
