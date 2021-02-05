//
//  RestaurantVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 27/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class RestaurantVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var exploreView: UIView!
    
    var arrRestaurant = [RestaurantModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        serviceCallToGetRestaurantList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
//        delay(1.0) {
//            displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: self.exploreView)
//        }
    }
    
    //MARK:- Button click event
    @IBAction func clickToSideMenu(_ sender: Any) {
        self.menuContainerViewController.toggleLeftSideMenuCompletion {}
    }
    
    @IBAction func clickToNotification(_ sender: Any) {
        let vc : NotificationVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToFilter(_ sender: Any) {
        
    }
    
    @IBAction func clickToCloseExploreView(_ sender: Any) {
       exploreView.removeFromSuperview()
   }
   
   @IBAction func clickToExploreNow(_ sender: Any) {
       exploreView.removeFromSuperview()
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
extension RestaurantVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "RestaurantListTVC", bundle: nil), forCellReuseIdentifier: "RestaurantListTVC")
        tblView.tableHeaderView = headerView
        tblView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRestaurant.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : RestaurantListTVC = tblView.dequeueReusableCell(withIdentifier: "RestaurantListTVC") as! RestaurantListTVC
        cell.setupDetails(arrRestaurant[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : RestaurantDetailVC = STORYBOARD.RESTAURANT.instantiateViewController(withIdentifier: "RestaurantDetailVC") as! RestaurantDetailVC
        vc.restaurantData = arrRestaurant[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- Service called
extension RestaurantVC {
    func serviceCallToGetRestaurantList() {
        RestaurantAPIManager.shared.serviceCallToGetRestaurantList { (data, is_last) in
            self.arrRestaurant = [RestaurantModel]()
            for temp in data {
                self.arrRestaurant.append(RestaurantModel.init(temp))
            }
            self.tblView.reloadData()
        }
    }
}
