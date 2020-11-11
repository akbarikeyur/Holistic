//
//  DietPlanMealCVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 11/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class DietPlanMealCVC: UICollectionViewCell {

    @IBOutlet weak var tblView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerTableViewMethod()
    }
    
    func setupDetails() {
        tblView.reloadData()
    }
    
}

//MARK:- Tableview Method
extension DietPlanMealCVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "DietPlanMealTVC", bundle: nil), forCellReuseIdentifier: "DietPlanMealTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DietPlanMealTVC = tblView.dequeueReusableCell(withIdentifier: "DietPlanMealTVC") as! DietPlanMealTVC
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
