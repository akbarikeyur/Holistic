//
//  QuestionAnswerTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 16/02/21.
//  Copyright © 2021 Keyur Akbari. All rights reserved.
//

import UIKit

class QuestionAnswerTVC: UITableViewCell {

    @IBOutlet weak var questionLbl: Label!
    @IBOutlet weak var answer1Btn: Button!
    @IBOutlet weak var answer2Btn: Button!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : QuestionModel, _ index : Int) {
        questionLbl.text = "Q" + String(index+1) + ". " + dict.question
        answer1Btn.setTitle("Yes", for: .normal)
        answer2Btn.setTitle("No", for: .normal)
        answer1Btn.isSelected = (dict.answer == "yes")
        answer2Btn.isSelected = (dict.answer == "no")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
