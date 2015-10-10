//
//  WaterCollectionViewController.swift
//  AppBannerView
//
//  Created by lvlinqing on 15/10/9.
//  Copyright © 2015年 lv. All rights reserved.
//

import UIKit

private let reuseIdentifier = "waterCell"

class WaterCollectionViewController: UICollectionViewController {
    
    private var dataSource:[WaterModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        self.collectionView?.registerClass(WaterCollectionViewCell.self, forCellWithReuseIdentifier: "reuseIdentifier")
        let flowLayout = WaterFlowLayout(columns: 2, cellCount: dataSource!.count)
        flowLayout.layoutDelegate = self
        self.collectionView?.setCollectionViewLayout(flowLayout, animated: true)
        self.collectionView?.bounces = true

        self.collectionView?.footer = MJRefreshAutoNormalFooter(refreshingBlock: {self.collectionView?.footer.endRefreshing()})

    }
    
    func initData(){
        
        dataSource = [WaterModel]()
        
            let model = WaterModel(text: "The word “princess” seems to be a bad word to describe a girl. I saw a real princess in the live show, she is very innocent", imageUrl: "http://a3.qpic.cn/psb?/V12DnVCv4HDP3N/65e5y.cLLIHoLE5sKyVsHbqyAUng4ycFI3aup*tz4Ek!/b/dHIAAAAAAAAA&ek=1&kp=1&pt=0&bo=gALAAwAAAAABAGY!&sce=0-12-12&rf=viewer_311")
            dataSource!.append(model)
        let model1 = WaterModel(text: "The word “princess” seems to be a bad word to describe a girl. I saw a real princess in the live show, she is very innocent, though his father helps her to fulfill her princess dream, she never acts arrogantly.", imageUrl: "http://p0.meituan.net/movie/1f4184f50917f857af37440142f10ee448478.jpg")
        dataSource!.append(model1)
        let model2 = WaterModel(text: "The word “princess” seems to be a bad word to describe a girl. I saw a real princess in the live show, she is very innocent, though his father helps her to fulfill her princess dream, she never acts arrogantly.", imageUrl: "http://p0.meituan.net/movie/1f4184f50917f857af37440142f10ee448478.jpg")
        dataSource!.append(model2)
        let model3 = WaterModel(text: "为什么总推荐大家补水，因为现在所有的美白，抗皱，修复！全都是建立在补水的基础上的！我可以负责任的说，只要你坚持补水，甚至不用做美白也会白起来，一滴墨水，兑的水多了就淡了～只要坚持补水，不用抗皱也平整，一个气球，装满水后表面也就光滑了～只要坚持补水，细胞就有力量自我修复了～所以，补水狠重要!所以你要买这个产品.", imageUrl: "http://a3.qpic.cn/psb?/V10rZR2n2P07ca/tSKf5EXzh38xpTyNLIi.OedzhFQ05r08SiWvSguTpPQ!/b/dHYBAAAAAAAA&ek=1&kp=1&pt=0&bo=gAJUAwAAAAAFB*E!&sce=0-12-12&rf=viewer_4")
        dataSource!.append(model3)
        
        
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
    
   
    

}

extension WaterCollectionViewController:UICollectionViewDelegateFlowLayout,WaterLayoutDelegate{
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(SCRRENRECT.width/2, dataSource![indexPath.row].getCellHeight())
    }
    
    func getItemSize(indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(SCRRENRECT.width/2, dataSource![indexPath.row].getCellHeight())
    }
}

