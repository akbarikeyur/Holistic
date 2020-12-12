//
//  ClinicListVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 09/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ClinicListVC: UIViewController {

    @IBOutlet weak var fromTxt: UITextField!
    @IBOutlet weak var toTxt: UITextField!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constraintHeightTblView: NSLayoutConstraint!
    
    var arrAppointment = [AppointmentModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
    }
    
    func setupDetails() {
        serviceCallToGetAppointmentList()
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
extension ClinicListVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "ClinicAppointmentTVC", bundle: nil), forCellReuseIdentifier: "ClinicAppointmentTVC")
        updateTableviewHeight()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAppointment.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ClinicAppointmentTVC = tblView.dequeueReusableCell(withIdentifier: "ClinicAppointmentTVC") as! ClinicAppointmentTVC
        cell.setupDetails(arrAppointment[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func updateTableviewHeight() {
        constraintHeightTblView.constant = 150 * 3
    }
}

extension ClinicListVC {
    func serviceCallToGetAppointmentList() {
        ClinicAPIManager.shared.serviceCallToGetAppointmentList { (data) in
            self.arrAppointment = [AppointmentModel]()
            for temp in data {
                self.arrAppointment.append(AppointmentModel.init(temp))
            }
            self.tblView.reloadData()
        }
    }
}
