//
//  BView.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/11/15.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit

class BView: UIView {

    func refreshView(_ model: BlockModel) {
        let c = CView()
        print("B")
        c.refreshView(model)
    }
}
