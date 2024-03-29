//
//  FoodListTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 28/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class FoodListTVC: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var descLbl: Label!
    @IBOutlet weak var priceLbl: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : RestaurantMenuModel) {
        setImageBackgroundImage(imgView, dict.get_single_media.url, IMAGE.PLACEHOLDER)
        nameLbl.text = dict.title
        descLbl.text = dict.desc.html2String
        priceLbl.text = displayPriceWithCurrency(dict.price)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
