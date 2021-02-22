//
//  OrderSummaryTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 29/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class OrderSummaryTVC: UITableViewCell {

    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var priceLbl: Label!
    @IBOutlet weak var qtyLbl: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : CartModel) {
        if dict.get_product.count > 0 {
            let product = dict.get_product[0]
            nameLbl.text = product.name
            priceLbl.text = displayPriceWithCurrency(product.price)
            qtyLbl.text = "x" + String(dict.qty)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
