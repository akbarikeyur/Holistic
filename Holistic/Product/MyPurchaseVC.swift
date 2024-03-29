//
//  MyPurchaseVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 29/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class MyPurchaseVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchTxt: TextField!
    @IBOutlet weak var purchaseCV: UICollectionView!
    @IBOutlet weak var constraintHeightPurchaseCV: NSLayoutConstraint!
    @IBOutlet weak var fromTxt: TextField!
    @IBOutlet weak var toTxt: TextField!
    @IBOutlet weak var totalOrderLbl: Label!
    
    var page = 1
    var arrPurchase = [OrderModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        topView.isHidden = true
        registerCollectionView()
        serviceCallToGetPurchaseProductHistory()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        var isRedirect = false
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: ProductListVC.self) || controller.isKind(of: HomeVC.self) {
                isRedirect = true
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        if !isRedirect {
            AppDelegate().sharedDelegate().navigateToDashBoard()
        }
    }

    @IBAction func clickToFilter(_ sender: Any) {
        
    }
    
    @IBAction func clickToSelectFromDate(_ sender: Any) {
        
    }
    
    @IBAction func clickToSelectToDate(_ sender: Any) {
        
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
//MARK:- CollectionView Method
extension MyPurchaseVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        purchaseCV.register(UINib.init(nibName: "PurchaseProductCVC", bundle: nil), forCellWithReuseIdentifier: "PurchaseProductCVC")
        updateProductHeight()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPurchase.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 245)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PurchaseProductCVC = purchaseCV.dequeueReusableCell(withReuseIdentifier: "PurchaseProductCVC", for: indexPath) as! PurchaseProductCVC
        cell.setupDetail(arrPurchase[indexPath.row])
        return cell
    }
}

extension MyPurchaseVC {
    func serviceCallToGetPurchaseProductHistory() {
        var param = [String : Any]()
        param["user_id"] = AppModel.shared.currentUser.id
        ProductAPIManager.shared.serviceCallToGetPurchaseProductHistory(page, param) { (data, is_last) in
            self.arrPurchase = [OrderModel]()
            for temp in data {
                self.arrPurchase.append(OrderModel.init(temp))
            }
            if data.count < 10 {
                self.page = 0
            }else{
                self.page += 1
            }
            self.purchaseCV.reloadData()
            self.updateProductHeight()
            self.totalOrderLbl.text = String(self.arrPurchase.count) + " Displaying all orders"
        }
    }
    
    func updateProductHeight() {
        constraintHeightPurchaseCV.constant = CGFloat(245 * arrPurchase.count)
    }
}
