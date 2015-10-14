//
//  AppBannerView.swift
//  IHelp
//
//  Created by lvlinqing on 15/9/16.
//  Copyright (c) 2015年 dianhelp. All rights reserved.
//

import UIKit
// 无限循环轮播图片
class AppBannerView: UIScrollView,UIScrollViewDelegate{

    
    var pageChangeDelegate:PageChangeDelegate?
    //记录当前的page
    var currentPage = 0
    var photos:[String]?
    var autoScroll = true
    var nsTimer:NSTimer?
    
    
    init(frame:CGRect,photos:[String]!){
         self.photos = photos
         super.init(frame: frame)
         initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        initView()
    }
    
    func initView(){
        
        self.delegate = self
        self.pagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        for (var i = 0;i<3;i++){
           let view = UIImageView(frame: CGRectMake(self.bounds.width*CGFloat(i), 0, self.bounds.width, self.bounds.height))
            view.contentMode = UIViewContentMode.ScaleToFill
            
            var imageUrl:NSURL?
            if i == 0{
                imageUrl = NSURL(string: photos![photos!.count-1])
            }else if i == 2{
                imageUrl = NSURL(string: photos![1])
            }else{
                imageUrl = NSURL(string: photos![0])
            }
            
            view.sd_setImageWithURL(imageUrl)
            self.addSubview(view)
            
        }
         self.contentSize = CGSizeMake(self.bounds.width*CGFloat(photos!.count), 0)
         self.setContentOffset(CGPoint(x: self.bounds.width, y: 0), animated: false)
        
        if autoScroll{
           
        nsTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("startScroll"), userInfo: nil, repeats: true)
        }
    }
    
    
    func showPageIndex(index:Int){
        
        if index > currentPage{
         
            self.setContentOffset(CGPointMake(self.bounds.width*2, 0), animated: true)
        }else{
            self.setContentOffset(CGPointMake(0, 0), animated: true)
        }
    }
    
    func setDataSource(photos:[String]!){
        
        self.photos = photos
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if abs((scrollView.contentOffset.x - self.bounds.width)) >= self.bounds.width{
            
            if scrollView.contentOffset.x == 0{
                currentPage  = currentPage - 1
                if currentPage == -1 {
                    
                    currentPage = photos!.count-1
                }
            }else{
                
                currentPage =  currentPage + 1
                
                if currentPage == photos!.count{
                    
                    currentPage = 0
                }
                
            }
            pageChangeDelegate?.pageChange(currentPage)
            
            self.setContentOffset(CGPoint(x: self.bounds.width, y: 0), animated: false)
            let imageView =  self.subviews[1] as! UIImageView
            imageView.sd_setImageWithURL(NSURL(string: photos![currentPage])!)
            let leftImageView = self.subviews[0] as! UIImageView
            if currentPage-1 == -1{
                
                leftImageView.sd_setImageWithURL(NSURL(string: photos![photos!.count-1]))
            }else{
                leftImageView.sd_setImageWithURL(NSURL(string: photos![currentPage-1]))
            }
            let rightImageView = self.subviews[2] as! UIImageView
            if currentPage+1 == photos!.count {
                rightImageView.sd_setImageWithURL(NSURL(string: photos![0]))
            }else{
                rightImageView.sd_setImageWithURL(NSURL(string: photos![currentPage+1]))
            }
        }
        
        
    }
    
    
    func startScroll(){

        self.showPageIndex(currentPage+1)
    }
    
    func stopScroll(){
        
       nsTimer?.invalidate()
    }
    
    
    
    //默认滚动位置 屏幕的宽度按
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
    
    }
    
    
    func setBannerViewAutoScroll(autoScroll:Bool){
    
        self.autoScroll = autoScroll
        
        if !autoScroll{
            
            stopScroll()
        }
        
    }
    
   
    
}

protocol PageChangeDelegate{
    
    func pageChange(index:Int)
}


