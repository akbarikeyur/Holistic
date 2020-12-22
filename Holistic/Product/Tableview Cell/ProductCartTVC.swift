//
//  ProductCartTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 28/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import DropDown

class ProductCartTVC: MGSwipeTableCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var priceLbl: Label!
    @IBOutlet weak var qtyLbl: Label!
    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var refLbl: Label!
    @IBOutlet weak var stockLbl: Label!
    @IBOutlet weak var currentQtyLbl: Label!
    @IBOutlet weak var qtyBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : CartModel) {
        if dict.get_product.count > 0 {
            let product = dict.get_product[0]
            if product.product_single_image.count > 0 {
                setImageBackgroundImage(imgView, product.product_single_image[0].url, IMAGE.PLACEHOLDER)
            }else{
                imgView.image = UIImage(named: IMAGE.PLACEHOLDER)
            }
            priceLbl.text = displayPriceWithCurrency(product.price)
            qtyLbl.text = "x" + String(dict.qty)
            currentQtyLbl.text = String(dict.qty)
            nameLbl.text = product.name
            refLbl.text = "Ref: " + String(product.id)
            stockLbl.text = ""            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
