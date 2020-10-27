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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : MenuModel) {
        if dict.image != "" {
            imgBtn.setImage(UIImage(named: dict.image), for: .normal)
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
