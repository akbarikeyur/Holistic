//
//  ProductDetailVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 28/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {

    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var imageCV: UICollectionView!
    @IBOutlet weak var productNameLbl: Label!
    @IBOutlet weak var referenceLbl: Label!
    @IBOutlet weak var stockLbl: Label!
    @IBOutlet weak var quantityLbl: Label!
    @IBOutlet weak var priceLbl: Label!
    @IBOutlet weak var totalQtyLbl: Label!
    @IBOutlet weak var deliveryLbl: Label!
    @IBOutlet weak var descLbl: Label!
    @IBOutlet weak var benifitBtn: Button!
    @IBOutlet weak var howUseBtn: Button!
    @IBOutlet weak var detailTbl: UITableView!
    @IBOutlet weak var constraintHeightDetailTbl: NSLayoutConstraint!
    @IBOutlet weak var productTbl: UITableView!
    @IBOutlet weak var constraintHeightProductTbl: NSLayoutConstraint!
    
    var productData = ProductModel.init([String : Any]())
    var arrOtherData = [ProductModel]()
    
    var selectedImageIndex = 0
    var arrDetails = ["Enterogermina helps in restoring the intestinal bacteria (flora) that constitutes a real defensive barrier against harmful bacteria.", "The balance of this flora can be upset by: Intestinal infections, Poisoning, Food disorders, Changes in diet, Or, use of antibiotics.", "Enterogermina helps in restoring the intestinal bacteria (flora) that constitutes."]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCollectionView()
        registerTableViewMethod()
        serviceCallToGetProductDetail()
    }
    
    func setupDetails() {
        productNameLbl.text = productData.name
        referenceLbl.text = String(productData.id)
        stockLbl.text = "Only " + String(productData.product_total_qty.qty) + " left in stock"
        priceLbl.text = "Price: " + displayPriceWithCurrency(productData.price)
        totalQtyLbl.text = String(productData.product_total_qty.total_qty)
        deliveryLbl.text = productData.delivery
        descLbl.text = productData.desc
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickToSelectQuantity(_ sender: UIButton) {
        
    }
    
    @IBAction func clickToAddToCart(_ sender: Any) {
        
    }
    
    @IBAction func clickToBenifitHowUse(_ sender: UIButton) {
        benifitBtn.layer.borderColor = ClearColor.cgColor
        howUseBtn.layer.borderColor = ClearColor.cgColor
        sender.layer.borderColor = BLACK_COLOR.cgColor
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
extension ProductDetailVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        imageCV.register(UINib.init(nibName: "HotelImageCVC", bundle: nil), forCellWithReuseIdentifier: "HotelImageCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productData.product_single_image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HotelImageCVC = imageCV.dequeueReusableCell(withReuseIdentifier: "HotelImageCVC", for: indexPath) as! HotelImageCVC
        cell.setupDetails(productData.product_single_image[indexPath.row], (indexPath.row == selectedImageIndex))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImageIndex = indexPath.row
        imageCV.reloadData()
        setImageBackgroundImage(productImgView, productData.product_single_image[indexPath.row].url, IMAGE.PLACEHOLDER)
    }
}

//MARK:- Tableview Method
extension ProductDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        productTbl.register(UINib.init(nibName: "ProductListTVC", bundle: nil), forCellReuseIdentifier: "ProductListTVC")
        detailTbl.register(UINib.init(nibName: "ProductDetailTVC", bundle: nil), forCellReuseIdentifier: "ProductDetailTVC")
        updateProductTableviewHeight()
        updateDetailTableviewHeight()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == detailTbl {
            return arrDetails.count
        }
        return arrOtherData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == detailTbl {
            return UITableView.automaticDimension
        }
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == detailTbl {
            let cell : ProductDetailTVC = detailTbl.dequeueReusableCell(withIdentifier: "ProductDetailTVC") as! ProductDetailTVC
            cell.topView.isHidden = false
            cell.bottomView.isHidden = false
            if indexPath.row == 0 {
                cell.topView.isHidden = true
            }
            else if indexPath.row == (arrDetails.count-1) {
                cell.bottomView.isHidden = true
            }
            cell.selectionStyle = .none
            return cell
        }
        else{
            let cell : ProductListTVC = productTbl.dequeueReusableCell(withIdentifier: "ProductListTVC") as! ProductListTVC
            cell.setupDetails(arrOtherData[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func updateProductTableviewHeight() {
        constraintHeightProductTbl.constant = CGFloat.greatestFiniteMagnitude
        productTbl.reloadData()
        productTbl.layoutIfNeeded()
        constraintHeightProductTbl.constant = productTbl.contentSize.height
    }
    
    func updateDetailTableviewHeight() {
        constraintHeightDetailTbl.constant = CGFloat.greatestFiniteMagnitude
        detailTbl.reloadData()
        detailTbl.layoutIfNeeded()
        constraintHeightDetailTbl.constant = detailTbl.contentSize.height
    }
}

extension ProductDetailVC {
    func serviceCallToGetProductDetail() {
        ProductAPIManager.shared.serviceCallToGetProductDetail(["id" : productData.id!]) { (dict, otherData) in
            self.productData = ProductModel.init(dict)
            self.arrOtherData = [ProductModel]()
            for temp in otherData {
                self.arrOtherData.append(ProductModel.init(temp))
            }
            self.setupDetails()
        }
    }
}
