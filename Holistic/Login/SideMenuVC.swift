//
//  SideMenuVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 27/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {

    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var emailLbl: Label!
    @IBOutlet weak var tblView: UITableView!
    
    var arrMenuData = [MenuModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(setupUserDetail), name: NSNotification.Name.init(NOTIFICATION.UPDATE_CURRENT_USER_DATA), object: nil)
        
        registerTableViewMethod()
    }
    
    @objc func setupUserDetail() {
//        if !isUserLogin() {
//            return
//        }
//        nameLbl.text = AppModel.shared.currentUser.full_name.capitalized
//        emailLbl.text = AppModel.shared.currentUser.email
    }
    
    @IBAction func clickToClose(_ sender: Any) {
        self.menuContainerViewController.toggleLeftSideMenuCompletion {}
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
extension SideMenuVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "SideMenuTVC", bundle: nil), forCellReuseIdentifier: "SideMenuTVC")
        
        arrMenuData = [MenuModel]()
        for temp in getJsonFromFile("menu") {
            arrMenuData.append(MenuModel.init(temp))
        }
        tblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SideMenuTVC = tblView.dequeueReusableCell(withIdentifier: "SideMenuTVC") as! SideMenuTVC
        cell.setupDetails(arrMenuData[indexPath.row])
        if (arrMenuData.count - 1) == indexPath.row {
            cell.titleLbl.textColor = OrangeColor
        }else{
            cell.titleLbl.textColor = BLACK_COLOR
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.menuContainerViewController.toggleLeftSideMenuCompletion {}
        switch arrMenuData[indexPath.row].title {
            case "Home":
                break
            case "Holistic Lifestyle":
                break
            case "Holistic Clinic":
                break
            case "Holistic Hotels":
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 2])
                break
            case "Holistic Restaurants":
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 3])
                break
            case "Holistic Products":
                let vc : ProductListVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "ProductListVC") as! ProductListVC
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case "My Loyalty Points":
                break
            case "Profile":
                break
            case "Logout":
                break
            default:
                break
        }
    }
}
