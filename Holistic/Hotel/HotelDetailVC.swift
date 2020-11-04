//
//  HotelDetailVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 27/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import TagListView

class HotelDetailVC: UIViewController {

    @IBOutlet weak var topImgView: UIImageView!
    @IBOutlet weak var imageCV: UICollectionView!
    @IBOutlet weak var starView: FloatRatingView!
    @IBOutlet weak var priceLbl: Label!
    @IBOutlet weak var hotelNameLbl: Label!
    @IBOutlet weak var hotelAddressLbl: Label!
    @IBOutlet weak var hotelDescLbl: Label!
    @IBOutlet weak var showPackageLbl: Label!
    @IBOutlet weak var packageBtn: Button!
    @IBOutlet weak var packageTbl: UITableView!
    @IBOutlet weak var constraintHeightPackageTbl: NSLayoutConstraint!
    @IBOutlet weak var facilityCV: UICollectionView!
    @IBOutlet weak var constraintHeightFacilityCV: NSLayoutConstraint!
    @IBOutlet var codeView: UIView!
    
    var selectedImageIndex = 3
    var arrFacility = ["Swimming Pool", "Free WiFi", "Family Rooms", "Free parking", "Good fitness", "Tea/coffee maker", "Bar", "Beach front", "Restaurants", "Airport Shuttle"]
    var arrFacilityImg = ["swimming_pool", "free_wifi", "family_room", "free_parking", "good_fitness", "tea_maker", "bar", "beach_front", "restaurant", "airport_shuttle"]
    var arrImage = ["hotel1", "hotel2", "hotel3", "hotel4", "hotel5", "hotel6", "hotel7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCollectionView()
        registerTableViewMethod()
        constraintHeightFacilityCV.constant = CGFloat((arrFacility.count/2) * 100)
        
        setupDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    func setupDetails() {
        priceLbl.text = "AED 250"
        hotelNameLbl.text = "Jumeirah Emirates Towers"
        hotelAddressLbl.text = "Sheikh Zayed Road, Al Barsha, Dubai UAE."
        hotelDescLbl.text = "Directly connected to Mall of the Emirates, Kempinski Hotel Mall of the Emirates is centrally situated with close proximity to areas such as Downtown Dubai, Dubai Marina and Palm Jumeirah​, with the Mall of the Emirates metro station a mere 5 minute walk. ​Guests enjoy."
        
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickToShowAllPackage(_ sender: UIButton) {
        packageBtn.isSelected = !packageBtn.isSelected
        updatePackageTableviewHeight()
        if packageBtn.isSelected {
            showPackageLbl.text = "Show Less"
        }else{
            showPackageLbl.text = "Show All Packages"
        }
    }
    
    @IBAction func clickToGetCode(_ sender: Any) {
        displaySubViewtoParentView(self.view, subview: codeView)
    }
    
    @IBAction func clickToCloseCodeView(_ sender: Any) {
        codeView.removeFromSuperview()
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
extension HotelDetailVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        imageCV.register(UINib.init(nibName: "HotelImageCVC", bundle: nil), forCellWithReuseIdentifier: "HotelImageCVC")
        facilityCV.register(UINib.init(nibName: "HotelFacilityCVC", bundle: nil), forCellWithReuseIdentifier: "HotelFacilityCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCV {
            return arrImage.count
        }
        else{
            return arrFacility.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageCV {
            return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
        }
        else{
            return CGSize(width: collectionView.frame.size.width/2, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCV {
            let cell : HotelImageCVC = imageCV.dequeueReusableCell(withReuseIdentifier: "HotelImageCVC", for: indexPath) as! HotelImageCVC
            cell.setupDetails((indexPath.row == selectedImageIndex))
            cell.imgView.image = UIImage(named: arrImage[indexPath.row])
            return cell
        }
        else{
            let cell : HotelFacilityCVC = facilityCV.dequeueReusableCell(withReuseIdentifier: "HotelFacilityCVC", for: indexPath) as! HotelFacilityCVC
            cell.setupDetails(arrFacility[indexPath.row], arrFacilityImg[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == imageCV {
            selectedImageIndex = indexPath.row
            imageCV.reloadData()
            topImgView.image = UIImage(named: arrImage[indexPath.row])
        }
    }
}

//MARK:- Tableview Method
extension HotelDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        packageTbl.register(UINib.init(nibName: "HotelPackageTVC", bundle: nil), forCellReuseIdentifier: "HotelPackageTVC")
        updatePackageTableviewHeight()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (packageBtn.isSelected) ? 3 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HotelPackageTVC = packageTbl.dequeueReusableCell(withIdentifier: "HotelPackageTVC") as! HotelPackageTVC
        cell.setupDetails()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func updatePackageTableviewHeight() {
        constraintHeightPackageTbl.constant = CGFloat.greatestFiniteMagnitude
        packageTbl.reloadData()
        packageTbl.layoutIfNeeded()
        constraintHeightPackageTbl.constant = packageTbl.contentSize.height
    }
}
