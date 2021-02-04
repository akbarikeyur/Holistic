//
//  NotificationSettingVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 04/02/21.
//  Copyright © 2021 Keyur Akbari. All rights reserved.
//

import UIKit

class NotificationSettingVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var arrLocalSetting = [NotificationSettingModel]()
    var arrSetting = [NotificationSettingModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        serviceCallToGetNotificationSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
extension NotificationSettingVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "NotificationSettingTVC", bundle: nil), forCellReuseIdentifier: "NotificationSettingTVC")
        
        arrLocalSetting = [NotificationSettingModel]()
        for temp in getJsonFromFile("notification") {
            arrLocalSetting.append(NotificationSettingModel.init(temp))
        }
        tblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLocalSetting.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NotificationSettingTVC = tblView.dequeueReusableCell(withIdentifier: "NotificationSettingTVC") as! NotificationSettingTVC
        cell.setupDetails(arrLocalSetting[indexPath.row])
        let index = arrSetting.firstIndex { (temp) -> Bool in
            temp.type == arrLocalSetting[indexPath.row].type
        }
        if index != nil {
            if arrSetting[index!].status == "on" {
                cell.notiSwitch.setOn(true, animated: false)
            }else{
                cell.notiSwitch.setOn(false, animated: false)
            }
        }
        cell.notiSwitch.tag = indexPath.row
        cell.notiSwitch.addTarget(self, action: #selector(clickToChangeValue(_:)), for: .valueChanged)
        cell.selectionStyle = .none
        return cell
    }
    
    @objc @IBAction func clickToChangeValue(_ sender: UISwitch) {
        let dict = arrLocalSetting[sender.tag]
        var param = [String : Any]()
        param["user_id"] = AppModel.shared.currentUser.id
        param["type"] = dict.type
        param["status"] = sender.isOn ? "on" : "off"
        ProfileAPIManager.shared.serviceCallToSetNotificationSetting(param) {
            
        }
    }
}

extension NotificationSettingVC {
    func serviceCallToGetNotificationSetting() {
        ProfileAPIManager.shared.serviceCallToGetNotificationSetting(["user_id" : AppModel.shared.currentUser.id!]) { (data) in
            self.arrSetting = [NotificationSettingModel]()
            for temp in data {
                self.arrSetting.append(NotificationSettingModel.init(temp))
            }
            self.tblView.reloadData()
        }
    }
}
