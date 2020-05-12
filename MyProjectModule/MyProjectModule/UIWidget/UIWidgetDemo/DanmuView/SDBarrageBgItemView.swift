//
//  SDBarrageBgItemView.swift
//  SDBarrageBgItemView
//
//  Created by XinXin on 2020/5/7.
//  Copyright © 2020 xinxin. All rights reserved.
//

import Foundation
import UIKit

class SDBarrageBgItemView: SDBarrageItemView {

    lazy var bgView: UIView = {
        var bgView = UIView()
        
        bgView.backgroundColor = UIColor.lightGray
        bgView.layer.cornerRadius = 4
        bgView.clipsToBounds = true
        
        return bgView
    }()

    override func commonInit() {
        super.commonInit()
        self.insertSubview(bgView, belowSubview: label)
    }
    
    override func sizeToFit() {
        super.sizeToFit()
        bgView.frame = self.bounds
    }
    
}
