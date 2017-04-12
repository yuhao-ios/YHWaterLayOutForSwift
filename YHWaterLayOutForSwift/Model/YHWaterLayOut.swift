//
//  YHWaterLayOut.swift
//  YHWaterLayOutForSwift
//
//  Created by t4 on 17/4/10.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

//MARK:代理协议

@objc protocol YHWaterLayOutDelegate : NSObjectProtocol
{

    /**
     * waterLayout:布局对象
     * width  计算出来的cell宽度
     * indexPath cell所在行
     * return  由cell宽度以及原图的尺寸计算出来的等比例高度
     */
    func  WaterLayOut(_waterLayout: YHWaterLayOut, cellForWidth width: CGFloat, heightForRowAtIndexPath indexPath:IndexPath) -> CGFloat
    /**
     * waterLayout:布局对象
     * return 使用者设置的列数
     */

    @objc optional func  waterLayOutForCellCloumnNum(_waterLayout : YHWaterLayOut)->NSInteger
    /**
     * waterLayout:布局对象
     * return 使用者设置的列数
     */
    @objc optional func  waterLayOutForCellCloumnMargin(_waterLayout : YHWaterLayOut)->CGFloat
    /**
     * waterLayout:布局对象
     * return 使用者设置的行间距
     */
    @objc optional func  waterLayOutForCellRowMargin(_waterLayout : YHWaterLayOut)->CGFloat
    /**
     * waterLayout:布局对象
     * return 使用者设置的四周边距
     */
    @objc optional func  waterLayOutForCellInSets(_waterLayout : YHWaterLayOut)->UIEdgeInsets
}


class YHWaterLayOut: UICollectionViewLayout {

    //MARK: - 懒加载  
    //TODO:- 存放所有布局属性的数组
    lazy var attributesArray : [UICollectionViewLayoutAttributes] = {
    
      let array = [UICollectionViewLayoutAttributes]()
        
        return array;

    }()
    
    //TODO: - 存放每一列最大y值的数组
    lazy var maxYArray : NSMutableArray = {
        
        let array = NSMutableArray()
        
        return array;
        
    }()
    
    

    //MARK:- 变量的声明
    //代理
    weak var delegate : YHWaterLayOutDelegate?
    
    /**默认的行间距*/
    var defaultRowMargin : CGFloat = 10
    /**默认的列间距*/
    var defaultCloumnMargin :CGFloat = 10
    /**默认的列数*/
    var defaultCloumnNum : NSInteger = 3
    /**默认的四周间距*/
    var defaultInsets : UIEdgeInsets =  UIEdgeInsetsMake(10, 10, 10, 10)
    
       //MARK: - 初始化
    override func prepare() {
        
        
  
        
        //移除上一次的最大Y值的数组
        
        self.maxYArray.removeAllObjects()
        
        
        if   let  num   =  self.delegate?.waterLayOutForCellCloumnNum?(_waterLayout: self){
            
            self.defaultCloumnNum = num//将用户返回的列数赋值
        }
        
        if let  cellCloumnMargin =  self.delegate?.waterLayOutForCellCloumnMargin?(_waterLayout: self) {
            
            self.defaultCloumnMargin = cellCloumnMargin
        }
        
        if let  cellRowMargin =  self.delegate?.waterLayOutForCellRowMargin?(_waterLayout: self) {
            
            self.defaultRowMargin = cellRowMargin
        }
        
        if let  cellEdgInsets =  self.delegate?.waterLayOutForCellInSets?(_waterLayout: self) {
            
            self.defaultInsets = cellEdgInsets
        }
//
        
        //当程序第一次运行时  给每一列 最大y值 赋值 初始值应为上边距
        
         for  _  in 0 ..< Int(defaultCloumnNum){
        
            self.maxYArray.add(defaultInsets.top)
        }
        
        //移除上一次存放的布局属性
        self.attributesArray.removeAll()
        
               //获取collectionViewCell的总数
        let count  =  self.collectionView?.numberOfItems(inSection: 0);
        //便利找到当前cell所在的位置
        for  i  in 0 ..< count!{
            
            let indexPath = IndexPath.init(item: i, section: 0);
            
            //创建布局属性
            let attributes = self.layoutAttributesForItem(at: indexPath)
            
            //添加到数组中
            self.attributesArray.append(attributes!)
        }
    }
    
    
    
    //MARK: - 返回布局属性数组
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        
        
        return self.attributesArray ;
        
    }
    
    
    
    
    //MARK: -返回布局属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        //创建布局属性
        let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath as IndexPath)
        
        //屏幕宽度
        let width = self.collectionView?.frame.size.width
        //屏幕宽度-左右两边间距
        let widthForRightAndLeft : CGFloat  = (width! - defaultInsets.left-defaultInsets.right)
        //所有列之间总间距
        let widthAllMargin : CGFloat = CGFloat(defaultCloumnNum-1)*defaultCloumnMargin
        //屏幕宽度-左右两边间距-所有列之间总间距)/默认列数
        let w : CGFloat = (widthForRightAndLeft-widthAllMargin)/CGFloat(defaultCloumnNum)
        
        
        /*图片需要放到最短那一列 所以 找到最短那一列的高度 以及列号*/
        var destNum  = 1
        var destCloumnHeight  = MAXFLOAT
        
        for  i  in  0 ..< self.maxYArray.count {
        
           //取出每一列最大y值
            let cellHeight : CGFloat = self.maxYArray[i] as! CGFloat
            //比较大小
            if cellHeight < CGFloat(destCloumnHeight) {
                
                destCloumnHeight = Float(cellHeight);//重新对最短那列的高度赋值
                destNum = i //最短那一列
            }
        }
        
        /**最短那一列的x为  最短那一列行号*(cell宽度+列间距)+左边距*/
        let x : CGFloat =  defaultInsets.left+(w+defaultCloumnMargin)*CGFloat(destNum)
    
        /**默认 第一行时   最短那列的y = 默认的上边距 */
        var y : CGFloat = CGFloat(destCloumnHeight)
        /**当 不等于上边距时  就不是第一行  那时需要加上行间距*/
        
        print(y)
        if y != defaultInsets.top {
            
            y += defaultRowMargin
                  print(y)
        }
 
        /**强制执行代理方法  由使用者根据图片原尺寸等比例返回高度*/
        let h : CGFloat = (self.delegate!.WaterLayOut(_waterLayout: self, cellForWidth: w, heightForRowAtIndexPath: indexPath))
        
        /**获取布局属性最终的frame*/
        attributes.frame = CGRect(x: x, y: y, width: w, height: h)
        
        /**添加布局属性后 最短那一列高度发生改变  更新最短那一列在数组中的高度*/
        self.maxYArray[destNum] =  attributes.frame.maxY
        
        return attributes;
    }
    
    
   //MARK: - 返回所占尺寸
   override var collectionViewContentSize: CGSize{
    
    
    //找到最长那一列的高度

    var destCloumnHeight : CGFloat = 0
    
    for  i  in  0 ..< self.maxYArray.count {
        
        //取出每一列最大y值
        let cellHeight : CGFloat = self.maxYArray[i] as! CGFloat
        //比较大小
        if cellHeight > destCloumnHeight {
            
            destCloumnHeight = cellHeight;//重新对最长那列的高度赋值
        }
    }

      return CGSize(width: 0, height: destCloumnHeight+defaultInsets.bottom)
    
    }
    

}
