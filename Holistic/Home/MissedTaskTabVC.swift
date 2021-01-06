//
//  MissedTaskTabVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 24/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class MissedTaskTabVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet var wakeUpView: UIView!
    @IBOutlet weak var wakeTblView: UITableView!
    @IBOutlet weak var constraintHeightWakeTbl: NSLayoutConstraint!
    @IBOutlet weak var noDataFoundLbl: Label!
    
    var arrTaskData = [TaskModel]()
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
    }
    
    func setupDetails() {
        if arrTaskData.count == 0 {
            serviceCallToGetMissedTask()
        }else{
            updateHeight()
        }
    }
    
    //MARK:- Button click event
    @IBAction func clickToCloseWakeupView(_ sender: Any) {
        wakeUpView.removeFromSuperview()
    }
    
    @IBAction func clickToDoneWakeupView(_ sender: Any) {
        var param = [String : Any]()
        param["user_id"] = AppModel.shared.currentUser.id
        param["task_id"] = arrTaskData[selectedIndex].id
        printData(param)
        serviceCallToCompleteTask(param)
    }
    
    @IBAction func clickToLaterWakeupView(_ sender: Any) {
        wakeUpView.removeFromSuperview()
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
extension MissedTaskTabVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "CurrentTaskTVC", bundle: nil), forCellReuseIdentifier: "CurrentTaskTVC")
        wakeTblView.register(UINib.init(nibName: "ExpandCollapseTVC", bundle: nil), forCellReuseIdentifier: "ExpandCollapseTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == wakeTblView {
            return arrTaskData[selectedIndex].get_description.count
        }
        return arrTaskData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == wakeTblView {
            return UITableView.automaticDimension
        }
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == wakeTblView {
            let cell : ExpandCollapseTVC = wakeTblView.dequeueReusableCell(withIdentifier: "ExpandCollapseTVC") as! ExpandCollapseTVC
            cell.setupDetails(arrTaskData[selectedIndex].get_description[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
        else{
            let cell : CurrentTaskTVC = tblView.dequeueReusableCell(withIdentifier: "CurrentTaskTVC") as! CurrentTaskTVC
            cell.setupDetails(arrTaskData[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblView {
            if indexPath.row == 0 {
                displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: wakeUpView)
                updateWakeupTableviewHeight()
            }
        }
        else if tableView == wakeTblView {
            arrTaskData[selectedIndex].get_description[indexPath.row].isExpand = !arrTaskData[selectedIndex].get_description[indexPath.row].isExpand
            wakeTblView.reloadData()
            updateWakeupTableviewHeight()
        }
    }
    
    func updateHeight() {
        tblView.reloadData()
        let height = arrTaskData.count * 120
        NotificationCenter.default.post(name: NSNotification.Name.init("UPDATE_LIFESTYLE_HEIGHT"), object: height)
        noDataFoundLbl.isHidden = (arrTaskData.count > 0)
    }
    
    func updateWakeupTableviewHeight() {
        constraintHeightWakeTbl.constant = CGFloat.greatestFiniteMagnitude
        wakeTblView.reloadData()
        wakeTblView.layoutIfNeeded()
        constraintHeightWakeTbl.constant = wakeTblView.contentSize.height
    }
}

extension MissedTaskTabVC {
    func serviceCallToGetMissedTask() {
        var param = [String : Any]()
        param["user_id"] = AppModel.shared.currentUser.id
        param["status"] = "missed"
        HomeAPIManager.shared.serviceCallToGetMissedTask(param) { (data) in
            self.arrTaskData = [TaskModel]()
            for temp in data {
                self.arrTaskData.append(TaskModel.init(temp))
            }
            self.updateHeight()
        }
    }
    
    func serviceCallToCompleteTask(_ param : [String : Any]) {
        HomeAPIManager.shared.serviceCallToCompleteTask(param) {
            self.wakeUpView.removeFromSuperview()
            self.arrTaskData.remove(at: self.selectedIndex)
            self.updateHeight()
            NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFRESH_COMPLETE_TASK), object: nil)
        }
    }
}
