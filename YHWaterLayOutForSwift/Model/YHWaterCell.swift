//
//  YHWaterCell.swift
//  YHWaterLayOutForSwift
//
//  Created by t4 on 17/4/10.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit
import Kingfisher

class YHWaterCell: UICollectionViewCell {

    /**展示图片的视图*/
    @IBOutlet weak var iconImageView: UIImageView!
    /**展示价格的视图*/
    @IBOutlet weak var priceLabel: UILabel!
    
    var shopModel : YHShopModel?{
    
        didSet {
           
            self.iconImageView.kf.setImage(with: URL(string: (shopModel?.img)!))
            self.priceLabel.text = shopModel?.price
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
