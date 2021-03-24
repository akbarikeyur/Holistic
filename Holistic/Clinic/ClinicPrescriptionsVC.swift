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
    
    var arrPrescription = [PrescriptionSectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: NSNotification.Name.init(NOTIFICATION.REFRESH_CLINIC_DATA), object: nil)
        registerTableViewMethod()
    }
    
    @objc func refreshData() {
        serviceCallToGetPrescriptions()
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
        tblView.register(UINib.init(nibName: "SingleLableVC", bundle: nil), forCellReuseIdentifier: "SingleLableVC")
        tblView.register(UINib.init(nibName: "PrescriptionsTVC", bundle: nil), forCellReuseIdentifier: "PrescriptionsTVC")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrPrescription.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell : SingleLableVC = tblView.dequeueReusableCell(withIdentifier: "SingleLableVC") as! SingleLableVC
        if let date = getDateFromDateString(date: arrPrescription[section].date, format: "yyyy-MM-dd") {
            cell.titleLbl.text = getLocalDateStringFromDate(date: date, format: "d MMMM, yyyy")
        }else{
            cell.titleLbl.text = arrPrescription[section].date
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPrescription[section].prescription.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PrescriptionsTVC = tblView.dequeueReusableCell(withIdentifier: "PrescriptionsTVC") as! PrescriptionsTVC
        cell.setupDetails(arrPrescription[indexPath.section].prescription[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ClinicPrescriptionsVC {
    func serviceCallToGetPrescriptions() {
        if getClinicUserId() == "" {
            return
        }
        ClinicAPIManager.shared.serviceCallToGetPrescriptions { (data) in
            var arrData = [PrescriptionModel]()
            for temp in data {
                arrData.append(PrescriptionModel.init(temp))
            }
            self.setupData(arrData)
        }
    }
    
    func setupData(_ data : [PrescriptionModel]) {
        arrPrescription = [PrescriptionSectionModel]()
        var arrData = data
        if arrData.count > 1 {
            arrData.sort {
                
                let elapsed0 = getDateFromDateString(date: $0.StartDate.components(separatedBy: "T").first!, format: "yyyy-MM-dd")
                let elapsed1 = getDateFromDateString(date: $1.StartDate.components(separatedBy: "T").first!, format: "yyyy-MM-dd")
                return elapsed0! < elapsed1!
            }
        }

        var arrDate = [String]()
        for temp in arrData {
            let strDate = temp.StartDate.components(separatedBy: "T").first!
            if !arrDate.contains(strDate) {
                arrDate.append(strDate)
            }
        }
        
        for tempDate in arrDate {
            var dict = PrescriptionSectionModel.init([String : Any]())
            dict.date = tempDate
            for temp in arrData {
                let strDate = temp.StartDate.components(separatedBy: "T").first!
                if strDate == tempDate {
                    dict.prescription.append(temp)
                }
            }
            arrPrescription.append(dict)
        }
        tblView.reloadData()
    }
}
