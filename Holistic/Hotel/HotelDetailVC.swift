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
    
    var hotelData = HotelModel.init([String : Any]())
    var selectedImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCollectionView()
        registerTableViewMethod()
        
        serviceCallToGetHotelDetail()
        setupDetails()
    }
    
    func setupDetails() {
        starView.rating = hotelData.ratings
        priceLbl.text = displayPriceWithCurrency(hotelData.main_price)
        hotelNameLbl.text = hotelData.title
        hotelAddressLbl.text = hotelData.address
        hotelDescLbl.attributedText = hotelData.desc.html2AttributedString
        imageCV.reloadData()
        packageTbl.reloadData()
        updatePackageTableviewHeight()
        facilityCV.reloadData()
        constraintHeightFacilityCV.constant = CGFloat((hotelData.register_facility.count/2) * 100)
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
            return hotelData.get_hotels_media.count
        }
        else{
            return hotelData.register_facility.count
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
            setImageBackgroundImage(cell.imgView, hotelData.get_hotels_media[indexPath.row].url, IMAGE.PLACEHOLDER)
            return cell
        }
        else{
            let cell : HotelFacilityCVC = facilityCV.dequeueReusableCell(withReuseIdentifier: "HotelFacilityCVC", for: indexPath) as! HotelFacilityCVC
            cell.setupDetails(hotelData.register_facility[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == imageCV {
            selectedImageIndex = indexPath.row
            imageCV.reloadData()
            setImageBackgroundImage(topImgView, hotelData.get_hotels_media[indexPath.row].url, IMAGE.PLACEHOLDER)
        }
    }
}

//MARK:- Tableview Method
extension HotelDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        packageTbl.register(UINib.init(nibName: "HotelPackageTVC", bundle: nil), forCellReuseIdentifier: "HotelPackageTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hotelData.get_packages.count > 0 {
            return (packageBtn.isSelected) ? hotelData.get_packages.count : 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HotelPackageTVC = packageTbl.dequeueReusableCell(withIdentifier: "HotelPackageTVC") as! HotelPackageTVC
        cell.setupDetails(hotelData.get_packages[indexPath.row])
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

//MARK:- Service called
extension HotelDetailVC {
    func serviceCallToGetHotelDetail() {
        HotelAPIManager.shared.serviceCallToGetHotelDetail(["id" : hotelData.id!]) { (dict) in
            self.hotelData = HotelModel.init(dict)
            self.setupDetails()
        }
    }
}
