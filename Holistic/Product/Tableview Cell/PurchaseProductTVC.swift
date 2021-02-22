//
//  PurchaseProductTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 30/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class PurchaseProductTVC: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var priceLbl: Label!
    @IBOutlet weak var qtyLbl: Label!
    @IBOutlet weak var descLbl: Label!
    @IBOutlet weak var quantityLbl: Label!
    @IBOutlet weak var orderLbl: Label!
    @IBOutlet weak var statusLbl: Label!
    @IBOutlet weak var paymentTypeLbl: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
