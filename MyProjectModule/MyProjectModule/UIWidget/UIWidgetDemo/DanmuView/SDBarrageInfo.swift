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
    var bgColor: UIColor?

    init(text aText: String) {
        text = aText
    }

    init(attrText attText: NSAttributedString, aItemViewClass: AnyClass = SDBarrageItemView.self, aBgColor: UIColor = .black) {
        text = attText.string
        attributedText = attText
        itemViewClass = aItemViewClass
        bgColor = aBgColor
    }

}
