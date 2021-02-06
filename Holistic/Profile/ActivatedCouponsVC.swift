//
//  ActivatedCouponsVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 06/02/21.
//  Copyright © 2021 Keyur Akbari. All rights reserved.
//

import UIKit

class ActivatedCouponsVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noDataLbl: Label!
    
    var arrOffer = [ActivedOfferModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        serviceCallToGetRedeemCodeList()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
extension ActivatedCouponsVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "MyCodeTVC", bundle: nil), forCellReuseIdentifier: "MyCodeTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOffer.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MyCodeTVC = tblView.dequeueReusableCell(withIdentifier: "MyCodeTVC") as! MyCodeTVC
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


extension ActivatedCouponsVC {
    
    func serviceCallToGetRedeemCodeList() {
        var param = [String : Any]()
        param["user_id"] = AppModel.shared.currentUser.id
        ProfileAPIManager.shared.serviceCallToGetRedeemCodeList(param) { (data) in
            
        }
    }
}
