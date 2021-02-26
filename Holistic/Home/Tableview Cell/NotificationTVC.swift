//
//  NotificationTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 05/02/21.
//  Copyright © 2021 Keyur Akbari. All rights reserved.
//

import UIKit

class NotificationTVC: UITableViewCell {

    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var descLbl: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : NotificationModel) {
        titleLbl.text = dict.title
        descLbl.text = dict.desc
        let strDate = dict.created_at.components(separatedBy: ".").first!
        if let date = getDateFromDateString(date: strDate, format: "yyyy-MM-dd'T'HH:mm:ss") {
            dateLbl.text = getDateStringFromDate(date: date, format: "d MMM, yyyy h:mm a")
        }
        else{
            dateLbl.text = strDate
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
