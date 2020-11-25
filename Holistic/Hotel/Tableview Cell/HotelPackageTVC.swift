//
//  HotelPackageTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 27/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import TagListView

class HotelPackageTVC: UITableViewCell, TagListViewDelegate {

    @IBOutlet weak var packagePriceLbl: Label!
    @IBOutlet weak var benifitsCV: UICollectionView!
    @IBOutlet weak var packageTagView: TagListView!
    @IBOutlet weak var constraintHeightPackageTagView: NSLayoutConstraint!
    
    var arrFacility = [AmunitiesModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        registerCollectionView()
    }

    func setupDetails(_ dict : PackageModel) {
        var arrTags = [String]()
        for temp in dict.get_includes {
            arrTags.append(temp.name)
        }
        packageTagView.delegate = self
        packageTagView.removeAllTags()
        packageTagView.addTags(arrTags)
        packageTagView.reloadInputViews()
        constraintHeightPackageTagView.constant = packageTagView.intrinsicContentSize.height
        arrFacility = dict.get_amunities
        benifitsCV.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

//MARK:- CollectionView Method
extension HotelPackageTVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        benifitsCV.register(UINib.init(nibName: "HotelBenefitsCVC", bundle: nil), forCellWithReuseIdentifier: "HotelBenefitsCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFacility.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = arrFacility[indexPath.row].name
        label.sizeToFit()
        return CGSize(width: label.frame.width + 45, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HotelBenefitsCVC = benifitsCV.dequeueReusableCell(withReuseIdentifier: "HotelBenefitsCVC", for: indexPath) as! HotelBenefitsCVC
        let dict = arrFacility[indexPath.row]
        setButtonImage(cell.imgBtn, dict.get_icon.get_single_icon_media.url, IMAGE.PLACEHOLDER)
        cell.titleLbl.text = dict.name
        return cell
    }
}
