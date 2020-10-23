//
//  CurrentTaskTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class CurrentTaskTVC: UITableViewCell {

    @IBOutlet weak var outerView: View!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timeLbl: Label!
    @IBOutlet weak var detailLbl: Label!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : TaskModel) {
        outerView.backgroundColor = colorFromHex(hex: dict.color)
        titleLbl.text = dict.title
        timeLbl.text = dict.time
        detailLbl.text = dict.detail
        imgView.image = UIImage(named: dict.image)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
