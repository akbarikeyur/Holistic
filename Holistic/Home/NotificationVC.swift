//
//  NotificationVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 04/02/21.
//  Copyright © 2021 Keyur Akbari. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noDataFoundLbl: Label!
    
    var arrNotification = [NotificationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        serviceCallToGetNotification()
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
extension NotificationVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "NotificationTVC", bundle: nil), forCellReuseIdentifier: "NotificationTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotification.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NotificationTVC = tblView.dequeueReusableCell(withIdentifier: "NotificationTVC") as! NotificationTVC
        cell.setupDetails(arrNotification[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch arrNotification[indexPath.row].type {
            case "product":
                let vc : MyPurchaseVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "MyPurchaseVC") as! MyPurchaseVC
                UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
                break
            case "life_style":
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 0])
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDIRECT_HOME_LIFESTYLE), object: nil)
                break
            case "hotel":
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 2])
                break
            case "restaurant":
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 3])
                break
            case "clinic":
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 1])
                break
            default:
                break
        }
    }
}

extension NotificationVC {
    func serviceCallToGetNotification() {
        HomeAPIManager.shared.serviceCallToGetNotification(["user_id" : AppModel.shared.currentUser.id!]) { (data) in
            self.arrNotification = [NotificationModel]()
            for temp in data {
                self.arrNotification.append(NotificationModel.init(temp))
            }
            self.tblView.reloadData()
            self.noDataFoundLbl.isHidden = (self.arrNotification.count > 0)
        }
    }
}
