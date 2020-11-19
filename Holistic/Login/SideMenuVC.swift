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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrMenuData.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell : SideMenuTVC = tblView.dequeueReusableCell(withIdentifier: "SideMenuTVC") as! SideMenuTVC
        cell.imgBtn.isHidden = false
        let dict = arrMenuData[section]
        cell.setupDetails(dict)
        cell.expandBtn.isSelected = dict.isExpand
        cell.expandBtn.tag = section
        cell.expandBtn.addTarget(self, action: #selector(clickToExpand(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func clickToExpand(_ sender : UIButton) {
        switch arrMenuData[sender.tag].title {
            case "Home":
                self.menuContainerViewController.toggleLeftSideMenuCompletion {}
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 0])
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDIRECT_HOME_LIFESTYLE), object: nil)
                break
            case "Holistic Lifestyle":
                self.menuContainerViewController.toggleLeftSideMenuCompletion {}
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 0])
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDIRECT_HOME_LIFESTYLE), object: nil)
                break
            case "Holistic Clinic":
                arrMenuData[sender.tag].isExpand = !arrMenuData[sender.tag].isExpand
                tblView.reloadData()
                break
            case "Holistic Hotels":
                self.menuContainerViewController.toggleLeftSideMenuCompletion {}
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 2])
                break
            case "Holistic Restaurants":
                self.menuContainerViewController.toggleLeftSideMenuCompletion {}
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 3])
                break
            case "Holistic Products":
                arrMenuData[sender.tag].isExpand = !arrMenuData[sender.tag].isExpand
                tblView.reloadData()
                break
            case "My Loyalty Points":
                self.menuContainerViewController.toggleLeftSideMenuCompletion {}
                let vc : LoyalityPointVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "LoyalityPointVC") as! LoyalityPointVC
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case "Blogs":
                self.menuContainerViewController.toggleLeftSideMenuCompletion {}
                let vc : BlogListVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "BlogListVC") as! BlogListVC
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case "Profile":
                self.menuContainerViewController.toggleLeftSideMenuCompletion {}
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDICT_TAB_BAR), object: ["tabIndex" : 4])
                break
            case "Refer Friend":
                self.menuContainerViewController.toggleLeftSideMenuCompletion {}
                let vc : ReferFriendVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "ReferFriendVC") as! ReferFriendVC
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case "Logout":
                self.menuContainerViewController.toggleLeftSideMenuCompletion {}
                AppDelegate().sharedDelegate().logoutFromApp()
                break
            default:
                break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrMenuData[section].isExpand && arrMenuData[section].data.count > 0 {
            return arrMenuData[section].data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SideMenuTVC = tblView.dequeueReusableCell(withIdentifier: "SideMenuTVC") as! SideMenuTVC
        cell.expandBtn.isHidden = true
        cell.imgBtn.isHidden = true
        cell.titleLbl.text = arrMenuData[indexPath.section].data[indexPath.row].title
        cell.titleLbl.textColor = BLACK_COLOR
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.menuContainerViewController.toggleLeftSideMenuCompletion {}
        let title = arrMenuData[indexPath.section].title
        if title == "Holistic Clinic" {
            switch arrMenuData[indexPath.section].data[indexPath.row].title {
                case "Appointments":
                    let vc : ClinicListVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "ClinicListVC") as! ClinicListVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case "Diet Plan":
                    let vc : DietPlanVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "DietPlanVC") as! DietPlanVC
                    UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
                    break
                case "Prescription":
                    let vc : ClinicListVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "ClinicListVC") as! ClinicListVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case "Package":
                    let vc : ClinicPackageVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "ClinicPackageVC") as! ClinicPackageVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case "Family Members":
                    let vc : FamilyMemberVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "FamilyMemberVC") as! FamilyMemberVC
                    UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
                    break
                default:
                    break
            }
        }
        else if title == "Holistic Products" {
            switch arrMenuData[indexPath.section].data[indexPath.row].title {
                case "All Products":
                    let vc : ProductListVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "ProductListVC") as! ProductListVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case "My purchases":
                    let vc : MyPurchaseVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "MyPurchaseVC") as! MyPurchaseVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                default:
                    break
            }
        }
    }
}
