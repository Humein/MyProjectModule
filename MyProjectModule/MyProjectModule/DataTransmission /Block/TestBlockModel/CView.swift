//
//  CView.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/11/15.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit

class CView: UIView {

    func refreshView(_ model: BlockModel) {
        print("C")
        // ?解包 代替判断nil
        model.stateBlock?("C")
//        if model.stateBlock != nil {
//            print("ActionCBlock")
//            model.stateBlock!()
//        }
    }

    
}
