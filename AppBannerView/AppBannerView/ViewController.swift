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
        
        let photos = ["http://p1.meituan.net/movie/f1e42208897d8674bb7aab89fb078baf487236.jpg",
            "http://p1.meituan.net/movie/aa3c2bac8f9aaa557e63e20d56e214dc192471.jpg",
            "http://p0.meituan.net/movie/07b7f22e2ca1820f8b240f50ee6aa269481512.jpg"
            ,"http://p1.meituan.net/movie/395266f5f470b027ed1ac87110b03b88149862.jpg"]
        
        let appBannerView = AppBannerView(frame: CGRectMake(0, 0, self.view.bounds.width, 220),photos: photos)
        appBannerView.pageChangeDelegate = self
        self.view.addSubview(appBannerView)
        
        pageControl = UIPageControl(frame: CGRectMake(0, 190, self.view.bounds.width, 20))
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

