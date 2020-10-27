//
//  RestaurantListTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 27/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class RestaurantListTVC: UITableViewCell {

    @IBOutlet weak var outerview: View!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var starView: FloatRatingView!
    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var priceLbl: Label!
    @IBOutlet weak var addressLbl: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
