//
//  PrescriptionsCVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 11/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class PrescriptionsCVC: UICollectionViewCell {

    @IBOutlet weak var tblView: UITableView!
    
    var arrData = [PrescriptionModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerTableViewMethod()
    }
    
    func setupDetails(_ dict : PrescriptionModel) {
        arrData = [PrescriptionModel]()
        arrData.append(dict)
        tblView.reloadData()
    }
    
}

//MARK:- Tableview Method
extension PrescriptionsCVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "PrescriptionsTVC", bundle: nil), forCellReuseIdentifier: "PrescriptionsTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PrescriptionsTVC = tblView.dequeueReusableCell(withIdentifier: "PrescriptionsTVC") as! PrescriptionsTVC
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
