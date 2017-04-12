//
//  YHShopModel.swift
//  YHWaterLayOutForSwift
//
//  Created by t4 on 17/4/10.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

class YHShopModel: NSObject {

    /**图片高*/
    var h : NSNumber?
    /**图片宽*/
    var w :NSNumber?
    /**价格*/
    var price : String?
     /**图片名*/
    var img   : String?
    
    //数据转模型
    init(dict:[String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }

    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
