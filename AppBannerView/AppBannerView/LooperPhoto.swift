//
//  LooperPhoto.swift
//  IHelp
//
//  Created by lvlinqing on 15/9/15.
//  Copyright (c) 2015年 dianhelp. All rights reserved.
//

import UIKit

let screenBounds = UIScreen.mainScreen().bounds
//可循环利用的ScrollView
class LooperPhoto: UIScrollView,UIScrollViewDelegate{
    
    typealias CallBack = (a:Int,b:Int)->Int
    // 缓存的图片控件
    var cacheImages = NSMutableArray()
    // 活动的图片控件
    var actionImages = NSMutableArray()
//    var photos:[JSON]?
    private var dataSources:[AnyObject]?
    var imageType = ImageType.Web
    
    var pageCount = 0{
        didSet{
            if pageCount>oldValue{
               self.contentSize =  CGSizeMake(CGFloat(pageCount)*CGRectGetWidth(self.bounds), 0)
           }
        }
    }
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       initSetting()

    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        initSetting()
    }
    
    private func initSetting(){
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.pagingEnabled = true
        self.delegate = self
    }
    
    func setCurrentPage(page:Int){
        self.setContentOffset(CGPointMake(CGFloat(page)*screenBounds.width, 0), animated: false)
    }

    
    func setImageDataSource(dataSouce:[AnyObject],imageType:ImageType){
        self.pageCount = dataSouce.count
        self.imageType = imageType
        self.dataSources = dataSouce
        showImageAtIndex(0)
    }
    
    
    func showImageAtIndex(index:Int){
     
        var imageView:UIImageView?
        if (cacheImages.count == 0){
          imageView = getImageView(index)
        }else{
          imageView = cacheImages.firstObject as? UIImageView
          imageView?.frame.origin.x = CGFloat(index)*self.bounds.width
          cacheImages.removeObjectAtIndex(0)
        }
        setImageToImageView(index,imageView: imageView!)
        imageView!.tag = index
        actionImages.addObject(imageView!)
        self.addSubview(imageView!)
    }

    
    private func setImageToImageView(index:Int,imageView:UIImageView){
      
        let data:AnyObject = dataSources![index]
        var image:UIImage?
        
        switch imageType{
        case .Local:
          let alAsset =  data as! ALAsset
          image = UIImage(CGImage: alAsset.defaultRepresentation().fullScreenImage().takeUnretainedValue())
        case .Web:
           let imageUrl  = data as! String
           imageView.sd_setImageWithURL(NSURL(string: imageUrl))
        case .Resource:
            let resourceName = data as! String
            image = UIImage(named: resourceName)
        }
        
        if (nil != image){
            imageView.image = image!
        }
    }
    
    func getImageView(index:Int)->UIImageView{
  
        let width = CGRectGetWidth(self.bounds)
        let imageView = UIImageView()
        var frame = self.bounds
        frame.origin.x = CGFloat(index)*width

        imageView.frame = frame
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        return imageView
    }
    //总共就2个image控件
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let scrollViewBounds = scrollView.bounds
        let minX = CGRectGetMinX(scrollViewBounds)
        let maxX = CGRectGetMaxX(scrollViewBounds)
        var firstIndex = Int(minX/scrollViewBounds.width)
        var lastIndex = Int(maxX/scrollViewBounds.width)
        if firstIndex<0{
            firstIndex = 0
        }
        if lastIndex >= pageCount{
            lastIndex = pageCount-1
        }
        
        var tempImagesArrary = [UIImageView]()
        for imageView in actionImages{
            let index = imageView.tag
          
            if index<firstIndex || index>lastIndex{
                imageView.removeFromSuperview()
                tempImagesArrary.append(imageView as! UIImageView)
                cacheImages.addObject(imageView)
            }
        }
        
        for imageView in tempImagesArrary{
            
            actionImages.removeObject(imageView)
        }
        
        //TOO-DO 这里要将不显示的imageView从ActionImages移除
        for (var i = firstIndex;i<=lastIndex;i++){
            var isShowNewImage = true
            for imageview in actionImages{
                let tagIndex = imageview.tag
                if tagIndex == i{
                   isShowNewImage = false
                }
            }
            if isShowNewImage{
                showImageAtIndex(i)
            }
            
        }
    
    }
    
    enum ImageType{
        
     case Local,Web,Resource
    }
}
