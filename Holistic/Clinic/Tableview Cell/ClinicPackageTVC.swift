//
//  ClinicPackageTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 11/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ClinicPackageTVC: UITableViewCell {

    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var descLbl: Label!
    @IBOutlet weak var appointmentTxt: TextField!
    @IBOutlet weak var onGoingBtn: Button!
    @IBOutlet weak var progressLbl: Label!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
