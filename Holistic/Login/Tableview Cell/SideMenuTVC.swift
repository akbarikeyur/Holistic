//
//  SideMenuTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 27/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class SideMenuTVC: UITableViewCell {

    @IBOutlet weak var imgBtn: Button!
    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var expandBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : MenuModel) {
        expandBtn.isHidden = (dict.data.count == 0)
        if dict.image != "" {
            if dict.isExpand {
                titleLbl.textColor = OrangeColor
                imgBtn.setImage(UIImage(named: dict.select_image), for: .normal)
            }else{
                titleLbl.textColor = BLACK_COLOR
                imgBtn.setImage(UIImage(named: dict.image), for: .normal)
            }
        }else{
            imgBtn.setImage(nil, for: .normal)
        }
        titleLbl.text = dict.title
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
