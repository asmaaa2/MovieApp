//
//  FavoCell.swift
//  MovieList
//
//  Created by Elattar on 3/15/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import UIKit
import Cosmos

class FavoCell: UITableViewCell {

    @IBOutlet weak var poster_img: UIImageView!
    @IBOutlet weak var movieTitle_lbl: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rateView.settings.updateOnTouch = false

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
