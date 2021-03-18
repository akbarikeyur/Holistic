//
//  GlobalSearchVC.swift
//  Holistic
//
//  Created by Keyur on 17/03/21.
//  Copyright © 2021 Keyur Akbari. All rights reserved.
//

import UIKit

class GlobalSearchVC: UIViewController {

    @IBOutlet weak var searchTxt: TextField!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noDataLbl: Label!
    @IBOutlet var wakeUpView: UIView!
    @IBOutlet weak var taskTimeLbl: UILabel!
    @IBOutlet weak var taskTitleLbl: UILabel!
    @IBOutlet weak var wakeTblView: UITableView!
    @IBOutlet weak var constraintHeightWakeTbl: NSLayoutConstraint!
    
    var arrHotel = [HotelModel]()
    var arrRestaurant = [RestaurantModel]()
    var arrTaskData = [TaskModel]()
    var arrProduct = [ProductModel]()
    var arrType = [String]()
    var selectedTaskIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        noDataLbl.isHidden = true
        searchTxt.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToCloseWakeupView(_ sender: Any) {
        wakeUpView.removeFromSuperview()
    }
    
    @IBAction func clickToDoneWakeupView(_ sender: Any) {
        var param = [String : Any]()
        param["user_id"] = AppModel.shared.currentUser.id
        param["task_id"] = arrTaskData[selectedTaskIndex].id
        printData(param)
        serviceCallToCompleteTask(param)
    }
    
    @IBAction func clickToLoyaltyReedemption(_ sender: Any) {
        wakeUpView.removeFromSuperview()
        let vc : AvailableCouponVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "AvailableCouponVC") as! AvailableCouponVC
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
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
extension GlobalSearchVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "SingleLableVC", bundle: nil), forCellReuseIdentifier: "SingleLableVC")
        tblView.register(UINib.init(nibName: "CurrentTaskTVC", bundle: nil), forCellReuseIdentifier: "CurrentTaskTVC")
        tblView.register(UINib.init(nibName: "HotelsListTVC", bundle: nil), forCellReuseIdentifier: "HotelsListTVC")
        tblView.register(UINib.init(nibName: "RestaurantListTVC", bundle: nil), forCellReuseIdentifier: "RestaurantListTVC")
        tblView.register(UINib.init(nibName: "ProductListTVC", bundle: nil), forCellReuseIdentifier: "ProductListTVC")
        wakeTblView.register(UINib.init(nibName: "ExpandCollapseTVC", bundle: nil), forCellReuseIdentifier: "ExpandCollapseTVC")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == wakeTblView {
            return 0
        }
        return arrType.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell : SingleLableVC = tblView.dequeueReusableCell(withIdentifier: "SingleLableVC") as! SingleLableVC
        switch arrType[section] {
            case "life_style":
                cell.titleLbl.text = "Lifestyle"
            case "hotels":
                cell.titleLbl.text = "Hotels"
            case "restaurant":
                cell.titleLbl.text = "Restaurant"
            case "product":
                cell.titleLbl.text = "Product"
            default:
                break
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == wakeTblView {
            return arrTaskData[selectedTaskIndex].get_description.count
        }
        else {
            switch arrType[section] {
                case "life_style":
                    return arrTaskData.count
                case "hotels":
                    return arrHotel.count
                case "restaurant":
                    return arrRestaurant.count
                case "product":
                    return arrProduct.count
                default:
                    break
            }
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == wakeTblView {
            return UITableView.automaticDimension
        }
        switch arrType[indexPath.section] {
            case "life_style":
                return 120
            case "hotels":
                return 150
            case "restaurant":
                return 150
            case "product":
                return 110
            default:
                break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == wakeTblView {
            let cell : ExpandCollapseTVC = wakeTblView.dequeueReusableCell(withIdentifier: "ExpandCollapseTVC") as! ExpandCollapseTVC
            cell.setupDetails(arrTaskData[selectedTaskIndex].get_description[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
        else {
            if arrType[indexPath.section] == "life_style" {
                let cell : CurrentTaskTVC = tblView.dequeueReusableCell(withIdentifier: "CurrentTaskTVC") as! CurrentTaskTVC
                cell.setupDetails(arrTaskData[indexPath.row])
                cell.selectionStyle = .none
                return cell
            }
            else if arrType[indexPath.section] == "hotels" {
                let cell : HotelsListTVC = tblView.dequeueReusableCell(withIdentifier: "HotelsListTVC") as! HotelsListTVC
                cell.setupDetails(arrHotel[indexPath.row])
                cell.selectionStyle = .none
                return cell
            }
            else if arrType[indexPath.section] == "restaurant" {
                let cell : RestaurantListTVC = tblView.dequeueReusableCell(withIdentifier: "RestaurantListTVC") as! RestaurantListTVC
                cell.setupDetails(arrRestaurant[indexPath.row])
                cell.selectionStyle = .none
                return cell
            }
            else if arrType[indexPath.section] == "product" {
                let cell : ProductListTVC = tblView.dequeueReusableCell(withIdentifier: "ProductListTVC") as! ProductListTVC
                cell.setupDetails(arrProduct[indexPath.row])
                cell.selectionStyle = .none
                return cell
            }
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == wakeTblView {
            arrTaskData[selectedTaskIndex].get_description[indexPath.row].isExpand = !arrTaskData[selectedTaskIndex].get_description[indexPath.row].isExpand
            wakeTblView.reloadData()
            updateWakeupTableviewHeight()
        }
        else {
            if arrType[indexPath.section] == "life_style" {
                selectedTaskIndex = indexPath.row
                displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: wakeUpView)
                updateWakeupTableviewHeight()
                
                let dict = arrTaskData[selectedTaskIndex]
                taskTitleLbl.text = dict.get_life_style.title
                taskTimeLbl.text = ""
                if dict.get_life_style.task_start_date_time != "" && dict.get_life_style.task_end_date_time != "" {
                    if let startDate = getDateFromDateString(date: dict.get_life_style.task_start_date_time, format: "yyyy-MM-dd hh:mm:ss") {
                        if let endDate = getDateFromDateString(date: dict.get_life_style.task_end_date_time, format: "yyyy-MM-dd hh:mm:ss") {
                            taskTimeLbl.text = getLocalDateStringFromDate(date: startDate, format: "hh:mm a") + " - " + getLocalDateStringFromDate(date: endDate, format: "hh:mm a")
                        }
                    }
                    if taskTimeLbl.text == "" {
                        taskTimeLbl.text = dict.get_life_style.task_start_date_time.components(separatedBy: " ").last! + " - " + dict.get_life_style.task_end_date_time.components(separatedBy: " ").last!
                    }
                }
            }
            else if arrType[indexPath.section] == "hotels" {
                let vc : HotelDetailVC = STORYBOARD.HOTEL.instantiateViewController(withIdentifier: "HotelDetailVC") as! HotelDetailVC
                vc.hotelData = arrHotel[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if arrType[indexPath.section] == "restaurant" {
                let vc : RestaurantDetailVC = STORYBOARD.RESTAURANT.instantiateViewController(withIdentifier: "RestaurantDetailVC") as! RestaurantDetailVC
                vc.restaurantData = arrRestaurant[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if arrType[indexPath.section] == "product" {
                let vc : ProductDetailVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
                vc.productData = arrProduct[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func updateWakeupTableviewHeight() {
        constraintHeightWakeTbl.constant = CGFloat.greatestFiniteMagnitude
        wakeTblView.reloadData()
        wakeTblView.layoutIfNeeded()
        constraintHeightWakeTbl.constant = wakeTblView.contentSize.height
    }
}

extension GlobalSearchVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTxt {
            if (textField.text?.trimmed.count)! > 2 {
                serviceCallToGlobalSearch(textField.text!)
            }
            else{
                displayToast("The search text must be at least 3 characters.")
            }
        }
        return true
    }
}

extension GlobalSearchVC {
    func serviceCallToGlobalSearch(_ search : String) {
        self.view.endEditing(true)
        var param = [String : Any]()
        param["s"] = searchTxt.text
        param["user_id"] = AppModel.shared.currentUser.id
        HomeAPIManager.shared.serviceCallToGlobalSearch(param) { (dict) in
            self.arrHotel = [HotelModel]()
            self.arrRestaurant = [RestaurantModel]()
            self.arrTaskData = [TaskModel]()
            self.arrProduct = [ProductModel]()
            self.arrType = [String]()
            if let tempData = dict["life_style"] as? [[String : Any]], tempData.count > 0 {
                for temp in tempData {
                    self.arrTaskData.append(TaskModel.init(temp))
                }
                self.arrType.append("life_style")
            }
            if let tempData = dict["hotels"] as? [[String : Any]], tempData.count > 0 {
                for temp in tempData {
                    self.arrHotel.append(HotelModel.init(temp))
                }
                self.arrType.append("hotels")
            }
            if let tempData = dict["restaurant"] as? [[String : Any]], tempData.count > 0 {
                for temp in tempData {
                    self.arrRestaurant.append(RestaurantModel.init(temp))
                }
                self.arrType.append("restaurant")
            }
            if let tempData = dict["product"] as? [[String : Any]], tempData.count > 0 {
                for temp in tempData {
                    self.arrProduct.append(ProductModel.init(temp))
                }
                self.arrType.append("product")
            }
            self.tblView.reloadData()
            self.noDataLbl.isHidden = (self.arrType.count > 0)
        }
    }
    
    func serviceCallToCompleteTask(_ param : [String : Any]) {
        HomeAPIManager.shared.serviceCallToCompleteTask(param) {
            self.wakeUpView.removeFromSuperview()
            self.arrTaskData.remove(at: self.selectedTaskIndex)
            if self.arrTaskData.count == 0 {
                let index = self.arrType.firstIndex { (temp) -> Bool in
                    temp == "life_style"
                }
                if index != nil {
                    self.arrType.remove(at: index!)
                }
            }
            self.tblView.reloadData()
            self.noDataLbl.isHidden = (self.arrType.count > 0)
            NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFRESH_COMPLETE_TASK), object: nil)
        }
    }
}
