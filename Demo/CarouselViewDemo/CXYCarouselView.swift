//
//  CXYCarouselVIew.swift
//  CXYCarouselView
//
//  Created by chen on 16/4/25.
//  Copyright © 2016年 ___CHEN___. All rights reserved.
//

import UIKit

protocol CXYCarouselViewDelegate {
    func carouselView(carouselView: CXYCarouselView, didSelectItemAtIndexPath indexPath: NSIndexPath)
}

typealias ItemSelectedClosure = (carouselView: CXYCarouselView, indexPath: NSIndexPath) -> Void


// MARK: - CXYCarouselViewCell
class CXYCarouselViewCell: UICollectionViewCell {
    
    private lazy var imgView: UIImageView? = {
        let imgView = UIImageView(frame: self.contentView.bounds)
        imgView.contentMode = .ScaleAspectFill
        imgView.clipsToBounds = true
        imgView.backgroundColor = UIColor.whiteColor()
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

    private lazy var collectionView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.scrollDirection = .Horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.pagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.registerClass(CXYCarouselViewCell.self, forCellWithReuseIdentifier:String(CXYCarouselViewCell))
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl! = {
        let pageControl = UIPageControl()
        pageControl.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 20)
        pageControl.center = CGPointMake(self.center.x, self.bounds.size.height-20)
        pageControl.defersCurrentPageDisplay = true
        return pageControl
    }()
    
    private var timer: NSTimer?
    
    private var _imageUrls = [String]();
    
    private var isNeedAutoScroll: Bool {
        return self._imageUrls.count > 1 && Int(self.duration) > 0
    }
    
    var imageUrls: [String]? {
        didSet {
            if let imageUrls = imageUrls where imageUrls.count > 1 {
                var images = [String]()
                images.append(imageUrls.last!)
                images += imageUrls
                images.append(imageUrls.first!)
                self.imageUrls = images
                
                self._imageUrls = images;
                
                self.pageControl.numberOfPages = imageUrls.count

                self.collectionView.reloadData()
                self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
                
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
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(self.duration, target: self, selector: #selector(CXYCarouselView.nextPage), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(self.timer!, forMode: NSRunLoopCommonModes)
        self.timer!.fireDate = NSDate(timeIntervalSinceNow: self.duration)
    }
    
    func removeTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func pauseTimer() {
        self.timer?.fireDate = NSDate.distantFuture()
    }
    
    func resumeTimer() {
        self.timer?.fireDate = NSDate(timeIntervalSinceNow: self.duration)
    }
}

// MARK: - Private Func
extension CXYCarouselView {
    func nextPage() {
        let currentIndexPath = self.collectionView.indexPathForItemAtPoint(self.collectionView.contentOffset)!
        let nextIndexPath = NSIndexPath(forItem: currentIndexPath.item+1, inSection: 0)
        self.collectionView.scrollToItemAtIndexPath(nextIndexPath, atScrollPosition: .CenteredHorizontally, animated: true)
    }
    
    func updateScroll() {
        
        let offset = self.collectionView.contentOffset
        if offset.x <= 0 {
            let indexPath = NSIndexPath(forItem: self._imageUrls.count-2, inSection: 0)
            self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: false)
        }
        
        if offset.x >= CGFloat(self._imageUrls.count-1) * self.bounds.size.width {
            let indexPath = NSIndexPath(forItem: 1, inSection: 0)
            self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: false)
        }
    }
    
    func updatePage() {
        let indexPath = self.collectionView.indexPathForItemAtPoint(self.collectionView.contentOffset)!
        
        let count = self._imageUrls.count
        if count == 1 {
            return;
        }
        
        let item = indexPath.item
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
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self._imageUrls.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(CXYCarouselViewCell), forIndexPath: indexPath) as! CXYCarouselViewCell
        
        //configure your image
        cell.imgView?.image = UIImage(named:self._imageUrls[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CXYCarouselView:  UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {

        if self.isNeedAutoScroll {
            self.pauseTimer()
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.isNeedAutoScroll {
            self.resumeTimer()
        }
        self.updatePage()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.updateScroll()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.updatePage()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.updatePage()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let selectedIndexPath = NSIndexPath(forItem: self.pageControl.currentPage, inSection: 0)
        self.delegate?.carouselView(self, didSelectItemAtIndexPath: selectedIndexPath)
        self.itemSelectedClosure?(carouselView: self,indexPath: selectedIndexPath)
    }
}
