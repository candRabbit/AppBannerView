//
//  ViewController.swift
//  AppBannerView
//
//  Created by 林青 吕 on 15/10/8.
//  Copyright © 2015年 lv. All rights reserved.
//

import UIKit

class ViewController: UIViewController,PageChangeDelegate {
 var pageControl:UIPageControl?
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let appBannerView = AppBannerView(frame: CGRectMake(0, 64, self.view.bounds.width, 220),photos: bannerPhotos)
        appBannerView.pageChangeDelegate = self
        self.view.addSubview(appBannerView)
        
        pageControl = UIPageControl(frame: CGRectMake(0, 250, self.view.bounds.width, 20))
        pageControl!.numberOfPages = 4
        pageControl!.currentPage = 0
        pageControl!.enabled = false
    
        self.view.addSubview(pageControl!)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pageChange(index: Int) {
        pageControl!.currentPage = index
    }

}

