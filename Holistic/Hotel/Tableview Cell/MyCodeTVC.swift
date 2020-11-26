//
//  MyCodeTVC.swift
//  Holistic
//
//  Created by Keyur on 26/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class MyCodeTVC: UITableViewCell {

    @IBOutlet weak var imgView: ImageView!
    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var codeLbl: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupHotelDetails(_ dict : HotelModel) {
        
    }
    
    func setupRestaurantDetails(_ dict : RestaurantModel) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
