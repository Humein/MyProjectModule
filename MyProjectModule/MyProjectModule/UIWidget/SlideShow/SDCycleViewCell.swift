//
//  SDCycleViewCell.swift
//  SDCycleView
//
//  Created by Zhang Xin Xin on 2019/11/1.
//  Copyright © 2020 lucky. All rights reserved.
//

import UIKit
/// 默认轮播Cell
class SDCycleViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var titleLabel: UILabel!
    var onlyText: Bool = false {
        didSet {
            if onlyText {
                titleLabel.frame = contentView.bounds
            } else {
                titleLabel.frame = CGRect(x: 0, y: contentView.bounds.size.height-25, width: contentView.bounds.size.width, height: 25)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImageView()
        addTitleLabel()
    }
    
    private func addImageView() {
        imageView = UIImageView(frame: contentView.bounds)
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    
    private func addTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.clipsToBounds = true
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
