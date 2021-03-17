//
//  OrderSummaryVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 29/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class OrderSummaryVC: UIViewController {

    @IBOutlet weak var contactLbl: Label!
    @IBOutlet weak var shipToLbl: Label!
    @IBOutlet weak var paymentTypeLbl: Label!
    @IBOutlet weak var addressLbl: Label!
    @IBOutlet weak var shippingAddressBtn: Button!
    @IBOutlet weak var differentAddressBtn: Button!
    @IBOutlet weak var addressTbl: UITableView!
    @IBOutlet weak var constraintHeightAddressTbl: NSLayoutConstraint!
    @IBOutlet weak var subTotalLbl: Label!
    @IBOutlet weak var shippingPriceLbl: Label!
    @IBOutlet weak var taxLbl: Label!
    @IBOutlet weak var totalPriceLbl: Label!
    
    var arrCartData = [CartModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        
        contactLbl.text = AppModel.shared.currentUser.phone_number
        
        shipToLbl.text = getUserAddress(AppModel.shared.currentUser)
        
        var price = 0.0
        for tempData in arrCartData {
            for temp in tempData.get_product {
                price += Double(temp.price!)!
            }
        }
        subTotalLbl.text = displayPriceWithCurrency(String(price))
        shippingPriceLbl.text = displayPriceWithCurrency("10")
        taxLbl.text = "5% VAT"
        price += 10
        price = price + (price * 0.05)
        totalPriceLbl.text = displayPriceWithCurrency(String(price))
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickToSelectAddress(_ sender: UIButton) {
        shippingAddressBtn.isSelected = false
        differentAddressBtn.isSelected = false
        sender.isSelected = true
    }
    
    @IBAction func clickToOrderNow(_ sender: Any) {
        self.view.endEditing(true)
        var param = [String : Any]()
        param["user_id"] = AppModel.shared.currentUser.id
        var arrData = [[String : Any]]()
        for temp in arrCartData {
            var dict = [String : Any]()
            dict["qty"] = temp.qty
            dict["product_id"] = temp.product_id
            if temp.get_product.count > 0 {
                dict["price"] = temp.get_product[0].price
            }
            arrData.append(dict)
        }
        param["products"] = arrData
        printData(param)
        ProductAPIManager.shared.serviceCallToProductPurchase(param) { (dict) in
            if let message = dict["message"] as? String, message == "product out of stock" {
                displayToast(message.capitalized)
            }else{
                ProductAPIManager.shared.serviceCallToClearFullCart(["user_id" : AppModel.shared.currentUser.id!]) {
                    
                }
                AppModel.shared.MY_CART_COUNT = 0
                NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.UPDATE_CART_COUNT), object: nil)
                let vc : MyPurchaseVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "MyPurchaseVC") as! MyPurchaseVC
                UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
            }
        }
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
extension OrderSummaryVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        addressTbl.register(UINib.init(nibName: "OrderSummaryTVC", bundle: nil), forCellReuseIdentifier: "OrderSummaryTVC")
        updateDetailTableviewHeight()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCartData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : OrderSummaryTVC = addressTbl.dequeueReusableCell(withIdentifier: "OrderSummaryTVC") as! OrderSummaryTVC
        cell.setupDetails(arrCartData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func updateDetailTableviewHeight() {
        constraintHeightAddressTbl.constant = CGFloat.greatestFiniteMagnitude
        addressTbl.reloadData()
        addressTbl.layoutIfNeeded()
        constraintHeightAddressTbl.constant = addressTbl.contentSize.height
    }
}
