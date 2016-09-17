//
//  CXYCarouselVIew.swift
//  CXYCarouselView
//
//  Created by chen on 16/4/25.
//  Copyright © 2016年 ___CHEN___. All rights reserved.
//

import UIKit

protocol CXYCarouselViewDelegate {
    func carouselView(_ carouselView: CXYCarouselView, didSelectItemAtIndexPath indexPath: IndexPath)
}

typealias ItemSelectedClosure = (_ carouselView: CXYCarouselView, _ indexPath: IndexPath) -> Void


// MARK: - CXYCarouselViewCell
class CXYCarouselViewCell: UICollectionViewCell {
    
    fileprivate lazy var imgView: UIImageView? = {
        let imgView = UIImageView(frame: self.contentView.bounds)
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.backgroundColor = UIColor.white
        self.contentView.addSubview(imgView)
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - CXYCarouselView
class CXYCarouselView: UIView {

    fileprivate lazy var collectionView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(CXYCarouselViewCell.self, forCellWithReuseIdentifier:String(describing: CXYCarouselViewCell.self))
        return collectionView
    }()
    
    fileprivate lazy var pageControl: UIPageControl! = {
        let pageControl = UIPageControl()
        pageControl.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 20)
        pageControl.center = CGPoint(x: self.center.x, y: self.bounds.size.height-20)
        pageControl.defersCurrentPageDisplay = true
        return pageControl
    }()
    
    fileprivate var timer: Timer?
    
    fileprivate var _imageUrls = [String]();
    
    fileprivate var isNeedAutoScroll: Bool {
        return self._imageUrls.count > 1 && Int(self.duration) > 0
    }
    
    var imageUrls: [String]? {
        didSet {
            if let imageUrls = imageUrls , imageUrls.count > 1 {
                var images = [String]()
                images.append(imageUrls.last!)
                images += imageUrls
                images.append(imageUrls.first!)
                self.imageUrls = images
                
                self._imageUrls = images;
                
                self.pageControl.numberOfPages = imageUrls.count

                self.collectionView.reloadData()
                self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
                
                if  self.isNeedAutoScroll {
                    self.addTimer()
                }
            } else {
                self.collectionView.reloadData()
            }
        }
    }

    var duration :Double = 3.0 {
        didSet {
            if self.isNeedAutoScroll {
                self.addTimer()
            } else {
                self.removeTimer()
            }
        }
    }
    
    var delegate: CXYCarouselViewDelegate?
    var itemSelectedClosure: ItemSelectedClosure?
    var placeholderImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.removeTimer()
        self.delegate = nil
    }
    
    func setup() {
        self.addSubview(self.collectionView)
        self.addSubview(self.pageControl)
    }
    
    
}

// MARK: - NSTimer Func
extension CXYCarouselView {
    
    func addTimer() {
        self.removeTimer()
        
        self.timer = Timer.scheduledTimer(timeInterval: self.duration,repeats: true) {
            [unowned self] (timer: Timer) in
             self.nextPage()
            }
        
        RunLoop.main.add(self.timer!, forMode: RunLoopMode.commonModes)
        self.timer!.fireDate = Date(timeIntervalSinceNow: self.duration)
    }
    
    func removeTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func pauseTimer() {
        self.timer?.fireDate = Date.distantFuture
    }
    
    func resumeTimer() {
        self.timer?.fireDate = Date(timeIntervalSinceNow: self.duration)
    }
}

// MARK: - Private Func
extension CXYCarouselView {
    func nextPage() {
        let currentIndexPath = self.collectionView.indexPathForItem(at: self.collectionView.contentOffset)!
        let nextIndexPath = IndexPath(item: (currentIndexPath as NSIndexPath).item+1, section: 0)
        self.collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    func updateScroll() {
        
        let offset = self.collectionView.contentOffset
        if offset.x <= 0 {
            let indexPath = IndexPath(item: self._imageUrls.count-2, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
        
        if offset.x >= CGFloat(self._imageUrls.count-1) * self.bounds.size.width {
            let indexPath = IndexPath(item: 1, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    func updatePage() {
        let indexPath = self.collectionView.indexPathForItem(at: self.collectionView.contentOffset)!
        
        let count = self._imageUrls.count
        if count == 1 {
            return;
        }
        
        let item = (indexPath as NSIndexPath).item
        if item == 0 {
            self.pageControl.currentPage = count - 3
        } else if item == count-1 {
            self.pageControl.currentPage = 0
        } else {
            self.pageControl.currentPage = item - 1
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CXYCarouselView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self._imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CXYCarouselViewCell.self), for: indexPath) as! CXYCarouselViewCell
        
        //configure your image
        cell.imgView?.image = UIImage(named:self._imageUrls[(indexPath as NSIndexPath).item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CXYCarouselView:  UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

        if self.isNeedAutoScroll {
            self.pauseTimer()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.isNeedAutoScroll {
            self.resumeTimer()
        }
        self.updatePage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateScroll()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.updatePage()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.updatePage()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedIndexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
        self.delegate?.carouselView(self, didSelectItemAtIndexPath: selectedIndexPath)
        self.itemSelectedClosure?(self,selectedIndexPath)
    }
}


//使用闭包，避免NSTimer造成引用循环
extension Timer {
    typealias TimerClosure = @convention(block)(Timer) -> Void
    
    class func scheduledTimer(timeInterval ti: TimeInterval, repeats yesOrNo: Bool, closure aClosure: TimerClosure) -> Timer {
        
        let timer = Timer.scheduledTimer(timeInterval: ti, target: self, selector: #selector(Timer.timerClosure(_:)), userInfo: unsafeBitCast(aClosure,to: Timer.self), repeats: yesOrNo)
        return timer
    }
    
    class func timerClosure(_ timer: Timer) -> Void {
        let closure = unsafeBitCast(timer.userInfo, to: TimerClosure.self)
        closure(timer)
    }
}

