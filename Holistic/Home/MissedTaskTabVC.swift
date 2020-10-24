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
    
    var arrTaskData = [TaskModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
    }
    
    func setupDetails() {
        updateHeight()
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
        
        arrTaskData = [TaskModel]()
        for temp in getJsonFromFile("missed_task") {
            arrTaskData.append(TaskModel.init(temp))
        }
        tblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTaskData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CurrentTaskTVC = tblView.dequeueReusableCell(withIdentifier: "CurrentTaskTVC") as! CurrentTaskTVC
        cell.setupDetails(arrTaskData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func updateHeight() {
        tblView.reloadData()
        let height = arrTaskData.count * 120
        NotificationCenter.default.post(name: NSNotification.Name.init("UPDATE_LIFESTYLE_HEIGHT"), object: height)
    }
}
