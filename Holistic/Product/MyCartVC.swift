//
//  MyCartVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 28/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import DropDown

class MyCartVC: UIViewController {

    @IBOutlet weak var totalItemLbl: Label!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constraintHeightTblView: NSLayoutConstraint!
    @IBOutlet weak var subTotalLbl: Label!
    @IBOutlet weak var shippingLbl: Label!
    @IBOutlet weak var taxLbl: Label!
    @IBOutlet weak var totalPriceLbl: Label!
    @IBOutlet weak var myScroll: UIScrollView!
    @IBOutlet weak var noDataView: UIView!
    
    var arrCartData = [CartModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        noDataView.isHidden = true
        myScroll.isHidden = true
        registerTableViewMethod()
        serviceCallToGetMyCart()
    }
    
    func setupDetails() {
        var price = 0.0
        for tempData in arrCartData {
            for temp in tempData.get_product {
                price += Double(temp.price!)!
            }
        }
        if arrCartData.count > 1 {
            totalItemLbl.text = String(arrCartData.count) + " item"
        }else{
            totalItemLbl.text = String(arrCartData.count) + " items"
        }
        subTotalLbl.text = displayPriceWithCurrency(String(price))
        shippingLbl.text = displayPriceWithCurrency("10")
        taxLbl.text = "5% VAT"
        price += 10
        price = price + (price * 0.05)
        totalPriceLbl.text = displayPriceWithCurrency(String(price))
        
        noDataView.isHidden = (arrCartData.count > 0)
        myScroll.isHidden = (arrCartData.count == 0)
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToContinueShopping(_ sender: Any) {
        self.view.endEditing(true)
        var isRedirect = false
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: ProductListVC.self) {
                isRedirect = true
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        if !isRedirect {
            let vc : ProductListVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "ProductListVC") as! ProductListVC
            UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func clickToProcessToCheckout(_ sender: Any) {
        let vc : ContactInformationVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "ContactInformationVC") as! ContactInformationVC
        vc.arrCartData = arrCartData
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
            self.serviceCallToRemoveProductFromCart(self.arrCartData[indexPath.row].id)
            self.arrCartData.remove(at: indexPath.row)
            self.updateDetailTableviewHeight()
            self.setupDetails()
            return true
        }
        cell.rightButtons = [deleteBtn]
        cell.rightSwipeSettings.transition = .drag
        cell.qtyBtn.tag = indexPath.row
        cell.qtyBtn.addTarget(self, action: #selector(clickToSelectQuantity(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func clickToSelectQuantity(_ sender: UIButton) {
        var arrData = [String]()
        for i in 1...5 {
            arrData.append(String(i))
        }
        let dropDown = DropDown()
        dropDown.anchorView = sender
        dropDown.dataSource = arrData
        dropDown.selectionAction = { [unowned self] (dropindex: Int, item: String) in
            self.arrCartData[sender.tag].qty = Int(item)
            self.tblView.reloadRows(at: [IndexPath(item: sender.tag, section: 0)], with: .automatic)
        }
        dropDown.show()
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
        ProductAPIManager.shared.serviceCallToGetMyCart(true) { (data) in
            self.arrCartData = [CartModel]()
            for temp in data {
                self.arrCartData.append(CartModel.init(temp))
            }
            self.tblView.reloadData()
            self.updateDetailTableviewHeight()
            self.setupDetails()
        }
    }
    
    func serviceCallToRemoveProductFromCart(_ id : Int) {
        ProductAPIManager.shared.serviceCallToRemoveProductFromCart(["id" : id]) {
            
        }
    }
}
