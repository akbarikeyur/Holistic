//
//  ProductDetailVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 28/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import DropDown

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
    @IBOutlet weak var benifitUseTitleLbl: Label!
    @IBOutlet weak var benifitUseValueLbl: Label!
    @IBOutlet weak var otherProductView: UIView!
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
        referenceLbl.text = "Ref: " + String(productData.id)
        if productData.product_total_qty_in_count > 10 {
            stockLbl.text = String(productData.product_total_qty_in_count) + " left in stock"
        }else{
            stockLbl.text = "Only " + String(productData.product_total_qty_in_count) + " left in stock"
        }
        priceLbl.text = "Price: " + displayPriceWithCurrency(productData.price)
        totalQtyLbl.text = "Qty: " + String(productData.product_total_qty_in_count)
        deliveryLbl.text = productData.delivery
        descLbl.text = productData.desc.html2String
        clickToBenifitHowUse(benifitBtn)
        
        if productData.product_single_image.count > 0 {
            setImageBackgroundImage(productImgView, productData.product_single_image[0].url, IMAGE.PLACEHOLDER)
        }else{
            productImgView.image = UIImage(named: IMAGE.PLACEHOLDER)
        }
        imageCV.reloadData()
        updateProductTableviewHeight()
        quantityLbl.text = "1"
        otherProductView.isHidden = (arrOtherData.count == 0)
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickToSelectQuantity(_ sender: UIButton) {
        var arrData = [String]()
        var total = 5
        if productData.product_total_qty_in_count < 5 {
            total = productData.product_total_qty_in_count
        }
        if total > 0 {
            for i in 1...total {
                arrData.append(String(i))
            }
        }
        let dropDown = DropDown()
        dropDown.anchorView = sender
        dropDown.dataSource = arrData
        dropDown.selectionAction = { [unowned self] (dropindex: Int, item: String) in
            self.quantityLbl.text = item
        }
        dropDown.show()
    }
    
    @IBAction func clickToAddToCart(_ sender: Any) {
        if productData.product_total_qty_in_count < Int(quantityLbl.text!)! {
            displayToast("Out of stock")
        }else{
            serviceCallToAddToCart()
        }
    }
    
    @IBAction func clickToBenifitHowUse(_ sender: UIButton) {
        benifitBtn.layer.borderColor = ClearColor.cgColor
        howUseBtn.layer.borderColor = ClearColor.cgColor
        sender.layer.borderColor = BLACK_COLOR.cgColor
        benifitBtn.isSelected = false
        howUseBtn.isSelected = false
        sender.isSelected = true
        if sender == benifitBtn {
            benifitUseTitleLbl.text = "Product Benifits"
            benifitUseValueLbl.text = productData.benifits.html2String
        }else{
            benifitUseTitleLbl.text = "How to Use"
            benifitUseValueLbl.text = productData.how_to_use.html2String
        }
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOtherData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductListTVC = productTbl.dequeueReusableCell(withIdentifier: "ProductListTVC") as! ProductListTVC
        cell.setupDetails(arrOtherData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func updateProductTableviewHeight() {
        constraintHeightProductTbl.constant = CGFloat.greatestFiniteMagnitude
        productTbl.reloadData()
        productTbl.layoutIfNeeded()
        constraintHeightProductTbl.constant = productTbl.contentSize.height
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
    
    func serviceCallToAddToCart() {
        var param = [String : Any]()
        param["product_id"] = productData.id
        param["user_id"] = AppModel.shared.currentUser.id
        param["qty"] = quantityLbl.text
        ProductAPIManager.shared.serviceCallToAddToCart(param) { (dict) in
            
        }
    }
}
