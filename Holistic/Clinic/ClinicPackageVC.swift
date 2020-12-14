//
//  ClinicPackageVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 11/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ClinicPackageVC: UIViewController {

    @IBOutlet weak var fromDateTxt: UITextField!
    @IBOutlet weak var toDateTxt: UITextField!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constraintHeightTblView: NSLayoutConstraint!
    
    var arrPackage = [ClinicPackageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
    }
    
    func setupDetails() {
        serviceCallToGetPackageList()
    }
    
    //MARK:- Button click event
    @IBAction func clickToSelectFromDate(_ sender: Any) {
        
    }
    
    @IBAction func clickToSelectToDate(_ sender: Any) {
        
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
extension ClinicPackageVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "ClinicPackageTVC", bundle: nil), forCellReuseIdentifier: "ClinicPackageTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPackage.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ClinicPackageTVC = tblView.dequeueReusableCell(withIdentifier: "ClinicPackageTVC") as! ClinicPackageTVC
        cell.setupDetails(arrPackage[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = arrPackage[indexPath.row]
        let strUrl = "https://holistichealing.curofic.com/patientbill.aspx?id=" + dict.ID + "&gid=" + dict.HeadOrganisationID + "&tp=4"
        openUrlInSafari(strUrl: strUrl)
    }
    
    func updateTableviewHeight() {
        constraintHeightTblView.constant = CGFloat.greatestFiniteMagnitude
        tblView.reloadData()
        tblView.layoutIfNeeded()
        constraintHeightTblView.constant = tblView.contentSize.height
    }
}

extension ClinicPackageVC {
    func serviceCallToGetPackageList() {
        ClinicAPIManager.shared.serviceCallToGetPackageList { (data) in
            self.arrPackage = [ClinicPackageModel]()
            for temp in data {
                self.arrPackage.append(ClinicPackageModel.init(temp))
            }
            self.tblView.reloadData()
            self.updateTableviewHeight()
        }
    }
}
