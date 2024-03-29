//
//  RedeemedCouponVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 03/02/21.
//  Copyright © 2021 Keyur Akbari. All rights reserved.
//

import UIKit

class RedeemedCouponVC: UIViewController {

    @IBOutlet weak var pointLbl: Label!
    @IBOutlet weak var pointCV: UICollectionView!
    @IBOutlet weak var noDataView: UIView!
    
    var arrOffer = [OfferModel]()
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(setupDetail), name: NSNotification.Name.init(NOTIFICATION.UPDATE_CURRENT_USER_DATA), object: nil)
        registerCollectionView()
        AppDelegate().sharedDelegate().serviceCallToGetUserDetail()
        setupDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
        noDataView.isHidden = true
        if arrOffer.count == 0 {
            serviceCallToGetBookmarkOffer()
        }
    }
    
    @objc func setupDetail() {
        pointLbl.text = String(AppModel.shared.currentUser.points)
        if AppModel.shared.currentUser.points > 1 {
            pointLbl.text = pointLbl.text! + "pts"
        }else{
            pointLbl.text = pointLbl.text! + "pt"
        }
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToMyOffer(_ sender: Any) {
        let vc : AvailableCouponVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "AvailableCouponVC") as! AvailableCouponVC
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

//MARK:- CollectionView Method
extension RedeemedCouponVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        pointCV.register(UINib.init(nibName: "LoyalityPointCVC", bundle: nil), forCellWithReuseIdentifier: "LoyalityPointCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOffer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : LoyalityPointCVC = pointCV.dequeueReusableCell(withReuseIdentifier: "LoyalityPointCVC", for: indexPath) as! LoyalityPointCVC
        cell.setupDetails(arrOffer[indexPath.row])
        cell.redeemBtn.isHidden = true
        cell.getCodeBtn.isHidden = false
        cell.getCodeBtn.tag = indexPath.row
        cell.getCodeBtn.addTarget(self, action: #selector(clickToGetCode(_:)), for: .touchUpInside)
        cell.removeBtn.isHidden = false
        cell.removeBtn.tag = indexPath.row
        cell.removeBtn.addTarget(self, action: #selector(clickToRemove(_:)), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if page != 0 && (arrOffer.count-1 == indexPath.row) {
            serviceCallToGetBookmarkOffer()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    @IBAction func clickToGetCode(_ sender: UIButton) {
        let dict = arrOffer[sender.tag]
        if dict.points_required > AppModel.shared.currentUser.points {
            let required = dict.points_required - AppModel.shared.currentUser.points
            let message = "You need " + String(required) + " more points to generate code."
            showAlert("", message: message) {
                
            }
            return
        }
        serviceCallToGetOfferCode(arrOffer[sender.tag])
    }
    
    @IBAction func clickToRemove(_ sender: UIButton) {
        serviceCallToRemoveBookmarkOffer(arrOffer[sender.tag].id)
    }
}

extension RedeemedCouponVC {
    func serviceCallToGetBookmarkOffer() {
        ProfileAPIManager.shared.serviceCallToGetBookmarkOffer(page, ["user_id" : AppModel.shared.currentUser.id!]) { (data, last) in
            if self.page == 1 {
                self.arrOffer = [OfferModel]()
            }
            for temp in data {
                if let get_offer = temp["get_offer"] as? [String : Any] {
                    self.arrOffer.append(OfferModel.init(get_offer))
                }
            }
            if last > self.page {
                self.page += 1
            }else{
                self.page = 0
            }
            self.pointCV.reloadData()
            self.noDataView.isHidden = (self.arrOffer.count > 0)
        }
    }
    
    func serviceCallToRemoveBookmarkOffer(_ id : Int) {
        var param = [String : Any]()
        param["offer_id"] = id
        param["user_id"] = AppModel.shared.currentUser.id
        ProfileAPIManager.shared.serviceCallToRemoveBookmarkOffer(param) {
            let index = self.arrOffer.firstIndex { (temp) -> Bool in
                temp.id == id
            }
            if index != nil {
                self.arrOffer.remove(at: index!)
                self.pointCV.reloadData()
                self.noDataView.isHidden = (self.arrOffer.count > 0)
            }
        }
    }
    
    func serviceCallToGetOfferCode(_ offerData : OfferModel) {
        var param = [String : Any]()
        param["offer_id"] = offerData.id
        param["user_id"] = AppModel.shared.currentUser.id
        param["points_spent"] = offerData.points_required
        printData(param)
        ProfileAPIManager.shared.serviceCallToGetOfferCode(param) { (dict) in
            if AppModel.shared.getStringValue(dict, "code") != "" {
                let vc : LoyalityDetailVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "LoyalityDetailVC") as! LoyalityDetailVC
                vc.offerData = offerData
                vc.code = AppModel.shared.getStringValue(dict, "code")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
