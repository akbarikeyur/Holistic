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

    func setupDetails(_ dict : TaskDescModel) {
        setButtonImage(imgBtn, dict.get_media.url, IMAGE.PLACEHOLDER)
        if dict.isExpand {
            let strValue = "<p>" + dict.title + "</p><br>" + dict.desc
            titleLbl.text = strValue.html2String
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
