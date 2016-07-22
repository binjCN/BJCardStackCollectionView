//
//  BJCollectionViewCell.swift
//  BJLookupData
//
//  Created by binj on 16/6/17.
//  Copyright © 2016年 binj. All rights reserved.
//

import UIKit

class BJCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    var title: String?
    
    var imageStr: String?{
        didSet{
            
            guard self.imageStr != nil else{
                return
            }
            self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
            self.imageView?.layer.cornerRadius = 10
            self.imageView?.layer.masksToBounds = true
            self.imageView?.image = UIImage(named: self.imageStr!)
        }
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.imageView = UIImageView()
        
        self.addSubview(imageView!)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = self.bounds
    }
    
    
    // 使用required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
