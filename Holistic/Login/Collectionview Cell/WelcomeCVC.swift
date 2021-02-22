//
//  WelcomeCVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 13/02/21.
//  Copyright © 2021 Keyur Akbari. All rights reserved.
//

import UIKit

class WelcomeCVC: UICollectionViewCell {

    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descLbl: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : WelcomeModel) {
        titleLbl.text = dict.title
        descLbl.text = getTranslate(dict.desc)
        imgView.image = UIImage(named: dict.image)
    }
}
