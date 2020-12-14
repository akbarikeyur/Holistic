//
//  ClinicPrescriptionsVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 20/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ClinicPrescriptionsVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var arrPrescription = [PrescriptionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
    }
    
    func setupDetails() {
        serviceCallToGetPrescriptions()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

//MARK:- Tableview Method
extension ClinicPrescriptionsVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "PrescriptionsTVC", bundle: nil), forCellReuseIdentifier: "PrescriptionsTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPrescription.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PrescriptionsTVC = tblView.dequeueReusableCell(withIdentifier: "PrescriptionsTVC") as! PrescriptionsTVC
        cell.setupDetails(arrPrescription[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ClinicPrescriptionsVC {
    func serviceCallToGetPrescriptions() {
        ClinicAPIManager.shared.serviceCallToGetPrescriptions { (data) in
            self.arrPrescription = [PrescriptionModel]()
            for temp in data {
                self.arrPrescription.append(PrescriptionModel.init(temp))
            }
            self.tblView.reloadData()
        }
    }
}
