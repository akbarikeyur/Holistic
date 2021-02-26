//
//  PurchaseProductCVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 30/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class PurchaseProductCVC: UICollectionViewCell {

    @IBOutlet weak var productLbl: Label!
    @IBOutlet weak var invoiceLbl: Label!
    @IBOutlet weak var dateTimeLbl: Label!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constraintHeightTblView: NSLayoutConstraint!
    @IBOutlet weak var totalLbl: Label!
    @IBOutlet weak var downBtn: UIButton!
    
    var arrProduct = [ProductModel]()
    var order = OrderModel.init([String : Any]())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerTableViewMethod()
    }
    
    func setupDetail(_ dict : OrderModel) {
        order = dict
        arrProduct = [ProductModel]()
        arrProduct.append(dict.get_product)
        tblView.reloadData()
        constraintHeightTblView.constant = CGFloat(arrProduct.count * 125)
        
        if arrProduct.count > 1 {
            productLbl.text = String(arrProduct.count) + " Products"
        }else {
            productLbl.text = String(arrProduct.count) + " Product"
        }
        invoiceLbl.text = "Invoice#: " + String(dict.id)
        //2020-12-14T12:11:43.000000Z
        let tempDate = dict.created_at.components(separatedBy: ".").first!
        if let date = getDateFromDateString(date: tempDate, format: "yyyy-MM-dd'T'HH:mm:ss") {
            dateTimeLbl.text = "Order Date: " + getDateStringFromDate(date: date, format: "MMMM d yyyy, h:mm a")
        }else {
            dateTimeLbl.text = "Order Date: " + tempDate
        }
        totalLbl.text = "Invoice total: " + displayPriceWithCurrency(dict.price)
    }

}

//MARK:- Tableview Method
extension PurchaseProductCVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "PurchaseProductTVC", bundle: nil), forCellReuseIdentifier: "PurchaseProductTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProduct.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PurchaseProductTVC = tblView.dequeueReusableCell(withIdentifier: "PurchaseProductTVC") as! PurchaseProductTVC
        let dictOrder = order.get_product
        if (dictOrder?.product_single_image.count)! > 0 {
            setImageBackgroundImage(cell.imgView, (dictOrder?.product_single_image[0].url)!, IMAGE.PLACEHOLDER)
        }
        cell.priceLbl.text = displayPriceWithCurrency((dictOrder?.price)!)
        cell.qtyLbl.text = "Qty: " + String(order.qty)
        cell.descLbl.text = dictOrder?.name
        cell.quantityLbl.text = "x" + String(order.qty)
        cell.orderLbl.text = "Order No " + String(order.id)
        cell.statusLbl.text = "Status: " + order.status.capitalized
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
