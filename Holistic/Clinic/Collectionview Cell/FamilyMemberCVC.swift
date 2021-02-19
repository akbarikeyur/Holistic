//
//  FamilyMemberCVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 09/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class FamilyMemberCVC: UICollectionViewCell {

    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var relationLbl: Label!
    @IBOutlet weak var selectBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupDetails(_ dict : ClinicUserModel) {
        nameLbl.text = dict.FullName
        relationLbl.text = dict.EmergencyContactPersonRelationWithPatient
        
        if dict.ID == getClinicUserId() {
            selectBtn.isHidden = false
        }else{
            selectBtn.isHidden = true
        }
    }
}
