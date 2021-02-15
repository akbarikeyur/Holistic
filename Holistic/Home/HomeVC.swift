//
//  HomeVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import SexyTooltip

class HomeVC: UIViewController {

    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var flowerView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var searchTxt: TextField!
    @IBOutlet weak var tabCV: UICollectionView!
    @IBOutlet weak var cartLbl: Label!
    
    @IBOutlet var infoView: UIView!
    @IBOutlet weak var tool1Btn: UIButton!
    @IBOutlet weak var tool2Btn: UIButton!
    @IBOutlet weak var tool3Btn: UIButton!
    @IBOutlet weak var tool4Btn: UIButton!
    @IBOutlet weak var tool5Btn: UIButton!
    @IBOutlet weak var menuToolBtn: UIButton!
    
    var arrTabData = ["Holistic Lifestyle", "Holistic Clinic", "Holistic Restaurants", "Holistic Hotels", "Holistic Products"]
    var selectedTab = 0
    var toolIndex = 0
    
    let holisticTab : HolisticLifestyleTabVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "HolisticLifestyleTabVC") as! HolisticLifestyleTabVC
    let clinicTab : ClinicTabVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "ClinicTabVC") as! ClinicTabVC
    let restaurantTab : RestaurantTabVC = STORYBOARD.RESTAURANT.instantiateViewController(withIdentifier: "RestaurantTabVC") as! RestaurantTabVC
    let hotelTab : HotelsTabVC = STORYBOARD.HOTEL.instantiateViewController(withIdentifier: "HotelsTabVC") as! HotelsTabVC
    let productTab : ProductTabVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "ProductTabVC") as! ProductTabVC
    
    var infoTip = SexyTooltip.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(redirectToHomeLifestyle), name: NSNotification.Name.init(NOTIFICATION.REDIRECT_HOME_LIFESTYLE), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(redirectToHomeClinic), name: NSNotification.Name.init(NOTIFICATION.REDIRECT_HOME_CLINIC), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setupUserDetail), name: NSNotification.Name.init(NOTIFICATION.UPDATE_CURRENT_USER_DATA), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clickToNotification(_:)), name: NSNotification.Name.init(NOTIFICATION.REDIRECT_NOTIFICATION_SCREEN), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCartCount), name: NSNotification.Name.init(NOTIFICATION.UPDATE_CART_COUNT), object: nil)
        
        registerCollectionView()
        cartLbl.isHidden = true
        delay(2.0) {
            self.flowerView.isHidden = true
            self.selecteTab()
        }
        AppDelegate().sharedDelegate().serviceCallToGetCountry()
        AppDelegate().sharedDelegate().serviceCallToGetUserDetail()
        setupUserDetail()
        let date = getDateFromDateString(date: "2020-11-21 04:00 PM", format: "yyyy-MM-dd hh:mm a")
        print(date)
        
        AppDelegate().sharedDelegate().serviceCallToGetMyCart()
        if !isToolTipDisplayed() {
            displayToolTipView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
    }
    
    @objc func setupUserDetail() {
        if !isUserLogin() {
            return
        }
        nameLbl.text = AppModel.shared.currentUser.name.capitalized
    }
    
    @objc func redirectToHomeLifestyle() {
        selectedTab = 0
        selecteTab()
    }
    
    @objc func redirectToHomeClinic() {
        selectedTab = 1
        selecteTab()
    }
    
    @objc func updateCartCount() {
        if AppModel.shared.MY_CART_COUNT != nil && AppModel.shared.MY_CART_COUNT > 0 {
            cartLbl.text = String(AppModel.shared.MY_CART_COUNT)
            cartLbl.isHidden = false
        }else{
            cartLbl.isHidden = true
        }
    }
    
    //MARK:- Button click event
    @IBAction func clickToSideMenu(_ sender: Any) {
        self.menuContainerViewController.toggleLeftSideMenuCompletion {}
    }
    
    @IBAction func clickToNotification(_ sender: Any) {
        let vc : NotificationVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToFilter(_ sender: Any) {
        
    }
    
    @IBAction func clickToCart(_ sender: Any) {
        let vc : MyCartVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "MyCartVC") as! MyCartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToHideToolTip(_ sender: Any) {
        if infoTip != nil {
            infoTip.dismiss()
        }
    }
    /*
     @IBAction func clickToNotification(_ sender: Any) {
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK:- CollectionView Method
extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        tabCV.register(UINib.init(nibName: "TabCVC", bundle: nil), forCellWithReuseIdentifier: "TabCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTabData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = arrTabData[indexPath.row]
        label.sizeToFit()
        return CGSize(width: label.frame.width + 20, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : TabCVC = tabCV.dequeueReusableCell(withReuseIdentifier: "TabCVC", for: indexPath) as! TabCVC
        cell.titleLbl.text = arrTabData[indexPath.row]
        if selectedTab == indexPath.row {
            cell.titleLbl.textColor = OrangeColor
            cell.lineImg.isHidden = false
        }else{
            cell.titleLbl.textColor = BLACK_COLOR
            cell.lineImg.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTab = indexPath.row
        selecteTab()
    }
    
    func selecteTab() {
        resetContainerView()
        tabCV.reloadData()
        tabCV.scrollToItem(at: IndexPath(item: selectedTab, section: 0), at: .left, animated: true)
        if selectedTab == 0 {
            displaySubViewtoParentView(mainContainerView, subview: holisticTab.view)
            holisticTab.setupDetails()
        }
        else if selectedTab == 1 {
            displaySubViewtoParentView(mainContainerView, subview: clinicTab.view)
            clinicTab.setupDetails()
        }
        else if selectedTab == 2 {
            displaySubViewtoParentView(mainContainerView, subview: restaurantTab.view)
            restaurantTab.setupDetails()
        }
        else if selectedTab == 3 {
            displaySubViewtoParentView(mainContainerView, subview: hotelTab.view)
            hotelTab.setupDetails()
        }
        else if selectedTab == 4 {
            displaySubViewtoParentView(mainContainerView, subview: productTab.view)
            productTab.setupDetails()
        }
    }
    
    func resetContainerView()
    {
        holisticTab.view.removeFromSuperview()
        restaurantTab.view.removeFromSuperview()
        hotelTab.view.removeFromSuperview()
        productTab.view.removeFromSuperview()
    }
}

extension HomeVC {
    func serviceCallToGenerateToken() {
        ClinicAPIManager.shared.serviceCallToGenerateToken()
    }
}

extension HomeVC : SexyTooltipDelegate {
    func displayToolTipView() {
        displaySubViewtoParentView(AppDelegate().sharedDelegate().window, subview: infoView)
        infoView.addSubview(infoTip)
        toolIndex = 1
        presentToolTip()
    }
    
    func presentToolTip() {
        var tip = ""
        switch toolIndex {
            case 1:
                tip = getTranslate("lifestyle_msg")
                break
            case 2:
                tip = getTranslate("clinic_msg")
                break
            case 3:
                tip = getTranslate("hotel_msg")
                break
            case 4:
                tip = getTranslate("restaurant_msg")
                break
            case 5:
                tip = "Profile"
                break
            case 6:
                tip = "Menu"
                break
            default:
                break
        }
        infoTip = SexyTooltip.init(attributedString: attributedStringWithColor(tip, [tip], color: BLACK_COLOR, font: UIFont(name: APP_MEDIUM, size: 16.0)))
        infoTip.delegate = self
        switch toolIndex {
            case 1:
                infoTip.present(from: tool1Btn, in: infoView, animated: true)
                break
            case 2:
                infoTip.present(from: tool2Btn, in: infoView, animated: true)
                break
            case 3:
                infoTip.present(from: tool3Btn, in: infoView, animated: true)
                break
            case 4:
                infoTip.present(from: tool4Btn, in: infoView, animated: true)
                break
            case 5:
                infoTip.present(from: tool5Btn, in: infoView, animated: true)
                break
            case 6:
                infoTip.present(from: menuToolBtn, in: infoView, animated: true)
                break
            default:
                break
        }
        
    }
    
    func tooltipDidPresent(_ tooltip: SexyTooltip!) {
        
    }
    
    func tooltipWasTapped(_ tooltip: SexyTooltip!) {
        
    }
    
    func tooltipDidDismiss(_ tooltip: SexyTooltip!) {
        if toolIndex == 4 {
            infoView.removeFromSuperview()
            setToolTipDisplayed(true)
            return
        }
        toolIndex += 1
        presentToolTip()
    }
}
