//
//  WaterModel.swift
//  AppBannerView
//
//  Created by lvlinqing on 15/10/9.
//  Copyright © 2015年 lv. All rights reserved.
//

import UIKit

let imageHeight = 180
let padding  = 5

class WaterModel:WaterBaseModel {

    var text:String?
    var imageUrl:String?
    
    init(text:String,imageUrl:String){
        
        self.text = text
        self.imageUrl = imageUrl
    }
    
     func getCellHeight()->CGFloat{
        let dic = NSDictionary(object: UIFont.systemFontOfSize(CGFloat(15)), forKey: NSFontAttributeName)
        let cellWidth = SCRRENRECT.width/2
        let contentText = text! as NSString
        let textHeight = contentText.boundingRectWithSize(CGSizeMake(cellWidth-10, 3200), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size.height
        return textHeight + CGFloat(imageHeight+padding*2)
        
    }
    
}
