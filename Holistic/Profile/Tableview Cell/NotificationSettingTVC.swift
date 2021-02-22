//
//  NotificationSettingTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 04/02/21.
//  Copyright © 2021 Keyur Akbari. All rights reserved.
//

import UIKit

class NotificationSettingTVC: UITableViewCell {

    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var descLbl: Label!
    @IBOutlet weak var notiSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : NotificationSettingModel) {
        titleLbl.text = dict.title
        descLbl.text = dict.desc
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
