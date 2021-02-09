//
//  AvailableCouponVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 19/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import FSPagerView

class AvailableCouponVC: UIViewController {

    @IBOutlet weak var pointLbl: Label!
    @IBOutlet weak var myPageControl: UIPageControl!
    @IBOutlet weak var myPageView: FSPagerView!
    
    var arrOffer = [OfferModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(setupDetail), name: NSNotification.Name.init(NOTIFICATION.UPDATE_CURRENT_USER_DATA), object: nil)
        registerPagerView()
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

extension AvailableCouponVC : FSPagerViewDelegate, FSPagerViewDataSource {
    
    func registerPagerView() {
        myPageView.transformer = FSPagerViewTransformer(type: .overlap)
        myPageView.register(UINib.init(nibName: "LoyalityPointCVC", bundle: nil), forCellWithReuseIdentifier: "LoyalityPointCVC")
        myPageView.itemSize = CGSize(width: myPageView.frame.size.width, height: myPageView.frame.size.height)
        myPageView.decelerationDistance = FSPagerView.automaticDistance
        myPageView.reloadData()
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return arrOffer.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell : LoyalityPointCVC = pagerView.dequeueReusableCell(withReuseIdentifier: "LoyalityPointCVC", at: index) as! LoyalityPointCVC
        cell.setupDetails(arrOffer[index])
        cell.redeemBtn.isHidden = false
        cell.getCodeBtn.isHidden = true
        cell.redeemBtn.tag = index
        cell.redeemBtn.addTarget(self, action: #selector(clickToRedeem(_:)), for: .touchUpInside)
        return cell
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        myPageControl.currentPage = pagerView.currentIndex
    }
    
    @IBAction func clickToRedeem(_ sender: UIButton) {
        serviceCallToBookmarkOffer(arrOffer[sender.tag].id)
    }
}

extension AvailableCouponVC {
    func serviceCallToGetOffer() {
        ProfileAPIManager.shared.serviceCallToGetOffer { (data) in
            self.arrOffer = [OfferModel]()
            for temp in data {
                self.arrOffer.append(OfferModel.init(temp))
            }
            self.myPageView.reloadData()
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
