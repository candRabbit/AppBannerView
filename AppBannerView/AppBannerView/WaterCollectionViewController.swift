//
//  WaterCollectionViewController.swift
//  AppBannerView
//
//  Created by lvlinqing on 15/10/9.
//  Copyright © 2015年 lv. All rights reserved.
//

import UIKit

private let reuseIdentifier = "waterCell"

class WaterCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,WaterLayoutDelegate {
    
    private var dataSource:[WaterModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
      self.collectionView?.registerClass(WaterCollectionViewCell.self, forCellWithReuseIdentifier: "reuseIdentifier")
        let flowLayout = WaterFlowLayout(columns: 2, cellCount: dataSource!.count)
        flowLayout.layoutDelegate = self
        self.collectionView?.setCollectionViewLayout(flowLayout, animated: true)

    }
    
    func initData(){
        
        dataSource = [WaterModel]()
        
            let model = WaterModel(text: "九层咬他", imageUrl: "http://p1.meituan.net/movie/f1e42208897d8674bb7aab89fb078baf487236.jpg")
            dataSource!.append(model)
        let model1 = WaterModel(text: "速度哈斯接电话就撒谎的骄傲圣诞节撒谎大花洒带回家速度哈斯接电话就撒谎的骄傲圣诞节撒谎大花洒带回家速度哈斯接电话就撒谎的骄傲圣诞节撒谎大花洒带回家速度哈斯接电话就撒谎的骄傲圣诞节撒谎大花洒带回家", imageUrl: "http://p1.meituan.net/movie/f1e42208897d8674bb7aab89fb078baf487236.jpg")
        dataSource!.append(model1)
        let model2 = WaterModel(text: "的睡觉奥肯德基萨克的金卡是经典款撒娇的大数据库的骄傲是看得见萨克的健康撒", imageUrl: "http://p1.meituan.net/movie/f1e42208897d8674bb7aab89fb078baf487236.jpg")
        dataSource!.append(model2)
        let model3 = WaterModel(text: "大师的撒的撒的煎熬时刻的健康撒娇的凯撒就打开萨家湾i", imageUrl: "http://p1.meituan.net/movie/f1e42208897d8674bb7aab89fb078baf487236.jpg")
        dataSource!.append(model3)
        let model4 = WaterModel(text: "大师的撒打算大神", imageUrl: "http://p1.meituan.net/movie/f1e42208897d8674bb7aab89fb078baf487236.jpg")
        dataSource!.append(model4)
        let model5 = WaterModel(text: "九层咬他", imageUrl: "http://p1.meituan.net/movie/f1e42208897d8674bb7aab89fb078baf487236.jpg")
        dataSource!.append(model5)
        let model6 = WaterModel(text: "九层咬他", imageUrl: "http://p1.meituan.net/movie/f1e42208897d8674bb7aab89fb078baf487236.jpg")
        dataSource!.append(model6)
        
        let model7 = WaterModel(text: "大街上空间大卡涉及到卡上就点击萨克的卷卡式带久爱时空的吉萨肯德基萨克的吉萨的就是卡德加撒空间他", imageUrl: "http://p1.meituan.net/movie/f1e42208897d8674bb7aab89fb078baf487236.jpg")
        dataSource!.append(model7)
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
       
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return dataSource!.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! WaterCollectionViewCell
       
        let model = dataSource![indexPath.row]
        cell.label.text = model.text
        cell.imageView.sd_setImageWithURL(NSURL(string: model.imageUrl!))
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(SCRRENRECT.width/2, dataSource![indexPath.row].getCellHeight())
    }
    
    func getItemSize(indexPath: NSIndexPath) -> CGSize {

        
        return CGSizeMake(SCRRENRECT.width/2, dataSource![indexPath.row].getCellHeight())
    }
    

}

//extension WaterCollectionViewController:UICollectionViewDelegateFlowLayout,WaterLayoutDelegate{
//    
//  
//}

