//
//  SDBarrageInfo.swift
//  SDBarrageInfo
//
//  Created by XinXin on 2020/5/7.
//  Copyright © 2020 xinxin. All rights reserved.
//

import Foundation
import UIKit

class SDBarrageInfo {
    var text: String
    var attributedText: NSAttributedString?
    var itemViewClass: AnyClass = SDBarrageItemView.self
    
    init(text aText: String) {
        text = aText
    }
    // 预留扩展view
    init(attrText attText: NSAttributedString, aItemViewClass: AnyClass = SDBarrageItemView.self) {
        text = attText.string
        attributedText = attText
        itemViewClass = aItemViewClass
    }

}
