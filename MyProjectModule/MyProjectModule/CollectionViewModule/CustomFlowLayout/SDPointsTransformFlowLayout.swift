//
//  SDPointsTransformFlowLayout.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/5/15.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit
//滚动切换回调方法
typealias XLCardScollIndexChangeBlock = (Int) -> Void
class SDPointsTransformFlowLayout: UICollectionViewFlowLayout {
    //卡片和父视图宽度比例
    let cardWidthScale: CGFloat = 94 + 20
    //卡片和父视图高度比例
    let cardHeightScale: CGFloat = 59 + 20
    //滚动到中间的调方法
    var indexChangeBlock: XLCardScollIndexChangeBlock?
    
    
    override func prepare() {
        self.scrollDirection = UICollectionView.ScrollDirection.horizontal
        self.sectionInset = UIEdgeInsets(top: self.insetY(), left: self.insetX(), bottom: self.insetY(), right: self.insetX())
        self.itemSize = CGSize(width: self.itemWidth(), height: self.itemHeight())
        self.minimumLineSpacing = 10
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //获取cell的布局
        let originalAttributesArr = super.layoutAttributesForElements(in: rect)
        //复制布局,以下操作，在复制布局中处理
        var attributesArr: Array<UICollectionViewLayoutAttributes> = Array.init()
        for attr: UICollectionViewLayoutAttributes in originalAttributesArr! {
            attributesArr.append(attr.copy() as! UICollectionViewLayoutAttributes)
        }
        
        //屏幕中线
        let centerX: CGFloat =  (self.collectionView?.contentOffset.x)! + (self.collectionView?.bounds.size.width)!/2.0
        
        //最大移动距离，计算范围是移动出屏幕前的距离
        let maxApart: CGFloat  = ((self.collectionView?.bounds.size.width)! + self.itemWidth())/2.0
        
        //刷新cell缩放
        for attributes: UICollectionViewLayoutAttributes in attributesArr {
            //获取cell中心和屏幕中心的距离
            let apart: CGFloat = abs(attributes.center.x - centerX)
            //移动进度 -1~0~1
            let progress: CGFloat = apart/maxApart
            //在屏幕外的cell不处理
            if (abs(progress) > 1) {continue}
            //根据余弦函数，弧度在 -π/4 到 π/4,即 scale在 √2/2~1~√2/2 间变化
            var scale: CGFloat = abs(cos(progress * CGFloat(Double.pi)) + 0.1)// 动态
            if scale < 0.9 {
                scale = 0.9
            }else {
//                attributes.center.y = attributes.center.y - 7
            }
            // 中心位置偏移
            attributes.center.y = attributes.center.y + 35
            //缩放大小
            attributes.transform = CGAffineTransform.init(scaleX: scale, y: scale)
            // y 平移
            attributes.transform = attributes.transform.translatedBy(x: 0, y: -35)

            //更新中间位
            if (apart <= self.itemWidth()/2.0) {
                self.indexChangeBlock?(attributes.indexPath.row)
            }
        }
        return attributesArr
    }
    
    //MARK -
    //MARK 配置方法
    //卡片宽度
    func itemWidth() -> CGFloat {
        return cardWidthScale
    }
    
    //卡片高度
    func itemHeight() -> CGFloat {
        return cardHeightScale
    }
    
    //设置左右缩进
    func insetX() -> CGFloat {
        let insetX: CGFloat = ((self.collectionView?.bounds.size.width)! - self.itemWidth())/2.0
        return insetX
    }
    
    //上下缩进
    func insetY() -> CGFloat {
        let insetY: CGFloat = ((self.collectionView?.bounds.size.height)! - self.itemHeight())/2.0
        return insetY
    }
    
    //是否实时刷新布局
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}


/**
     override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
         //获取cell的布局
         let originalAttributesArr = super.layoutAttributesForElements(in: rect)
         //复制布局,以下操作，在复制布局中处理
         var attributesArr: Array<UICollectionViewLayoutAttributes> = Array.init()
         for attr: UICollectionViewLayoutAttributes in originalAttributesArr! {
             attributesArr.append(attr.copy() as! UICollectionViewLayoutAttributes)
         }
         
         //屏幕中线
         let centerX: CGFloat =  (self.collectionView?.contentOffset.x)! + (self.collectionView?.bounds.size.width)!/2.0
         
         //最大移动距离，计算范围是移动出屏幕前的距离
         let maxApart: CGFloat  = ((self.collectionView?.bounds.size.width)! + self.itemWidth())/2.0
         
         //刷新cell缩放
         for attributes: UICollectionViewLayoutAttributes in attributesArr {
             //获取cell中心和屏幕中心的距离
             let apart: CGFloat = abs(attributes.center.x - centerX)
             //移动进度 -1~0~1
             let progress: CGFloat = apart/maxApart
 //            if attributes.center.x == centerX { // 指定cell
 //                attributes.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.3)
 //                attributes.center.y = attributes.center.y - 10
 //            }

             //在屏幕外的cell不处理
             if (abs(progress) > 1) {continue}
             //根据余弦函数，弧度在 -π/4 到 π/4,即 scale在 √2/2~1~√2/2 间变化
             let scale: CGFloat = abs(cos(progress * CGFloat(Double.pi/4)))// 动态
             //缩放大小
             attributes.transform = CGAffineTransform.init(scaleX: scale, y: scale)
             attributes.center.y = attributes.center.y - 10

             //更新中间位
             if (apart <= self.itemWidth()/2.0) {
                 self.indexChangeBlock?(attributes.indexPath.row)
             }
         }
         return attributesArr
     }
 */
