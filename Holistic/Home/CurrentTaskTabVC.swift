//
//  CurrentTaskTabVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class CurrentTaskTabVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet var wakeUpView: UIView!
    @IBOutlet weak var wakeTblView: UITableView!
    @IBOutlet weak var constraintHeightWakeTbl: NSLayoutConstraint!
    
    var arrTaskData = [TaskModel]()
    var arrWakeupData = [WakeupModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
    }
    
    func setupDetails() {
        updateHeight()
    }

    @IBAction func clickToCloseWakeupView(_ sender: Any) {
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
extension CurrentTaskTabVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "CurrentTaskTVC", bundle: nil), forCellReuseIdentifier: "CurrentTaskTVC")
        wakeTblView.register(UINib.init(nibName: "ExpandCollapseTVC", bundle: nil), forCellReuseIdentifier: "ExpandCollapseTVC")
        
        arrTaskData = [TaskModel]()
        for temp in getJsonFromFile("current_task") {
            arrTaskData.append(TaskModel.init(temp))
        }
        tblView.reloadData()
        
        arrWakeupData = [WakeupModel]()
        for temp in getJsonFromFile("wakeup") {
            arrWakeupData.append(WakeupModel.init(temp))
        }
        wakeTblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == wakeTblView {
            return arrWakeupData.count
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
            cell.setupDetails(arrWakeupData[indexPath.row])
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
            arrWakeupData[indexPath.row].isExpand = !arrWakeupData[indexPath.row].isExpand
            wakeTblView.reloadData()
            updateWakeupTableviewHeight()
        }
    }
    
    func updateHeight() {
        tblView.reloadData()
        let height = arrTaskData.count * 120
        NotificationCenter.default.post(name: NSNotification.Name.init("UPDATE_LIFESTYLE_HEIGHT"), object: height)
    }
    
    func updateWakeupTableviewHeight() {
        constraintHeightWakeTbl.constant = CGFloat.greatestFiniteMagnitude
        wakeTblView.reloadData()
        wakeTblView.layoutIfNeeded()
        constraintHeightWakeTbl.constant = wakeTblView.contentSize.height
    }
}
