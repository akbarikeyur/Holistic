//
//  AvailableCouponVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 19/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class AvailableCouponVC: UIViewController {

    @IBOutlet weak var pointLbl: Label!
    @IBOutlet weak var pointCV: UICollectionView!
    @IBOutlet weak var myPageControl: UIPageControl!
    
    var arrOffer = [OfferModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(setupDetail), name: NSNotification.Name.init(NOTIFICATION.UPDATE_CURRENT_USER_DATA), object: nil)
        registerCollectionView()
        myPageControl.numberOfPages = 0
        setupDetail()
        serviceCallToGetOffer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
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

    @IBAction func clickToNotification(_ sender: Any) {
        let vc : NotificationVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
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
extension AvailableCouponVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        pointCV.register(UINib.init(nibName: "LoyalityPointCVC", bundle: nil), forCellWithReuseIdentifier: "LoyalityPointCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOffer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : LoyalityPointCVC = pointCV.dequeueReusableCell(withReuseIdentifier: "LoyalityPointCVC", for: indexPath) as! LoyalityPointCVC
        cell.setupDetails(arrOffer[indexPath.row])
        cell.redeemBtn.isHidden = false
        cell.getCodeBtn.isHidden = true
        cell.redeemBtn.tag = indexPath.row
        cell.redeemBtn.addTarget(self, action: #selector(clickToRedeem(_:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    @IBAction func clickToRedeem(_ sender: UIButton) {
        serviceCallToBookmarkOffer(arrOffer[sender.tag].id)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.pointCV.contentOffset, size: self.pointCV.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.pointCV.indexPathForItem(at: visiblePoint) {
            self.myPageControl.currentPage = visibleIndexPath.row
        }
    }
}

extension AvailableCouponVC {
    func serviceCallToGetOffer() {
        ProfileAPIManager.shared.serviceCallToGetOffer { (data) in
            self.arrOffer = [OfferModel]()
            for temp in data {
                self.arrOffer.append(OfferModel.init(temp))
            }
            self.pointCV.reloadData()
            self.myPageControl.numberOfPages = self.arrOffer.count
        }
    }
    
    func serviceCallToBookmarkOffer(_ id : Int) {
        var param = [String : Any]()
        param["offer_id"] = id
        param["user_id"] = AppModel.shared.currentUser.id
        ProfileAPIManager.shared.serviceCallToBookmarkOffer(param) {
            displayToast("Coupon has been added to Redeemed section, you can activate from there.")
        }
    }
}
