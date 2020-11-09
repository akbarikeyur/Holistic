//
//  DietPlanTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 09/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class DietPlanTVC: UITableViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var pdfBtn: UIButton!
    @IBOutlet weak var expandBtn: UIButton!
    @IBOutlet weak var detailView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
