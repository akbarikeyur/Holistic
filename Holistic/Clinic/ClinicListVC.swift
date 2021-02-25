//
//  ClinicListVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 09/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ClinicListVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constraintHeightTblView: NSLayoutConstraint!
    
    var arrAppointment = [AppointmentModel]()
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: NSNotification.Name.init(NOTIFICATION.REFRESH_CLINIC_DATA), object: nil)
        registerTableViewMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
    }
    
    @objc func refreshData() {
        page = 1
        serviceCallToGetAppointmentList()
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if page != 0 && (arrAppointment.count-1 == indexPath.row) {
            serviceCallToGetAppointmentList()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func updateTableviewHeight() {
        constraintHeightTblView.constant = CGFloat(150 * arrAppointment.count)
    }
}

extension ClinicListVC {
    func serviceCallToGetAppointmentList() {
        if getClinicUserId() == "" {
            return
        }
        ClinicAPIManager.shared.serviceCallToGetAppointmentList(page) { (data) in
            if self.page == 1 {
                self.arrAppointment = [AppointmentModel]()
            }
            
            for temp in data {
                self.arrAppointment.append(AppointmentModel.init(temp))
            }
            
            if self.arrAppointment.count > 1
            {
                //2020-10-15T06:15:00Z
                self.arrAppointment.sort {
                    let elapsed0 = getDateFromDateString(date: $0.StartDateTime, format: "yyyy-MM-dd'T'HH:mm:ssZ")
                    let elapsed1 = getDateFromDateString(date: $1.StartDateTime, format: "yyyy-MM-dd'T'HH:mm:ssZ")
                    return elapsed0 > elapsed1
                }
            }
            
            if data.count < 10 {
                self.page = 0
            }else{
                self.page += 1
            }
            self.tblView.reloadData()
            self.updateTableviewHeight()
        }
    }
}
