//
//  ClinicTabCVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 21/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ClinicTabCVC: UICollectionViewCell {

    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var catBtn: UIButton!
    @IBOutlet weak var categoryView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupDetails(_ dict : ClinicCategoryModel) {
        titleLbl.text = dict.name
        catBtn.setImage(UIImage(named: dict.image), for: .normal)
    }
}
