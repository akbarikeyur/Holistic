//
//  RestaurantDetailVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 27/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class RestaurantDetailVC: UIViewController {

    @IBOutlet weak var restaurantImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var starView: FloatRatingView!
    @IBOutlet weak var addressLbl: Label!
    @IBOutlet weak var descLbl: Label!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constraintHeightTblView: NSLayoutConstraint!
    @IBOutlet var codeView: UIView!
    @IBOutlet weak var codeLbl: Label!
    var restaurantData = RestaurantModel.init([String : Any]())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        serviceCallToGetRestaurantDetail()
        setupDetails()
    }
    
    func setupDetails() {
        if restaurantData.get_restaurant_media.count > 0 {
            setImageBackgroundImage(restaurantImgView, restaurantData.get_restaurant_media[0].url, IMAGE.PLACEHOLDER)
        }
        starView.rating = restaurantData.ratings
        nameLbl.text = restaurantData.title
        addressLbl.text = restaurantData.address
        descLbl.text = restaurantData.desc.html2String
        tblView.reloadData()
        updateTableviewHeight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToGetCode(_ sender: Any) {
        serviceCallToGenerateCode()
    }
    
    @IBAction func clickToCloseCodeView(_ sender: Any) {
        codeView.removeFromSuperview()
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
extension RestaurantDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "FoodListSectionTVC", bundle: nil), forCellReuseIdentifier: "FoodListSectionTVC")
        tblView.register(UINib.init(nibName: "FoodListTVC", bundle: nil), forCellReuseIdentifier: "FoodListTVC")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return restaurantData.get_restaurant_category.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell : FoodListSectionTVC = tblView.dequeueReusableCell(withIdentifier: "FoodListSectionTVC") as! FoodListSectionTVC
        cell.titleLbl.text = restaurantData.get_restaurant_category[section].category_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantData.get_restaurant_category[section].get_restaurant_menu.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FoodListTVC = tblView.dequeueReusableCell(withIdentifier: "FoodListTVC") as! FoodListTVC
        cell.setupDetails(restaurantData.get_restaurant_category[indexPath.section].get_restaurant_menu[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func updateTableviewHeight() {
        constraintHeightTblView.constant = CGFloat.greatestFiniteMagnitude
        tblView.reloadData()
        tblView.layoutIfNeeded()
        constraintHeightTblView.constant = tblView.contentSize.height
    }
}

//MARK:- Service called
extension RestaurantDetailVC {
    func serviceCallToGetRestaurantDetail() {
        RestaurantAPIManager.shared.serviceCallToGetRestaurantDetail(["id" : restaurantData.id!]) { (dict) in
            self.restaurantData = RestaurantModel.init(dict)
            self.setupDetails()
        }
    }
    
    func serviceCallToGenerateCode() {
        var param = [String : Any]()
        param["listing_id"] = restaurantData.id
        param["user_id"] = AppModel.shared.currentUser.id
        HotelAPIManager.shared.serviceCallToGenerateCode(param) { (code) in
            self.codeLbl.text = code
            displaySubViewtoParentView(self.view, subview: self.codeView)
        }
    }
}
