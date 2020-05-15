//
//  SDPointsTransformView.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/5/15.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit
//代理
@objc protocol SDCardSwitchDelegate: NSObjectProtocol {
    //滑动切换到新的位置回调
    @objc optional func cardSwitchDidScrollToIndex(index: Int) -> ()
    //手动点击了
    @objc optional func cardSwitchDidSelectedAtIndex(index: Int) -> ()
}

//数据源
@objc protocol SDCardSwitchDataSource: NSObjectProtocol {
    //卡片的个数
    func cardSwitchNumberOfCard() -> (Int)
    //卡片cell
    func cardSwitchCellForItemAtIndex(index: Int) -> (UICollectionViewCell)
}

class SDPointsTransformView: UIView,UICollectionViewDelegate,UICollectionViewDataSource {
    //公有属性
    weak var delegate: SDCardSwitchDelegate?
    weak var dataSource: SDCardSwitchDataSource?
    var selectedIndex: Int = 0
    var pagingEnabled: Bool = false
    //私有属性
    private var _dragStartX: CGFloat = 0
    private var _dragEndX: CGFloat = 0
    private var _dragAtIndex: Int = 0
    
    private let flowlayout = SDPointsTransformFlowLayout()
    
    private lazy var _collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.clear
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    func buildUI() {
        self.addSubview(_collectionView)
        
        //添加回调方法
        flowlayout.indexChangeBlock = { (index) -> () in
            if self.selectedIndex != index {
                self.selectedIndex = index
                self.delegateUpdateScrollIndex(index: index)
            }
        }
        
    }
    
    //MARK:自动布局
    override func layoutSubviews() {
        super.layoutSubviews()
        _collectionView.frame = self.bounds
    }

    //MARK:-
    //MARK:CollectionView方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.dataSource?.cardSwitchNumberOfCard()) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (self.dataSource?.cardSwitchCellForItemAtIndex(index: indexPath.row))!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //执行代理方法
        selectedIndex = indexPath.row
        self.scrollToCenterAnimated(animated: true)
        self.delegateSelectedAtIndex(index: indexPath.row)
    }
    
    //MARK:-
    //MARK:ScrollViewDelegate
    @objc func fixCellToCenter() -> () {
        if self.selectedIndex != _dragAtIndex {
            self.scrollToCenterAnimated(animated: true)
            return
        }
        //最小滚动距离
        let dragMiniDistance: CGFloat = self.bounds.size.width/20.0
        if _dragStartX - _dragEndX >= dragMiniDistance {
            self.selectedIndex -= 1//向右
        }else if _dragEndX - _dragStartX >= dragMiniDistance {
            self.selectedIndex += 1 //向左
        }
        
        let maxIndex: Int  = (_collectionView.numberOfItems(inSection: 0)) - 1
        self.selectedIndex = max(self.selectedIndex, 0)
        self.selectedIndex = min(self.selectedIndex, maxIndex)
        self.scrollToCenterAnimated(animated: true)
    }
    
    //滚动到中间
    func scrollToCenterAnimated(animated: Bool) -> () {
        _collectionView.scrollToItem(at: IndexPath.init(row:self.selectedIndex, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
    
    //手指拖动开始
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if (!self.pagingEnabled) { return }
        _dragStartX = scrollView.contentOffset.x
        _dragAtIndex = self.selectedIndex
    }
    
    //手指拖动停止
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!self.pagingEnabled) { return }
        _dragEndX = scrollView.contentOffset.x
        //在主线程执行居中方法
        DispatchQueue.main.async {
            self.fixCellToCenter()
        }
    }
    
    //MARK:-
    //MARK:执行代理方法
    //回调滚动方法
    func delegateUpdateScrollIndex(index: Int) -> () {
        guard let delegate = self.delegate else { return }
        if (delegate.responds(to: #selector(delegate.cardSwitchDidScrollToIndex(index:)))) {
            delegate.cardSwitchDidScrollToIndex?(index: index)
        }
    }
    
    //回调点击方法
    func delegateSelectedAtIndex(index: Int) -> () {
        guard let delegate = self.delegate else { return }
        if (delegate.responds(to: #selector(delegate.cardSwitchDidSelectedAtIndex(index:)))) {
            delegate.cardSwitchDidSelectedAtIndex?(index: index)
        }
    }
    
    //MARK:-
    //MARK:切换位置方法
    func switchToIndex(index: Int) -> () {
        DispatchQueue.main.async {
            self.selectedIndex = index
            self.scrollToCenterAnimated(animated: true)
        }
    }
    
    //向前切换
    func switchPrevious() -> () {
        guard let index = currentIndex() else { return }
        var targetIndex = index - 1
        targetIndex = max(0, targetIndex)
        self.switchToIndex(index: targetIndex)
    }
    
    //向后切换
    func switchNext() -> () {
        guard let index = currentIndex() else { return }
        var targetIndex = index + 1
        let maxIndex = (self.dataSource?.cardSwitchNumberOfCard())! - 1
        targetIndex = min(maxIndex, targetIndex)
        
        self.switchToIndex(index: targetIndex)
    }
    
    func currentIndex() -> Int? {
        let x = _collectionView.contentOffset.x + _collectionView.bounds.width/2
        return _collectionView.indexPathForItem(at: CGPoint(x: x, y: _collectionView.bounds.height/2))?.item
    }
    
    //MARK:-
    //MARK:数据源相关方法
    open func register(cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        _collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    open func dequeueReusableCell(withReuseIdentifier identifier: String, for index: Int) -> UICollectionViewCell {
        return _collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: IndexPath(row: index, section: 0))
    }
}
