//
//  PurchaseProductCVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 30/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class PurchaseProductCVC: UICollectionViewCell {

    @IBOutlet weak var productLbl: Label!
    @IBOutlet weak var invoiceLbl: Label!
    @IBOutlet weak var dateTimeLbl: Label!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constraintHeightTblView: NSLayoutConstraint!
    @IBOutlet weak var totalLbl: Label!
    @IBOutlet weak var downBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerTableViewMethod()
    }
    
    func setupDetail() {
        constraintHeightTblView.constant = 125
        //updateWakeupTableviewHeight()
    }

}

//MARK:- Tableview Method
extension PurchaseProductCVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "PurchaseProductTVC", bundle: nil), forCellReuseIdentifier: "PurchaseProductTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PurchaseProductTVC = tblView.dequeueReusableCell(withIdentifier: "PurchaseProductTVC") as! PurchaseProductTVC
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func updateWakeupTableviewHeight() {
        constraintHeightTblView.constant = CGFloat.greatestFiniteMagnitude
        tblView.reloadData()
        tblView.layoutIfNeeded()
        constraintHeightTblView.constant = tblView.contentSize.height
    }
}
