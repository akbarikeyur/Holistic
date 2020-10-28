//
//  ProductListTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 28/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ProductListTVC: UITableViewCell {

    @IBOutlet weak var outerView: View!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var priceLbl: Label!
    @IBOutlet weak var qtyLbl: Label!
    @IBOutlet weak var descLbl: Label!
    @IBOutlet weak var deliveryLbl: Label!
    @IBOutlet weak var cartBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
