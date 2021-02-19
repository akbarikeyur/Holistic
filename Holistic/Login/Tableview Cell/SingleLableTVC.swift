//
//  SingleLableTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 25/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class SingleLableTVC: UITableViewCell {

    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var seperateImgView: UIImageView!
    @IBOutlet weak var selectBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
