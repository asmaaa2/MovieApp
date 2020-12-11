//
//  HomeCell.swift
//  MovieList
//
//  Created by Elattar on 3/9/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var posterMovie_img: UIImageView!
    
    @IBOutlet weak var titleMovie_lbl: UILabel!
    @IBOutlet weak var rate_lbl: UILabel!
    
    override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
         posterMovie_img.layer.cornerRadius = 10.0
         posterMovie_img.layer.masksToBounds = true
     }
     
     override func layoutSubviews() {
         super.layoutSubviews()
         self.layer.cornerRadius = 3.0
         layer.shadowRadius = 10
         layer.shadowOpacity = 0.2
         layer.shadowOffset = CGSize(width: 5, height: 10)
         self.clipsToBounds = false
     }
}
