//
//  MyCodeVC.swift
//  Holistic
//
//  Created by Keyur on 26/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class MyCodeVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var noDataLbl: Label!
    
    var type = 1
    var arrCode = [CodeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        if type == 1 {
            noDataView.isHidden = false
        }else{
            noDataView.isHidden = true
        }
        noDataLbl.attributedText = attributedStringWithColor(noDataLbl.text!, ["Click here"], color: OrangeColor)
        serviceCallToGetMyCode()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToNotification(_ sender: Any) {
        let vc : NotificationVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func clickToNoDataFound(_ sender: Any) {
        if type == 1 {
            NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 2])
        }
        else {
            NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 3])
        }
        self.navigationController?.popViewController(animated: false)
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
extension MyCodeVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "MyCodeTVC", bundle: nil), forCellReuseIdentifier: "MyCodeTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCode.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MyCodeTVC = tblView.dequeueReusableCell(withIdentifier: "MyCodeTVC") as! MyCodeTVC
        cell.setupDetails(arrCode[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MyCodeVC {
    func serviceCallToGetMyCode() {
        HotelAPIManager.shared.serviceCallToGetMyCode(["user_id" : AppModel.shared.currentUser.id!]) { (data) in
            self.arrCode = [CodeModel]()
            for temp in data {
                self.arrCode.append(CodeModel.init(temp))
            }
            self.tblView.reloadData()
        }
    }
}
