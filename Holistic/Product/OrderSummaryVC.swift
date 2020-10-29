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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : OrderSummaryTVC = addressTbl.dequeueReusableCell(withIdentifier: "OrderSummaryTVC") as! OrderSummaryTVC
        
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
