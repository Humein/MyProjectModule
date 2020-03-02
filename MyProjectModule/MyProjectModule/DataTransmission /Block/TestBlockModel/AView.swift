//
//  AView.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/11/15.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit

class AView: UIView {
    
    func refreshView(_ model: BlockModel) {
        let b = BView()
        print("A")
        model.stateBlock = { (any) -> () in
            print(any)
        }
        b.refreshView(model)
    }
}
