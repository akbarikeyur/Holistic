//
//  DietPlanMealTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 11/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class DietPlanMealTVC: UITableViewCell {

    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var sizeLbl: Label!
    @IBOutlet weak var timeLbl: Label!
    @IBOutlet weak var dietBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
