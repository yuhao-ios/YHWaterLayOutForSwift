//
//  ViewController.swift
//  YHWaterLayOutForSwift
//
//  Created by t4 on 17/4/10.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!
   
    //存放数据的可变数组
    var dataArray : NSMutableArray = {
        
        let array = NSMutableArray()
        
        return array
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.collectionView.delegate = self
        
        self.collectionView.dataSource = self
        
        let  layout = YHWaterLayOut()
        
             layout.delegate = self;
        
        self.collectionView.collectionViewLayout = layout
        
        self.collectionView.register(UINib.init(nibName: "YHWaterCell", bundle: nil), forCellWithReuseIdentifier: "waterCell")
        
        self .loadShopData()
        
    }

    //加载数据
    fileprivate func  loadShopData() {
    
        let path  = Bundle.main.path(forResource: "1.plist", ofType: nil)
    
        let array = NSArray(contentsOfFile: path!)
        
        for dict in array! {
            
            let  dic = dict as! [String : AnyObject]
            
            let model = YHShopModel.init(dict: dic)
            
            self.dataArray.add(model)
            
        }
        
    }
    

}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,YHWaterLayOutDelegate{


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        return self.dataArray.count;
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
          let   cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: "waterCell", for: indexPath) as! YHWaterCell
         cell.shopModel = self.dataArray[indexPath.item] as? YHShopModel;
        return cell
    }
    
    //流水布局代理
    func WaterLayOut(_waterLayout: YHWaterLayOut, cellForWidth width: CGFloat, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        let model = self.dataArray[indexPath.item] as! YHShopModel;
        let  imageH = CGFloat(model.h!)
        let  imageW = CGFloat(model.w!)
        let h = (imageH)*width/(imageW)
        return h
    }
  
    func waterLayOutForCellCloumnNum(_waterLayout: YHWaterLayOut) -> NSInteger {
        
        
        return  4
    }
    
    func waterLayOutForCellInSets(_waterLayout: YHWaterLayOut) -> UIEdgeInsets {
    
        return UIEdgeInsetsMake(50, 40, 20, 10)
    }
    
    func waterLayOutForCellRowMargin(_waterLayout: YHWaterLayOut) -> CGFloat {
        
        return 40
    }
    
    func waterLayOutForCellCloumnMargin(_waterLayout: YHWaterLayOut) -> CGFloat {
        
        return 40
    }
}
