//
//  ExpandCollapseTVC.swift
//  Holistic
//
//  Created by Keyur on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ExpandCollapseTVC: UITableViewCell {

    @IBOutlet weak var imgBtn: UIButton!
    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var expandBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : WakeupModel) {
        imgBtn.setImage(UIImage(named: dict.imgBtn), for: .normal)
        if dict.isExpand {
            titleLbl.text = dict.desc
            expandBtn.isSelected = true
            imgBtn.alpha = 1.0
        }
        else{
            titleLbl.text = dict.title
            expandBtn.isSelected = false
            imgBtn.alpha = 0.7
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
