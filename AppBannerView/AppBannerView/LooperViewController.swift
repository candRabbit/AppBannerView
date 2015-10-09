//
//  LooperViewController.swift
//  AppBannerView
//
//  Created by lvlinqing on 15/10/9.
//  Copyright © 2015年 lv. All rights reserved.
//

import UIKit

class LooperViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let looperPhoto = LooperPhoto(frame: self.view.bounds)
        self.view.addSubview(looperPhoto)
        let path = NSBundle.mainBundle().pathForResource("photo", ofType: ".json")
        let data = NSData(contentsOfFile: path!)
        let json = JSON(data: data!)
        let datas = json["data"].arrayValue
        var imageUrls = [String]()
        for photoJson in datas{
            let imageUrlPath =  photoJson["olink"].stringValue.stringByReplacingOccurrencesOfString("w.h/", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            imageUrls.append(imageUrlPath)
        }
        looperPhoto.setImageDataSource(imageUrls, imageType: .Web)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
