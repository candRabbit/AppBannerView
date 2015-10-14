
//
//  WaterFlowLayout.swift
//  IHelp
//
//  Created by lvlinqing on 15/9/11.
//  Copyright (c) 2015年 dianhelp. All rights reserved.
//

import UIKit
let SCRRENRECT = UIScreen.mainScreen().bounds
/// 利用collectionView 实现瀑布流效果
class WaterFlowLayout: UICollectionViewLayout {

    var layoutDelegate:WaterLayoutDelegate?
    private var maxY:CGFloat?
    private var cellCount:Int?
    private var columns:Int?
    private var maxHeight:CGFloat = 0
    //横向间距
    private var horizontalSpace:CGFloat?
    //纵向间距
    private var verticalSpace:CGFloat?
    
    
    init(columns:Int!,cellCount:Int!) {
        self.columns = columns
        self.cellCount = cellCount
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setHorizontalSpace(horizontalSpace:CGFloat)
        
    {
        self.horizontalSpace = horizontalSpace
    }
    
    func setVerticalSpace(verticalSpace:CGFloat){
        
        self.verticalSpace = verticalSpace
    }
    /**
    准备布局
    可以做一些初始化工作
    */
    override func prepareLayout(){
        super.prepareLayout()
    
    }
    
    /**
     返回collectionView活动范围
    - returns: <#return value description#>
    */
    override func collectionViewContentSize() -> CGSize{
        return CGSizeMake(SCRRENRECT.width, maxHeight)
    }
   
    /**
    返回所有布局
    - parameter rect: <#rect description#>
    
    - returns: <#return value description#>
    */
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var array  = [UICollectionViewLayoutAttributes]()
        for (var i = 0;i<cellCount!;i++){
            let layoutAttributes = layoutAttributesForItemAtIndexPath(NSIndexPath(forRow: i, inSection:0))
            array.append(layoutAttributes!)
        }
        
        return array
    }
    
    /**
    返回指定布局
    
    - parameter indexPath: <#indexPath description#>
    
    - returns: <#return value description#>
    */
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes?{
        
     let size = self.layoutDelegate?.getItemSize(indexPath)

     let cellRow = indexPath.row+1
     _ = size?.width
     _ = size?.height
        
      
     /**
      1  2  3
         5  6
      4
        */
     //要算出当前第几列 当前第几行 该行上一行的相同的列的XY 坐标
     //举个例子 比如当前是row 是5 那么上一行相同列就是 2
       //算出当前第几行
       var currentRow = cellRow/columns!
        if(cellRow == columns!*currentRow){
            currentRow = currentRow-1
        }
        //算出当前行的列
       let currentColumn =  cellRow - (currentRow*columns!)
       let layoutAttributes =  UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        if currentRow>0{
        var cellY:CGFloat = 0.0
        for (var i = 1;i<currentRow+1;i++){
            let row = cellRow - i*columns!-1
             let cellSize = self.layoutDelegate?.getItemSize(NSIndexPath(forRow: row, inSection: 0))
             cellY += cellSize!.height
        }
        
        let itemWidth = SCRRENRECT.width/CGFloat(columns!)
        let cellX:CGFloat = itemWidth*CGFloat(currentColumn-1)
        
        layoutAttributes.frame = CGRectMake(cellX, cellY, size!.width, size!.height)
        maxHeight = max(maxHeight, cellY+size!.height)
            
        }else{
            let itemWidth = SCRRENRECT.width/CGFloat(columns!)
            let cellX:CGFloat = itemWidth*CGFloat(cellRow-1)
            layoutAttributes.frame = CGRectMake(cellX, 0, size!.width, size!.height)
            maxHeight = max(maxHeight,size!.height)
        }
        return layoutAttributes
    }
}


protocol WaterLayoutDelegate{
    
    func getItemSize(indexPath:NSIndexPath)->CGSize
}
