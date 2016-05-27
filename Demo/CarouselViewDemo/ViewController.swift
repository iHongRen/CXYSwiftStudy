//
//  ViewController.swift
//  CarouselViewDemo
//
//  Created by chen on 16/5/9.
//  Copyright © 2016年 ___CHEN___. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let carouselView = CXYCarouselView(frame: CGRect(x: 0, y: 20, width: self.view.bounds.size.width, height: self.view.bounds.size.width*0.6))
        carouselView.duration = 5
        carouselView.imageUrls = ["1", "2", "3", "4"]
        carouselView.placeholderImage = UIImage(named: "1")
        //carouselView.delegate = self
        carouselView.itemSelectedClosure = {
            (carouselView: CXYCarouselView, indexPath: NSIndexPath) -> Void in
            print(indexPath.item)
        }
        self.view.addSubview(carouselView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: - CXYCarouselViewDelegate
extension ViewController: CXYCarouselViewDelegate {
    func carouselView(carouselView: CXYCarouselView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.item)
    }
}