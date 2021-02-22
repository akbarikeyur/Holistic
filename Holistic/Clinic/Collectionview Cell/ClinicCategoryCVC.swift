//
//  ClinicCategoryCVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 31/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ClinicCategoryCVC: UICollectionViewCell {

    @IBOutlet weak var outerView: View!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupDetails(_ dict : ClinicCategoryModel) {
        outerView.backgroundColor = colorFromHex(hex: dict.color)
        imgView.image = UIImage(named: dict.image)
        nameLbl.text = dict.name
    }

}
