//
//  MyCartVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 28/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class MyCartVC: UIViewController {

    @IBOutlet weak var totalItemLbl: Label!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constraintHeightTblView: NSLayoutConstraint!
    @IBOutlet weak var subTotalLbl: Label!
    @IBOutlet weak var shippingLbl: Label!
    @IBOutlet weak var taxLbl: Label!
    @IBOutlet weak var totalPriceLbl: Label!
    
    var arrCartData = [CartModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        serviceCallToGetMyCart()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToContinueShopping(_ sender: Any) {
        
    }
    
    @IBAction func clickToProcessToCheckout(_ sender: Any) {
        let vc : ContactInformationVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "ContactInformationVC") as! ContactInformationVC
        self.navigationController?.pushViewController(vc, animated: true)
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
extension MyCartVC : UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "ProductCartTVC", bundle: nil), forCellReuseIdentifier: "ProductCartTVC")
        updateDetailTableviewHeight()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCartData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductCartTVC = tblView.dequeueReusableCell(withIdentifier: "ProductCartTVC") as! ProductCartTVC
        cell.setupDetails(arrCartData[indexPath.row])
        cell.delegate = self
        let deleteBtn = MGSwipeButton(title: "", icon: UIImage(named: "delete"), backgroundColor: OrangeColor) { (sender: MGSwipeTableCell!) -> Bool in
            print("Convenience callback for swipe buttons!")
            return true
        }
        cell.rightButtons = [deleteBtn]
        cell.rightSwipeSettings.transition = .drag

        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, canSwipe direction: MGSwipeDirection) -> Bool {
        return true
    }
    
    func updateDetailTableviewHeight() {
        constraintHeightTblView.constant = CGFloat.greatestFiniteMagnitude
        tblView.reloadData()
        tblView.layoutIfNeeded()
        constraintHeightTblView.constant = tblView.contentSize.height
    }
}

extension MyCartVC {
    func serviceCallToGetMyCart() {
        ProductAPIManager.shared.serviceCallToGetMyCart { (data) in
            self.arrCartData = [CartModel]()
            for temp in data {
                self.arrCartData.append(CartModel.init(temp))
            }
            self.tblView.reloadData()
            self.updateDetailTableviewHeight()
            
            
            var price = 0.0
            for tempData in self.arrCartData {
                for temp in tempData.get_product {
                    price += Double(temp.price!)!
                }
            }
            self.subTotalLbl.text = displayPriceWithCurrency(String(price))
            self.shippingLbl.text = displayPriceWithCurrency("10")
            self.taxLbl.text = "5% VAT"
            price += 10
            price = price + (price * 0.05)
            self.totalPriceLbl.text = displayPriceWithCurrency(String(price))
        }
    }
}
