//
//  SDCycleView.swift
//  SDCycleView
//
//  Created by Zhang Xin Xin on 2019/11/1.
//  Copyright © 2020 lucky. All rights reserved.
//

import UIKit
/**
 - UICollectionView实现常见图片/文字无限轮播，支持自定义pageControl，自定义文字样式，以及轮播样式
 - useage:
 
 // init
 let cycleView = SDCycleView(frame: frame)
 cycleView.placeholderImage = UIImage(named: "placeholder")
 cycleView.setUrlsGroup(["http://...", "http://...", "http://..."])
 cycleView.delegate = self
 view.addSubview(cycleView)
 
 // SDCycleViewProtocol
 
 */
@objc public protocol SDCycleViewProtocol{
    /// 显示本地图片，需要实现下面的代理方法
    /// - Parameters:
    ///   - cycleView: 轮播图View
    ///   - imageView: <#imageView description#>
    ///   - image: <#image description#>
    ///   - index: <#index description#>
    @objc optional func cycleViewConfigureDefaultCellImage(_ cycleView: SDCycleView, imageView: UIImageView, image: UIImage?, index: Int)
    
    /// 要显示网络图片，需要实现下面的代理方法
    /// - Parameters:
    ///   - cycleView: 轮播图View
    ///   - imageView: <#imageView description#>
    ///   - imageUrl: <#imageUrl description#>
    ///   - index: <#index description#>
    @objc optional func cycleViewConfigureDefaultCellImageUrl(_ cycleView: SDCycleView, imageView: UIImageView, imageUrl: String?, index: Int)
    
    /// 修改label的样式，你可以使用下面的代理方法
    /// - Parameters:
    ///   - cycleView: 轮播图View
    ///   - titleLabel: <#titleLabel description#>
    ///   - index: <#index description#>
    @objc optional func cycleViewConfigureDefaultCellText(_ cycleView: SDCycleView, titleLabel: UILabel, index: Int)
    
    /// 修改pageControl的样式，你可以使用下面的代理方法
    /// - Parameters:
    ///   - cycleView: 轮播图View
    ///   - pageControl: <#pageControl description#>
    @objc optional func cycleViewConfigurePageControl(_ cycleView: SDCycleView, pageControl: SDPageControl)
    
    /// 滚动到第index个cell
    /// - Parameters:
    ///   - cycleView: <#cycleView description#>
    ///   - index: <#index description#>
    @objc optional func cycleViewDidScrollToIndex(_ cycleView: SDCycleView, index: Int)
    
    /// 点击了第index个cell
    /// - Parameters:
    ///   - cycleView: <#cycleView description#>
    ///   - index: <#index description#>
    @objc optional func cycleViewDidSelectedIndex(_ cycleView: SDCycleView, index: Int)
    
    /// 自定义cell样式
    @objc optional func cycleViewCustomCellIdentifier() -> String
    @objc optional func cycleViewCustomCellClass() -> AnyClass
    @objc optional func cycleViewCustomCellClassNib() -> UINib
    @objc optional func cycleViewCustomCellSetup(_ cycleView: SDCycleView, cell: UICollectionViewCell, for index: Int)
}

public class SDCycleView: UIView {
    /// 设置本地图片
    /// - Parameter imagesGroup: image数组
    /// - Parameter titlesGroup: 标题数组
    public func setImagesGroup(_ imagesGroup: Array<UIImage?>,
                               titlesGroup: Array<String?>? = nil) {
        if imagesGroup.count == 0 { return }
        realDataCount = imagesGroup.count
        self.imagesGroup = imagesGroup
        self.titlesGroup = titlesGroup ?? []
        self.imageUrlsGroup = []
        reload()
    }
    
    /// 设置网络图片
    /// - Parameter urlsGroup: url数组
    /// - Parameter titlesGroup: 标题数组
    public func setUrlsGroup(_ urlsGroup: Array<String?>,
                             titlesGroup: Array<String?>? = nil) {
        if urlsGroup.count == 0 { return }
        realDataCount = urlsGroup.count
        self.imageUrlsGroup = urlsGroup
        self.titlesGroup = titlesGroup ?? []
        self.imagesGroup = []
        reload()
    }
    
    /// 设置文字
    /// - Parameter titlesGroup: 文字数组
    public func setTitlesGroup(_ titlesGroup: Array<String?>) {
        if titlesGroup.count == 0 { return }
        realDataCount = titlesGroup.count
        self.imagesGroup = []
        self.imageUrlsGroup = []
        self.titlesGroup = titlesGroup
        reload()
    }
    /// cell identifier
    /// add by LeeYZ
    private var reuseIdentifier: String = "SDCycleViewCell"
    
    /// 是否自动滚动
    public var isAutomatic: Bool = true
    /// 是否无限轮播
    public var isInfinite: Bool = true {
        didSet {
            if isInfinite == false {
                itemsCount = realDataCount <= 1 || !isInfinite ? realDataCount : realDataCount*200
                collectionView.reloadData()
                collectionView.setContentOffset(.zero, animated: false)
                dealFirstPage()
            }
        }
    }
    /// 滚动时间间隔，默认2s
    public var timeInterval: Int = 2
    /// 滚动方向
    public var scrollDirection: UICollectionView.ScrollDirection = .horizontal {
        didSet { flowLayout.scrollDirection = scrollDirection }
    }
    /// 占位图
    public var placeholderImage: UIImage? = nil {
        didSet { placeholderImgView.image = placeholderImage }
    }
    /// item大小，默认SDCycleView大小
    public var itemSize: CGSize? {
        didSet {
            guard let itemSize = itemSize else { return }
            let width = min(bounds.size.width, itemSize.width)
            let height = min(bounds.size.height, itemSize.height)
            flowLayout.itemSize = CGSize(width: width, height: height)
        }
    }
    /// 中间item的放大比例, >=1
    public var itemZoomScale: CGFloat = 1 {
        didSet {
            collectionView.isPagingEnabled = itemZoomScale == 1
            flowLayout.scale = itemZoomScale
        }
    }
    /// item 间距
    public var itemSpacing: CGFloat = 0 {
        didSet { flowLayout.minimumLineSpacing = itemSpacing }
    }
    
    /// delegate
    public weak var delegate: SDCycleViewProtocol? {
        didSet {
            if delegate != nil { registerCell() }
        }
    }
    
    //=============================================
    private var flowLayout: SDCycleLayout!
    private var collectionView: UICollectionView!
    private var placeholderImgView: UIImageView!
    private var pageControl: SDPageControl!
    private var imagesGroup: Array<UIImage?> = []
    private var imageUrlsGroup: Array<String?> = []
    private var titlesGroup: Array<String?> = []
    private var timer: Timer?
    private var itemsCount: Int = 0
    private var realDataCount: Int = 0
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        addPlaceholderImgView()
        addCollectionView()
        addPageControl()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addPlaceholderImgView()
        addCollectionView()
        addPageControl()
    }
    
    override public func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow != nil {
            self.startTimer()
        } else {
            self.cancelTimer()
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        flowLayout.itemSize = itemSize != nil ? itemSize! : bounds.size
        collectionView.frame = bounds
        pageControl.frame = CGRect(x: 0, y: frame.size.height-25, width: frame.size.width, height: 25)
        collectionView.setContentOffset(.zero, animated: false)
        dealFirstPage()
        delegate?.cycleViewConfigurePageControl?(self, pageControl: pageControl)
    }
}

// MARK: - setupUI
extension SDCycleView {
    private func addPlaceholderImgView() {
        placeholderImgView = UIImageView(frame: CGRect.zero)
        placeholderImgView.image = placeholderImage
        addSubview(placeholderImgView)
        placeholderImgView.translatesAutoresizingMaskIntoConstraints = false
        let hCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|[placeholderImgView]|",
                                                   options: NSLayoutConstraint.FormatOptions(),
                                                   metrics: nil,
                                                   views: ["placeholderImgView": placeholderImgView!])
        let vCons = NSLayoutConstraint.constraints(withVisualFormat: "V:|[placeholderImgView]|",
                                                   options: NSLayoutConstraint.FormatOptions(),
                                                   metrics: nil,
                                                   views: ["placeholderImgView": placeholderImgView!])
        addConstraints(hCons)
        addConstraints(vCons)
    }
    
    private func addCollectionView() {
        flowLayout                                    = SDCycleLayout()
        flowLayout.itemSize                           = itemSize != nil ? itemSize! : bounds.size
        flowLayout.minimumInteritemSpacing            = 10000
        flowLayout.minimumLineSpacing                 = itemSpacing
        flowLayout.scrollDirection                    = scrollDirection
        
        collectionView                                = UICollectionView(frame: bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor                = UIColor.clear
        collectionView.bounces                        = false
        collectionView.showsVerticalScrollIndicator   = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate                       = self
        collectionView.dataSource                     = self
        collectionView.scrollsToTop                   = false
        collectionView.decelerationRate               = UIScrollView.DecelerationRate(rawValue: 0.0)
        registerCell()
        addSubview(collectionView)
    }
    
    private func registerCell() {
        if let customReuseIdentifier = delegate?.cycleViewCustomCellIdentifier?() {
            self.reuseIdentifier = customReuseIdentifier
        }
        if let customClass = delegate?.cycleViewCustomCellClass?() {
            collectionView.register(customClass, forCellWithReuseIdentifier: reuseIdentifier)
        } else if let customNib = delegate?.cycleViewCustomCellClassNib?() {
            collectionView.register(customNib, forCellWithReuseIdentifier: reuseIdentifier)
        } else {
            collectionView.register(SDCycleViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
    
    private func addPageControl() {
        pageControl = SDPageControl()
        addSubview(pageControl)
    }
    
    private func reload() {
        placeholderImgView.isHidden = true
        itemsCount = realDataCount <= 1 || !isInfinite ? realDataCount : realDataCount*200
        collectionView.reloadData()
        collectionView.setContentOffset(.zero, animated: false)
        dealFirstPage()
        if isAutomatic { startTimer() }
        if pageControl.isHidden { return }
        pageControl.numberOfPages = realDataCount
        pageControl.isHidden = realDataCount == 1 || (imagesGroup.count == 0 && imageUrlsGroup.count == 0)
        pageControl.currentPage = currentIndex() % realDataCount
    }
}

// MARK: - UICollectionViewDataSource / UICollectionViewDelegate
extension SDCycleView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cycleCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let index = indexPath.item % realDataCount
        
        if self.delegate?.cycleViewCustomCellSetup?(self, cell: cycleCell, for: index) != nil {
            return cycleCell
        }
        /// 使用默认的cell
        guard let cell = cycleCell as? SDCycleViewCell else { return cycleCell }
        cell.onlyText = imagesGroup.count == 0 && imageUrlsGroup.count == 0
        let title = index < titlesGroup.count ? titlesGroup[index] : nil
        cell.titleLabel.text = title
        if imagesGroup.count != 0 {
            let image = index < imagesGroup.count ? imagesGroup[index] : nil
            delegate?.cycleViewConfigureDefaultCellImage?(self, imageView: cell.imageView, image: image, index: index)
            if delegate?.cycleViewConfigureDefaultCellImage?(self, imageView: cell.imageView, image: image, index: index) == nil {
                NSException(name: .init(rawValue: "SDCycleViewError"), reason: "cycleViewConfigureDefaultCellImage方法未实现", userInfo: nil).raise()
            }
        }
        if imageUrlsGroup.count != 0 {
            let imageUrl = index < imageUrlsGroup.count ? imageUrlsGroup[index] : nil
            delegate?.cycleViewConfigureDefaultCellImageUrl?(self, imageView: cell.imageView, imageUrl: imageUrl, index: index)
            if delegate?.cycleViewConfigureDefaultCellImageUrl?(self, imageView: cell.imageView, imageUrl: imageUrl, index: index) == nil {
                NSException(name: .init(rawValue: "SDCycleViewError"), reason: "cycleViewConfigureDefaultCellImageUrl方法未实现", userInfo: nil).raise()
            }
        }
        delegate?.cycleViewConfigureDefaultCellText?(self, titleLabel: cell.titleLabel, index: index)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let centerViewPoint = convert(collectionView.center, to: collectionView)
        guard let centerIndex = collectionView.indexPathForItem(at: centerViewPoint) else { return }
        if indexPath.item == centerIndex.item {
            let index = indexPath.item % realDataCount
            if let delegate = delegate { delegate.cycleViewDidSelectedIndex?(self, index: index) }
        } else {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension SDCycleView {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if isAutomatic { cancelTimer() }
        dealLastPage()
        dealFirstPage()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isAutomatic { startTimer() }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard let delegate = delegate else { return }
        let index = currentIndex() % realDataCount
        pageControl?.currentPage = index
        delegate.cycleViewDidScrollToIndex?(self, index: index)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl?.currentPage = currentIndex() % realDataCount
    }
}

// MARK: - 处理第一帧和最后一帧
extension SDCycleView {
    private func dealFirstPage() {
        if currentIndex() == 0 && itemsCount > 1 && isInfinite {
            let targetIndex = itemsCount / 2
            let scrollPosition: UICollectionView.ScrollPosition = scrollDirection == .horizontal ? .centeredHorizontally : .centeredVertically
            collectionView.scrollToItem(at: IndexPath(item: targetIndex, section: 0), at: scrollPosition, animated: false)
        }
    }
    private func dealLastPage() {
        if currentIndex() == itemsCount-1 && itemsCount > 1 && isInfinite {
            let targetIndex = itemsCount / 2 - 1
            let scrollPosition: UICollectionView.ScrollPosition = scrollDirection == .horizontal ? .centeredHorizontally : .centeredVertically
            collectionView.scrollToItem(at: IndexPath(item: targetIndex, section: 0), at: scrollPosition, animated: false)
        }
    }
}

// MARK: - 定时器操作
extension SDCycleView {
    private func startTimer() {
        if !isAutomatic { return }
        if itemsCount <= 1 { return }
        cancelTimer()
        timer = Timer.init(timeInterval: Double(timeInterval), target: self, selector: #selector(timeRepeat), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
    }
    
    private func cancelTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc private func timeRepeat() {
        let current = currentIndex()
        var targetIndex = current + 1
        if (current == itemsCount - 1) {
            if isInfinite == false {return}
            dealLastPage()
            targetIndex = itemsCount / 2
        }
        let scrollPosition: UICollectionView.ScrollPosition = scrollDirection == .horizontal ? .centeredHorizontally : .centeredVertically
        collectionView.scrollToItem(at: IndexPath(item: targetIndex, section: 0), at: scrollPosition, animated: true)
    }
    
    private func currentIndex() -> Int {
        let itemWH = scrollDirection == .horizontal ? flowLayout.itemSize.width+itemSpacing : flowLayout.itemSize.height+itemSpacing
        let offsetXY = scrollDirection == .horizontal ? collectionView.contentOffset.x : collectionView.contentOffset.y
        if itemWH == 0 { return 0 }
        let index = round(offsetXY / itemWH)
        return Int(index)
    }
}
