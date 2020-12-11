//
//  ReviewCell.swift
//  MovieList
//
//  Created by Elattar on 3/17/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var contant_tv: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
