//
//  WaterModel.swift
//  AppBannerView
//
//  Created by lvlinqing on 15/10/9.
//  Copyright © 2015年 lv. All rights reserved.
//

import UIKit

class WaterModel:WaterBaseModel {

    var text:String?
    var imageUrl:String?
    
    init(text:String,imageUrl:String){
        
        self.text = text
        self.imageUrl = imageUrl
    }
    
    
     func getCellHeight()->CGFloat{
        let dic = UIFont.systemFontOfSize(15).fontDescriptor().fontAttributes()

        let cellWidth = SCRRENRECT.width
        let contentText = text! as NSString
        let textHeight =  contentText.boundingRectWithSize(CGSizeMake(cellWidth/2, 3200), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: dic, context: nil).height
        print(textHeight)
        let imageHeight = cellWidth/2
        return textHeight + imageHeight
        
    }
    
}
