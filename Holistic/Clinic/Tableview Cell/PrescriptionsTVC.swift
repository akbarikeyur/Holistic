//
//  PrescriptionsTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 11/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class PrescriptionsTVC: UITableViewCell {

    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var sizeLbl: Label!
    @IBOutlet weak var timeLbl: Label!
    @IBOutlet weak var dietBtn: UIButton!
    @IBOutlet weak var dietLbl: Label!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : PrescriptionModel) {
        titleLbl.text = dict.RxName
        sizeLbl.text = String(dict.RxDosageStrength) + dict.RxDosageUnit + "  |  " + dict.RxDosageFrequencyInfo
        timeLbl.text = String(dict.RxDuration) + " " + dict.RxDurationUnit
        if dict.RxDuration > 1 {
            timeLbl.text = timeLbl.text! + " (s)"
        }
        dietLbl.text = dict.RxDosageInstruction
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
